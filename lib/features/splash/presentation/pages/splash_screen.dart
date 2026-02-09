import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/core/theme/theme_imports.dart';

class SplashScreen extends StatefulWidget {
  // When we use const,flutter remembers the widget and doesn't rebuild it when the state or properties hasn't changed, won't relocate new memory to the widget and use the same old one.
  // This improves the performance significantly,reduces workload of garbage collector.

  // {}- this leads to named parameters

  // super.key-> automatically takes key passed to this widget and passes it to the parent widget which is stateful widget in this case.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
// create state- > this is the method that flutter calls the very first time the widget is inserted in the tree
// it only runs once and from that point on, the state object lives on even if the widget itself is rebuilt.

// Why the split is required?>?

// ----> the split is required because the state of the widget can change over time, and we want to keep the logic that manages that state separate from the widget's structure and appearance. By splitting the widget into a StatefulWidget and its corresponding State class, we can ensure that the widget can rebuild itself when necessary without losing its state. The StatefulWidget is responsible for creating the State object, which holds the mutable state and contains the logic for updating that state. This separation allows for better organization and maintainability of the code.
// Widget is cheap and get thrown away and rebuilt constantly, but the state is expensive and stays in memory.
class _SplashScreenState extends State<SplashScreen> {
  @override
  // init state --> It is the very thing that happens when your state object is created
  // super.initState() -> this is calling the initState method of the parent class, which is State<SplashScreen>. This is necessary to ensure that any initialization logic defined in the parent class is executed before we add our own initialization logic in the _SplashScreenState class. It is a common practice to call the super method when overriding lifecycle methods in Flutter to maintain the integrity of the widget's lifecycle and ensure that all necessary setup is performed correctly.
  // _navigateToNext() -> this is a custom method defined in the _SplashScreenState class that is responsible for navigating to the next screen after a certain duration. It uses the Timer class from the dart:async library to delay the navigation by a specified duration (in this case, 1 second). When the timer completes, it checks if the widget is still mounted (i.e., it is still part of the widget tree) and then uses the context.go() method from the go_router package to navigate to the onBoarding route defined in RouteConstants.
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // using const here because the duration is not changing and it is a compile time constant, so we can use const to improve performance by avoiding unnecessary object creation.
    // (){...} this is anonymouse function

    // if(mounted)->
    //The Problem: What if the user closes the app or hits the "back" button before the 1 second is up? The Timer will still fire. If you try to navigate using a context that no longer exists in the tree, your app will crash with a "Looking up a deactivated widget's ancestor" error.

    // The Fix: mounted is a boolean property provided by the State class. It is true if the widget is currently on the screen and false if it has been removed. This check ensures you only navigate if the Splash Screen is still visible
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    // context: This tells the router where you are currently in the app's "family tree."

    context.go(RouteConstants.onBoarding);
  }

  @override
  //BuildContext context is essentially a "Where am I?" locator. It tells Flutter exactly where a specific widget sits within the entire widget tree.
  //Because the context knows its position, it can look up the tree to find information from its ancestors.
  //Flutter passes the context into the build method because you cannot build a widget in a vacuum. To build a Container, Flutter needs to know the environment (the theme, the screen size, the text direction) that only the context can provide.
  Widget build(BuildContext context) {
    // The Scaffold is designed with specific "slots" where you can place widgets. Here are the
    // e.g- appBar,body,drawer,bgcolor

    // why scaffold is important-
    //Handles Keyboard Overlaps: When a user taps a text field, the keyboard pops up. The Scaffold can automatically resize its body so the keyboard doesn't cover your input fields.
    //Manages "Safe Areas": It helps ensure your content doesn't get cut off by phone notches or the "home bar" on modern iPhones.
    // Material Design Standards: It automatically applies correct spacing, shadows, and transitions that make an app feel "native" to Android and iOS.
    return Scaffold(
      body: Container(
        decoration: AppColors.backgroundGradient,
        // SafeArea is a widget that ensures your app's content is positioned within the "visible" parts of a device's screen.

        //It automatically adds enough padding to prevent your UI from being obscured by hardware features like notches, camera holes, or system status bars (the area where the clock and battery icon live).
        child: SafeArea(
          child: Center(
            //In Flutter, the Stack widget allows you to place multiple children on top of each other. Think of it like a deck of cards or layers in Photoshop—the first widget in the list is the bottom layer, and subsequent widgets are painted over it.
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  IconsAssets.circleBackground,
                  width: AppDimensions.icon5XHuge,
                ),
                SvgPicture.asset(
                  IconsAssets.logo,
                  width: AppDimensions.logoWidth,
                  height: AppDimensions.logoHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
