# User Setup & Step 3 (Wake Up) — Errors and Fixes

This document summarizes the errors encountered during development of the user setup flow (especially Step 3 wake-up time picker), their causes, and how they were resolved.

---

## 1. Step 1 Profile — Invalid Dart Syntax & Type Mismatch

### What you saw
- Code like `[{name:'Male',icon:Icons.male}, ...].map((g)=>GenderCard(g)).toList()` in the step 1 profile screen.
- Build or runtime errors; `GenderCard` not receiving the expected type.

### Root cause
- **Wrong syntax:** `{name:'Male', icon:Icons.male}` is JavaScript/JSON-style. In Dart, map keys must be quoted strings (e.g. `{'name': 'Male', 'icon': Icons.male}`), and a list of maps is not the right shape for building widgets.
- **Type mismatch:** `GenderCard` was defined as `GenderCard(String gender)` but was being passed a map (or would be, with correct Dart maps).
- **Missing comma:** After the `children` list in `GridView.count` there was no comma before the closing `)`.
- **Invalid Icons:** `Icons.other_gender` and `Icons.question_mark` are not in Flutter’s `Icons` set.

### How it was fixed
- Replaced the map list with explicit widget calls: `GenderCard(label: 'Male', icon: Icons.male)`, etc.
- Updated `GenderCard` to take named parameters: `GenderCard({required String label, required IconData icon})` and built a proper selectable card (border, icon, label, `setState` on tap).
- Added the missing comma after the `children` list.
- Swapped invalid icons for valid ones: `Icons.transgender`, `Icons.help_outline`.

---

## 2. UserSetupScreen — Clicking “Next” / “Previous” Didn’t Rebuild

### What you saw
- Tapping “Next” or “Previous” did nothing; the step and progress indicator did not change.

### Root cause
- **StatelessWidget + local variable:** `UserSetupScreen` was a `StatelessWidget`. `currentStep` was a **local variable** inside `build()` (e.g. `int currentStep = 0`).
- **No state, no rebuild:** `nextStep()` and `previousStep()` only did `currentStep++` / `currentStep--` on that local variable. No `setState` was ever called, so Flutter had no reason to rebuild the widget tree.

### How it was fixed
- Converted `UserSetupScreen` to a **StatefulWidget**.
- Stored `currentStep` in the **State** (e.g. `int currentStep = 0` in `_UserSetupScreenState`).
- In `nextStep()` and `previousStep()`, called **`setState(() => currentStep++;)`** and **`setState(() => currentStep--;)`** so the UI rebuilds and shows the correct step and progress.

---

## 3. RenderFlex Overflow (e.g. “Overflowed by 99391 pixels on the bottom”)

### What you saw
- Red overflow stripes on the bottom of the screen.
- Console: “A RenderFlex overflowed by … pixels on the bottom.”

### Root cause
- The **step content** (e.g. `Step3Wakeup`) was a direct **child of a `Column`** without being given a bounded height.
- The `Column` gave its middle child **unbounded height** (infinite max height). The step’s content (and/or the scroll wheels inside it) then tried to take more space than the screen, causing the `Column` (a `RenderFlex`) to overflow.

### How it was fixed
- Wrapped the step content in **`Expanded`** so it only uses the space **between** the header and the bottom buttons.
- Wrapped the step content in **`SingleChildScrollView`** so if the content is taller than that space, it scrolls instead of overflowing.
- Replaced the multiple `if (currentStep == 0) ... else SizedBox.shrink()` branches with a single **`_buildStepContent()`** that returns the correct step widget (e.g. via a `switch (currentStep)`).

---

## 4. “Tried to build dirty widget in the wrong build scope”

### What you saw
- Console: “Tried to build dirty widget in the wrong build scope.”
- Sometimes happened when interacting with the time picker or changing steps.

### Root cause
- The time picker’s **`onTimeChanged`** callback was calling **`setState`** on the parent (`Step3Wakeup`) from a **child callback** that could run **during build or layout** (e.g. when the scroll controller attached or when the list reported the selected item).
- Calling `setState` during the wrong phase of the frame can mark a widget dirty while the framework is still building the tree, leading to “wrong build scope” assertions.

### How it was fixed
- In `Step3Wakeup`, the **`onTimeChanged`** handler no longer calls `setState` directly. Instead it:
  - Schedules the update with **`WidgetsBinding.instance.addPostFrameCallback((_) { ... })`** so the callback runs **after** the current frame.
  - Calls **`setState`** only if **`mounted`** is still true (so we never update after the widget is removed from the tree).

---

## 5. FixedExtentScrollController.selectedItem — “Cannot be accessed before a scroll view is built”

### What you saw
- Assertion: **“FixedExtentScrollController.selectedItem cannot be accessed before a scroll view is built with it.”**
- Stack trace pointed at `_ScrollTimePickerState._notifyTime` and `initState`.

### Root cause
- In **`_ScrollTimePickerState.initState()`** we called **`_notifyTime()`**.
- **`_notifyTime()`** reads **`_hourController.selectedItem`**, **`_minuteController.selectedItem`**, and **`_amPmController.selectedItem`**.
- In `initState`, the **`ListWheelScrollView`** widgets are **not built yet**, so the controllers do **not** have any scroll positions attached. The framework therefore asserts that `selectedItem` must not be read until the scroll view is built.

### How it was fixed
- **Removed** the **`_notifyTime()`** call from **`initState`**. The parent already has the initial time; we only need to notify when the **user scrolls** (via `onSelectedItemChanged`).
- In **`_notifyTime()`**, added a **guard**: only read **`selectedItem`** if **`_hourController.hasClients`**, **`_minuteController.hasClients`**, and **`_amPmController.hasClients`** are true, so we never read before the scroll views are built.

---

## 6. InheritedElement — “Dependent is not our descendant” / Duplicate GlobalKey / _dependents.isEmpty

### What you saw
- **“The following assertion was thrown … 'dependent is not our descendant'”** (in `InheritedElement.notifyClients`).
- **“_dependents.isEmpty: is not true.”**
- **“Duplicate GlobalKey detected in widget tree.”**
- **“_elements.contains(element): is not true.”**
- Often when changing steps (e.g. from Step 3 to Step 4) or when the time picker triggered updates.

### Root cause
- When the **step index changed**, the **same slot** in the tree was **reused** for a **different widget** (e.g. `Step3Wakeup` replaced by `Step4Reflection`). Flutter tried to **update** the existing element subtree.
- Some **descendants** of the old step (e.g. widgets that depend on **Theme** or **DefaultTextStyle** from an `InheritedWidget` higher up) were still **registered as dependents** of that ancestor. After the step content was swapped, those dependents were **no longer under** that ancestor in the tree, so the framework’s “dependent must be a descendant” check failed.
- That **tree inconsistency** then led to **duplicate GlobalKey** and **element set** assertions.

### How it was fixed
- **KeyedSubtree:** Wrapped the step content in **`KeyedSubtree(key: ValueKey<int>(currentStep), child: _buildStepContent())`**. When **`currentStep`** changes, the **key** changes, so Flutter **disposes** the entire previous step’s subtree and **builds a new one**. No more “update in place” of step content, so no stale dependents.
- **Deferring callbacks:** In the time picker:
  - **`_notifyTime()`** schedules **`widget.onTimeChanged(...)`** inside **`addPostFrameCallback`** so we never notify the parent during build/layout.
  - **`_WheelColumn`** scroll listener and **`onSelectedItemChanged`** both defer **`onSelectedIndexChanged`** with **`addPostFrameCallback`** and a **`mounted`** check, so we never trigger parent updates during layout.

---

## 7. ListWheelScrollView — “perspective > 0” assertion

### What you saw
- **“‘package:flutter/src/widgets/list_wheel_scroll_view.dart': Failed assertion: line 638 pos 15: 'perspective > 0': is not true.”**
- Happened after setting **`perspective: 0`** to get a flat, 2D wheel.

### Root cause
- **`ListWheelScrollView`** in Flutter **requires** **`perspective > 0`**. The implementation uses it in calculations that assume a positive value; **0** is explicitly disallowed by an assertion.

### How it was fixed
- Kept the wheel **visually flat** by using a **very large `diameterRatio`** (e.g. **10000**) and set **`perspective`** to a **tiny positive value** (e.g. **`0.0001`**) instead of **0**. The wheel still looks 2D but satisfies the assertion.

---

## Summary table

| # | Error / symptom | Main cause | Fix in short |
|---|----------------------------------|----------------------------------------|----------------------------------------------|
| 1 | Invalid Dart / type mismatch (Step 1) | JS-style maps, wrong GenderCard API, bad Icons | Use Dart widgets and named params; fix Icons; add comma. |
| 2 | Next/Previous doesn’t change step | StatelessWidget + local `currentStep` | StatefulWidget + `setState` in next/previous. |
| 3 | RenderFlex overflow (99391 px) | Unbounded height for step content in Column | Expanded + SingleChildScrollView around step content. |
| 4 | Wrong build scope | setState from child during build/layout | addPostFrameCallback + mounted check for parent setState. |
| 5 | selectedItem before scroll view built | _notifyTime() in initState reading selectedItem | Remove _notifyTime from initState; guard with hasClients. |
| 6 | Dependent not descendant / GlobalKey / elements | Step content updated in place, stale InheritedWidget dependents | KeyedSubtree(key: ValueKey(currentStep)); defer picker callbacks. |
| 7 | perspective > 0 assertion | perspective: 0 not allowed | perspective: 0.0001 (still looks 2D). |

---

## Good practices applied

1. **State in StatefulWidget:** Keep mutable UI state (e.g. `currentStep`, selected time) in **State** and use **`setState`** so the framework rebuilds.
2. **Bounded layout:** Avoid unbounded height in **Column**/**Row** by using **Expanded**/**Flexible** or **ScrollView** where needed.
3. **Don’t read controller before attach:** Don’t use **`selectedItem`** (or similar) on scroll controllers until the scrollable is built (**hasClients**).
4. **Defer callbacks out of build/layout:** Use **`WidgetsBinding.instance.addPostFrameCallback`** when a child must notify the parent (e.g. time picker → step), and check **`mounted`** before **`setState`**.
5. **Stable keys when swapping content:** Use **KeyedSubtree** with **ValueKey(stepIndex)** when switching between different step widgets so the old subtree is disposed and the new one is built cleanly.
6. **Respect framework assertions:** Use **perspective > 0** for **ListWheelScrollView** and achieve “flat” look with **diameterRatio** and a small **perspective** value.

If you hit any of these errors again (e.g. after refactors), this doc can serve as a checklist for causes and fixes.
