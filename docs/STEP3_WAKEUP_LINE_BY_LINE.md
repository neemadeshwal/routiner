# Step 3 Wake Up — Line-by-Line Explanation

This document explains every part of **`lib/features/onboarding/presentation/pages/user_setup_slides/step_3_wakeUp.dart`**: what each section does and why it’s there.

---

## Table of contents

1. [Imports (Lines 1–5)](#1-imports-lines-15)
2. [Top-level constants (Lines 7–21)](#2-top-level-constants-lines-721)
3. [Step3Wakeup widget (Lines 22–139)](#3-step3wakeup-widget-lines-22139)
4. [ScrollTimePicker widget (Lines 141–258)](#4-scrolltimepicker-widget-lines-141258)
5. [_WheelColumn widget (Lines 260–349)](#5-_wheelcolumn-widget-lines-260349)

---

## 1. Imports (Lines 1–5)

```dart
import 'package:flutter/material.dart';
import 'package:routiner/core/theme/app_colors.dart';
import 'package:routiner/core/theme/app_dimensions.dart';
import 'package:routiner/core/theme/app_text_styles.dart';
import 'package:routiner/core/widgets/custom/custom_input.dart';
```

| Line(s) | What it does |
|--------|---------------|
| **1** | Flutter Material library: widgets (`Column`, `Row`, `Container`, `Text`, etc.), `StatefulWidget`, `State`, `Theme`, `ListWheelScrollView`, `FixedExtentScrollController`, and framework APIs (`setState`, `mounted`, `WidgetsBinding`). |
| **2** | App color constants (e.g. `AppColors.surface`, `AppColors.inputBorder`, `AppColors.textPlaceholder`, `AppColors.shadow`) used for backgrounds, borders, and text. |
| **3** | App spacing/sizing (e.g. `AppDimensions.space8`, `paddingMD`, `paddingXL`) so layout is consistent and responsive. |
| **4** | App text styles (e.g. `AppTextStyles.appBarTitle`, `AppTextStyles.bodyMedium`) for titles and body text. |
| **5** | Reusable `CustomInput` used at the bottom to show the selected wake-up time. |

---

## 2. Top-level constants (Lines 7–21)

### Picker styling

```dart
/// 2D flat scroll picker styling (no dark bg, no 3D).
const Color _kUnselectedColor = Color(0xFFA1A4B2);
const double _kItemExtent = 52.0;
const double _kPickerCardRadius = 16.0;
const double _kPickerCardElevation = 2.0;
```

| Line(s) | What it does |
|--------|---------------|
| **7** | Doc comment: this picker is 2D, no dark background, no 3D wheel effect. |
| **8** | **`_kUnselectedColor`** — Gray (`#A1A4B2`) for non-selected wheel items. The leading `_` makes it private to this file. |
| **9** | **`_kItemExtent`** — Height of one row in the wheel (52 logical pixels). Used by `ListWheelScrollView` so each item has fixed height and the “selected” row is well defined. |
| **10** | **`_kPickerCardRadius`** — Corner radius (16) for the card that wraps the picker. |
| **11** | **`_kPickerCardElevation`** — Shadow elevation (2) for the picker card. |

### Hour wheel (circular 1–12)

```dart
/// Hour wheel: 1–12 repeating (circular). Use a large list and interpret index % 12.
const int _kHourCycleCount = 101;
const int _kHourItemCount = 12 * _kHourCycleCount;
const int _kHourInitialOffset = 12 * (_kHourCycleCount ~/ 2);
```

| Line(s) | What it does |
|--------|---------------|
| **13** | Doc: hour wheel shows 1–12 in a loop; we use a long list and `index % 12` to get the displayed hour. |
| **14** | **`_kHourCycleCount`** — How many times the sequence 1–12 is repeated (101). More cycles = more “infinite” scroll. |
| **15** | **`_kHourItemCount`** — Total items in the hour list: `12 * 101 = 1212`. Each item label is `(index % 12) + 1`. |
| **16** | **`_kHourInitialOffset`** — Starting index so the wheel opens in the middle of the list (e.g. `12 * 50 = 600`). That way the user can scroll up or down and still see 1 after 12 (circular feel). |

### Minute wheel (circular 0–59)

```dart
/// Minute wheel: 0–59 repeating (circular).
const int _kMinuteCycleCount = 101;
const int _kMinuteItemCount = 60 * _kMinuteCycleCount;
const int _kMinuteInitialOffset = 60 * (_kMinuteCycleCount ~/ 2);
```

| Line(s) | What it does |
|--------|---------------|
| **18** | Doc: minute wheel repeats 0–59. |
| **19** | **`_kMinuteCycleCount`** — Number of 0–59 cycles (101). |
| **20** | **`_kMinuteItemCount`** — Total minute items: `60 * 101 = 6060`. Label is `index % 60` (shown as 00–59). |
| **21** | **`_kMinuteInitialOffset`** — Start index in the middle (e.g. `60 * 50 = 3000`) so scrolling feels circular. |

---

## 3. Step3Wakeup widget (Lines 22–139)

This is the screen widget for “What time do you wake up?”. It holds the selected time and builds the header, the scroll picker card, and the read-only time field.

### Class declaration and constructor

```dart
class Step3Wakeup extends StatefulWidget {
  const Step3Wakeup({super.key});

  @override
  State<Step3Wakeup> createState() => _Step3WakeupState();
}
```

| Line(s) | What it does |
|--------|---------------|
| **22** | Defines the public widget used by `UserSetupScreen` for step 3. |
| **23** | Const constructor; `super.key` forwards the widget key for Flutter’s element tree. |
| **25–26** | `createState()` returns the private `_Step3WakeupState` that holds `_hour`, `_minute`, `_isAm`, and the text controller. |

### State: fields and getter

```dart
class _Step3WakeupState extends State<Step3Wakeup> {
  int _hour = 7; // 1–12
  int _minute = 30;
  bool _isAm = true;
  final TextEditingController _timeDisplayController = TextEditingController();

  String get _formattedTime =>
      '$_hour:${_minute.toString().padLeft(2, '0')} ${_isAm ? 'AM' : 'PM'}';
```

| Line(s) | What it does |
|--------|---------------|
| **29** | **`_Step3WakeupState`** — Private state class; only this file can reference it. |
| **30** | **`_hour`** — Current hour (1–12). Default 7. |
| **31** | **`_minute`** — Current minute (0–59). Default 30. |
| **32** | **`_isAm`** — true = AM, false = PM. Default true. |
| **33** | **`_timeDisplayController`** — Controller for the bottom `CustomInput`; its `.text` is set to the formatted time string. |
| **35–36** | **`_formattedTime`** — Getter that returns a string like `"7:30 AM"` (hour, zero-padded minute, AM/PM). Used to initialize and sync the display field. |

### initState and dispose

```dart
  @override
  void initState() {
    super.initState();
    _timeDisplayController.text = _formattedTime;
  }

  @override
  void dispose() {
    _timeDisplayController.dispose();
    super.dispose();
  }
```

| Line(s) | What it does |
|--------|---------------|
| **38–42** | **`initState()`** — Runs once when the state is created. Sets the display field to the initial time (e.g. `"7:30 AM"`) so the user sees it before scrolling. |
| **44–48** | **`dispose()`** — Disposes the text controller when the widget is removed so we don’t leak or use it after disposal. |

### Time change handler

```dart
  void _onTimeChanged(int hour, int minute, bool isAm) {
    if (!mounted) return;
    setState(() {
      _hour = hour;
      _minute = minute;
      _isAm = isAm;
      _timeDisplayController.text = '$_hour:${_minute.toString().padLeft(2, '0')} ${_isAm ? 'AM' : 'PM'}';
    });
  }
```

| Line(s) | What it does |
|--------|---------------|
| **50** | **`_onTimeChanged`** — Called when the user scrolls the picker (via a post-frame callback from `ScrollTimePicker`). |
| **51** | **`if (!mounted) return`** — Avoids calling `setState` if the widget has already been removed from the tree (e.g. user left the step). |
| **52–57** | **`setState`** — Updates `_hour`, `_minute`, `_isAm` and the controller’s text so the UI and the bottom field stay in sync. |

### build(): theme and Column

```dart
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: AppDimensions.space8),
```

| Line(s) | What it does |
|--------|---------------|
| **59–61** | **`build`** — Builds the step UI. **`theme`** is used later for the primary color on the input’s focused border. |
| **62–65** | **`Column`** — Stacks the header, picker card, and input vertically. **`crossAxisAlignment: CrossAxisAlignment.start`** aligns them to the start (left in LTR). **`mainAxisSize: MainAxisSize.min`** makes the column only as tall as its children (no extra space). |
| **66** | Top spacing before the header row. |

### build(): header Row

```dart
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What time do you wake up?",
                    style: AppTextStyles.appBarTitle,
                  ),
                  SizedBox(height: AppDimensions.space4),
                ],
              ),
            ),
          ],
        ),
```

| Line(s) | What it does |
|--------|---------------|
| **67–69** | **`Row`** — Puts the title (and optional subtitle) in a row. **`crossAxisAlignment: CrossAxisAlignment.center`** vertically centers the content. |
| **71** | Horizontal space (e.g. after an optional leading icon). |
| **72–85** | **`Expanded`** + **`Column`** — Takes remaining horizontal space. **`Column`** contains the title and a small gap. **`Text`** uses **`AppTextStyles.appBarTitle`** for “What time do you wake up?”. **`SizedBox(height: AppDimensions.space4)`** adds a small gap (e.g. before a subtitle if you add one). |

### build(): picker card (Material + Container + ScrollTimePicker)

```dart
        SizedBox(height: AppDimensions.space24),
        Material(
          elevation: _kPickerCardElevation,
          shadowColor: AppColors.shadow,
          borderRadius: BorderRadius.circular(_kPickerCardRadius),
          color: AppColors.surface,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMD,
              vertical: AppDimensions.paddingXL,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_kPickerCardRadius),
              color: Colors.grey.shade100,
              border: Border.all(
                color: AppColors.inputBorder,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_kPickerCardRadius - 4),
              child: ScrollTimePicker(
                initialHour: _hour,
                initialMinute: _minute,
                initialIsAm: _isAm,
                onTimeChanged: (hour, minute, isAm) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _onTimeChanged(hour, minute, isAm);
                  });
                },
              ),
            ),
          ),
        ),
```

| Line(s) | What it does |
|--------|---------------|
| **87** | Space between header and the picker card. |
| **88** | **`Material`** — Gives the card elevation (shadow), rounded corners, and a surface color so it looks like a card. |
| **89–92** | **`elevation`** / **`shadowColor`** — Light shadow. **`borderRadius`** uses **`_kPickerCardRadius`**. **`color`** is **`AppColors.surface`**. |
| **93–96** | **`Container`** — Adds padding (horizontal and vertical) and an inner decoration. |
| **97–105** | **`decoration`** — Same border radius, **`Colors.grey.shade100`** for the inner background, and a 1px border with **`AppColors.inputBorder`**. |
| **106–108** | **`ClipRRect`** — Clips the **`ScrollTimePicker`** to rounded corners so the wheel doesn’t draw outside. |
| **109–117** | **`ScrollTimePicker`** — Receives current **`_hour`**, **`_minute`**, **`_isAm`** as initial values and **`onTimeChanged`**. The callback is wrapped in **`WidgetsBinding.instance.addPostFrameCallback`** so we don’t call **`_onTimeChanged`** (and thus **`setState`**) during build/layout; we run it after the frame. That avoids “wrong build scope” and similar errors. |

### build(): bottom CustomInput

```dart
        SizedBox(height: AppDimensions.paddingXL),
        CustomInput(
          label: "Your wake up time",
          hint: "Selected time appears here",
          controller: _timeDisplayController,
          readOnly: true,
          autoFocus: true,
          iconLeft: Icon(
            Icons.access_time_rounded,
            size: 20,
            color: AppColors.textPlaceholder,
          ),
          borderColor: AppColors.inputBorder,
          focusedBorderColor: theme.colorScheme.primary,
        ),
      ],
    );
  }
}
```

| Line(s) | What it does |
|--------|---------------|
| **122** | Space between picker card and the input. |
| **123** | **`CustomInput`** — Read-only field that shows the selected time. |
| **124–125** | **`label`** / **`hint`** — Shown above and inside the field. |
| **126** | **`controller`** — **`_timeDisplayController`**; its **`.text`** is updated in **`_onTimeChanged`** so the field always shows the current time. |
| **127** | **`readOnly: true`** — User can’t type; field is display-only. |
| **128** | **`autoFocus: true`** — Field can take focus when the step appears (optional; you may set to **false** to avoid keyboard). |
| **129–133** | **`iconLeft`** — Clock icon on the left, placeholder color, size 20. |
| **134–135** | **`borderColor`** / **`focusedBorderColor`** — Normal border and primary-colored border when focused. |
| **136–139** | Closes **`children`**, **`Column`**, **`build`**, and **`_Step3WakeupState`**. |

---

## 4. ScrollTimePicker widget (Lines 141–258)

Reusable widget that draws three scroll wheels (hour, minute, AM/PM) and reports the selected time via **`onTimeChanged`**.

### Class declaration and parameters

```dart
class ScrollTimePicker extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final bool initialIsAm;
  final void Function(int hour, int minute, bool isAm) onTimeChanged;

  const ScrollTimePicker({
    super.key,
    this.initialHour = 7,
    this.initialMinute = 30,
    this.initialIsAm = true,
    required this.onTimeChanged,
  });

  @override
  State<ScrollTimePicker> createState() => _ScrollTimePickerState();
}
```

| Line(s) | What it does |
|--------|---------------|
| **141** | Public widget; can be reused anywhere a time picker is needed. |
| **142–144** | **`initialHour`** (1–12), **`initialMinute`** (0–59), **`initialIsAm`** — Starting values for the three wheels. |
| **145** | **`onTimeChanged`** — Callback invoked when the user changes the selection; receives **hour**, **minute**, **isAm**. |
| **147–154** | Constructor with defaults and **required** **`onTimeChanged`**. |
| **156–157** | **`createState`** returns **`_ScrollTimePickerState`**. |

### State: controllers in initState

```dart
class _ScrollTimePickerState extends State<ScrollTimePicker> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _amPmController;

  @override
  void initState() {
    super.initState();
    _hourController = FixedExtentScrollController(
      initialItem: _kHourInitialOffset + (widget.initialHour - 1).clamp(0, 11),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _kMinuteInitialOffset + widget.initialMinute.clamp(0, 59),
    );
    _amPmController = FixedExtentScrollController(
      initialItem: widget.initialIsAm ? 0 : 1,
    );
  }
```

| Line(s) | What it does |
|--------|---------------|
| **159–161** | **`late`** scroll controllers — created in **`initState`**, so not nullable. **`FixedExtentScrollController`** is used with **`ListWheelScrollView`** so we can set **initialItem** and read **selectedItem**. |
| **165–167** | **Hour controller** — **initialItem** is **`_kHourInitialOffset + (hour - 1)`** so the list opens at the right hour in the “middle” cycle (e.g. 7 → index 606). **clamp(0, 11)** keeps hour in 1–12 range. |
| **168–170** | **Minute controller** — **initialItem** is **`_kMinuteInitialOffset + minute`** (e.g. 30 → 3030). **clamp(0, 59)** keeps minute valid. |
| **171–173** | **AM/PM controller** — Only 2 items: 0 = AM, 1 = PM. **initialItem** is 0 or 1 from **initialIsAm**. |

We do **not** call **`_notifyTime()`** in **initState** because **selectedItem** is not valid until the scroll view is built; that would trigger the “cannot be accessed before a scroll view is built” assertion.

### _notifyTime and dispose

```dart
  void _notifyTime() {
    if (!_hourController.hasClients ||
        !_minuteController.hasClients ||
        !_amPmController.hasClients) return;
    final hour = (_hourController.selectedItem % 12) + 1;
    final minute = _minuteController.selectedItem % 60;
    final isAm = _amPmController.selectedItem == 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTimeChanged(hour, minute, isAm);
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _amPmController.dispose();
    super.dispose();
  }
```

| Line(s) | What it does |
|--------|---------------|
| **178–181** | **Guard** — **hasClients** is true only after the scroll view has attached the controller. If any controller isn’t attached, we return and don’t read **selectedItem**. |
| **182–184** | **hour** = **selectedItem % 12 + 1** (1–12). **minute** = **selectedItem % 60** (0–59). **isAm** = true when selected index is 0. |
| **185–187** | **addPostFrameCallback** — Calls **onTimeChanged** after the current frame so we don’t trigger parent **setState** during build/layout. |
| **191–196** | **dispose** — Disposes all three controllers to avoid leaks. |

### build(): Container, Stack, Row of wheels

```dart
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: _WheelColumn(
                  controller: _hourController,
                  itemCount: _kHourItemCount,
                  itemBuilder: (index) => '${(index % 12) + 1}',
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
              Expanded(
                child: _WheelColumn(
                  controller: _minuteController,
                  itemCount: _kMinuteItemCount,
                  itemBuilder: (index) => (index % 60).toString().padLeft(2, '0'),
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
              Expanded(
                child: _WheelColumn(
                  controller: _amPmController,
                  itemCount: 2,
                  itemBuilder: (index) => index == 0 ? 'AM' : 'PM',
                  onSelectedIndexChanged: (_) => _notifyTime(),
                ),
              ),
            ],
          ),
```

| Line(s) | What it does |
|--------|---------------|
| **199–200** | **primaryColor** — Used for the selection frame and (in **\_WheelColumn**) for selected text. |
| **201–206** | **Container** — Fixed **height: 220** so the picker has a known size. **color: Colors.transparent** so the card background shows through. |
| **207** | **Stack** — Puts the row of wheels behind and the selection frame on top. |
| **209** | **Row** — Three columns side by side. |
| **211–219** | **First Expanded** — Hour **\_WheelColumn**: **itemCount** **\_kHourItemCount**, **itemBuilder** returns **"1"** … **"12"** via **`(index % 12) + 1`**. **onSelectedIndexChanged** calls **\_notifyTime()** so the parent gets the new time. |
| **221–228** | **Second Expanded** — Minute **\_WheelColumn**: **itemCount** **\_kMinuteItemCount**, labels **"00"**–**"59"** via **`(index % 60).padLeft(2, '0')`**. |
| **230–236** | **Third Expanded** — AM/PM **\_WheelColumn**: 2 items, **"AM"** / **"PM"**. |

### build(): selection frame overlay

```dart
          IgnorePointer(
            child: Center(
              child: Container(
                height: _kItemExtent,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: primaryColor.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

| Line(s) | What it does |
|--------|---------------|
| **238** | **IgnorePointer** — The frame is not interactive; touches go through to the wheels below. |
| **239** | **Center** — Puts the frame in the vertical center of the 220px container. |
| **240–248** | **Container** — Height **\_kItemExtent** (52) so it matches one wheel row. **decoration** is a rounded rectangle with a border using **primaryColor** at 40% opacity and width 1.5. This draws the “selected row” highlight over the wheels. |
| **249–258** | Closes **Stack**, **Container**, **build**, and **\_ScrollTimePickerState**. |

---

## 5. _WheelColumn widget (Lines 260–349)

Private widget that wraps a single **ListWheelScrollView** (one column of the picker). It keeps **\_selectedIndex** in sync with the controller and notifies the parent when the selection changes.

### Class declaration and parameters

```dart
class _WheelColumn extends StatefulWidget {
  final FixedExtentScrollController controller;
  final int itemCount;
  final String Function(int index) itemBuilder;
  final ValueChanged<int> onSelectedIndexChanged;

  const _WheelColumn({
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    required this.onSelectedIndexChanged,
  });

  @override
  State<_WheelColumn> createState() => _WheelColumnState();
}
```

| Line(s) | What it does |
|--------|---------------|
| **260** | **\_WheelColumn** — Private; only used inside this file. |
| **261** | **controller** — **FixedExtentScrollController** for this list. |
| **262** | **itemCount** — Number of items (e.g. 1212 for hours, 6060 for minutes, 2 for AM/PM). |
| **263** | **itemBuilder** — Function that returns the label string for a given index. |
| **264** | **onSelectedIndexChanged** — Callback with the new selected index when the user scrolls. |
| **266–270** | Constructor with all four parameters **required**. |
| **272–273** | **createState** returns **\_WheelColumnState**. |

### State: initState, didUpdateWidget, dispose

```dart
class _WheelColumnState extends State<_WheelColumn> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.controller.initialItem;
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(_WheelColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }
```

| Line(s) | What it does |
|--------|---------------|
| **275** | **\_selectedIndex** — Index of the row that is currently “selected” (centered); used to style that row (e.g. primary color, larger font). |
| **278–281** | **initState** — Sets **\_selectedIndex** from **controller.initialItem** and adds **\_onScroll** as a listener so we react to scroll position changes. |
| **284–290** | **didUpdateWidget** — If the widget is rebuilt with a different **controller**, we remove the listener from the old one and add it to the new one. |
| **293–296** | **dispose** — Removes the scroll listener so we don’t call **setState** or callbacks after the widget is disposed. |

### _onScroll

```dart
  void _onScroll() {
    if (!widget.controller.hasClients) return;
    final index = widget.controller.selectedItem;
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) widget.onSelectedIndexChanged(index);
      });
    }
  }
```

| Line(s) | What it does |
|--------|---------------|
| **298** | **\_onScroll** — Called when the scroll position changes (controller listener). |
| **299** | **hasClients** check — Don’t read **selectedItem** until the scroll view is attached. |
| **300** | **index** — Current centered item from **selectedItem**. |
| **301–305** | If the index changed: **setState** to update **\_selectedIndex** (so the right row is styled), then **addPostFrameCallback** to call **onSelectedIndexChanged** after the frame and only if **mounted**. This avoids “wrong build scope” and updating after dispose. |

### build(): ListWheelScrollView

```dart
  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: widget.controller,
      itemExtent: _kItemExtent,
      diameterRatio: 10000,
      perspective: 0.0001,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        if (index != _selectedIndex) {
          setState(() => _selectedIndex = index);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) widget.onSelectedIndexChanged(index);
          });
        }
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.itemCount,
        builder: (context, index) {
          final isSelected = index == _selectedIndex;
          final primaryColor = Theme.of(context).colorScheme.primary;
          return Center(
            child: Text(
              widget.itemBuilder(index),
              style: TextStyle(
                color: isSelected ? primaryColor : _kUnselectedColor,
                fontSize: isSelected ? 26 : 18,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          );
        },
      ),
    );
  }
}
```

| Line(s) | What it does |
|--------|---------------|
| **311** | **ListWheelScrollView.useDelegate** — Uses a delegate to build children on demand (needed for large **itemCount** like 1212 or 6060). |
| **312** | **controller** — This wheel’s **FixedExtentScrollController**. |
| **313** | **itemExtent** — **\_kItemExtent** (52) so each row has fixed height. |
| **314** | **diameterRatio: 10000** — Makes the wheel look almost flat (2D) instead of curved. |
| **315** | **perspective: 0.0001** — Very small value so the list looks flat; must be &gt; 0 for the framework assertion. |
| **316** | **FixedExtentScrollPhysics** — Snaps to item boundaries. |
| **317–324** | **onSelectedItemChanged** — When the centered item changes we update **\_selectedIndex** and, in a post-frame callback, call **onSelectedIndexChanged** if still **mounted**. |
| **325–326** | **ListWheelChildBuilderDelegate** — **childCount** from the widget; **builder** is called per index. |
| **327–328** | **isSelected** — true when this index is the centered row. **primaryColor** for selected text. |
| **329–339** | **Center** + **Text** — Label from **itemBuilder(index)**. **Text** style: selected = primary color, 26px, w600; unselected = **\_kUnselectedColor**, 18px, w400. |
| **340–349** | Closes **builder**, **childDelegate**, **ListWheelScrollView**, **build**, and **\_WheelColumnState**. |

---

## Data flow summary

1. **Step3Wakeup** holds **\_hour**, **\_minute**, **\_isAm** and **\_timeDisplayController**.
2. **ScrollTimePicker** gets initial values and **onTimeChanged**. It creates three **FixedExtentScrollController**s and three **\_WheelColumn**s.
3. When the user scrolls a wheel, **\_WheelColumn** updates **\_selectedIndex** and, via **addPostFrameCallback**, calls **onSelectedIndexChanged** → **\_notifyTime()** (in **ScrollTimePicker**) which reads **selectedItem** (with **hasClients** check), computes hour/minute/isAm, and calls **widget.onTimeChanged** again inside **addPostFrameCallback**.
4. **Step3Wakeup**’s callback runs **\_onTimeChanged**, which **setState**s **\_hour**, **\_minute**, **\_isAm** and **\_timeDisplayController.text**, so the bottom **CustomInput** shows the new time.

Using **addPostFrameCallback** and **mounted** / **hasClients** throughout avoids calling **setState** or reading **selectedItem** at the wrong time and prevents the errors described in **USER_SETUP_STEP3_ERRORS_AND_FIXES.md**.
