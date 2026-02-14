import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/constants_imports.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/onboarding/presentation/widgets/onboarding_item.dart';

//final
// once a final variable is assigned a value,it is immutable and prevents accidental overwrite bugs
// final vs const diff ---> const is required to know during the compile-time but final can be set when the app is running.

// list is an array of ordered collections of objects
//String, int, bool, and even Map are all considered Objects. They are all children of the same "parent" called Object.

// < ... > --> Provide type-safing to the code.

// map --> collection of  (key-value ) pairs. Map.key cant be accesed instead use Map["key"];
// here both key - value are strings itself.

final List<Map<String, String>> onboardingData = [
  {
    "image": "assets/icons/onboarding/routiner-onboarding-bg-1.svg",
    "title": "track your goal",
    "description":
        "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals.",
  },
  {
    "image": "assets/icons/onboarding/routiner-onboarding-bg-2.svg",

    "title": "get burn",
    "description":
        "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
  },
  {
    "image": "assets/icons/onboarding/routiner-onboarding-bg-3.svg",

    "title": "eat well ",
    "description":
        "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
  },
  {
    "image": "assets/icons/onboarding/routiner-onboarding-bg-4.svg",

    "title": "morning yoga",
    "description":
        "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun.",
  },
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

// declaration-->creation-->usage-->dispose
class _OnboardingPageState extends State<OnboardingPage> {
  //In Dart, the late keyword is a promise you make to the compiler. You are saying: "I’m not giving this variable a value right now, but I promise I will give it one before I ever try to use it."

  //Without late, Dart's "Null Safety" rules would force you to either give the variable a value immediately or make it nullable (e.g., PageController?).

  //Use late when you know a variable will be initialized in initState.

  //Use late to avoid making variables nullable (?) when they don't need to be.

  //Use late for expensive operations you only want to run if they are actually needed.

  //
  //If the PageController is the "remote control," the PageView is the Television Screen.

  // It does three things :-
  // 1. Initialization (decides which page the app shows first can be 2 also.)
  // 2. Observation - (It listens to the user's swipe and tells you exactly how far they have scrolled (e.g., "The user is 50% between page 1 and page 2").)
  // 3. Manipulation -(It allows you to programmatically change pages (e.g., clicking a "Next" button).)

  //Because the PageController needs to be initialized exactly once when the widget's "State" is born (initState).
  //Why dispose()? Controllers are "listeners." If you don't kill them when the screen is closed, they stay alive in the phone's memory, causing a memory leak.
  late PageController _pageController;
  int _currentPage = 0;

  //By using initState, you ensure that the controller is created exactly once.
  // If you did it in the build method, for example, the controller would be recreated every time the screen flickers or updates, which would cause the scroll position to reset to zero constantly!
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //By default, widgets like Container or Text only take up as much space as they need (this is called "wrap content").
            // If you put them inside a Row, you might end up with a big ugly gap at the end.

            // The most important property of an Expanded widget is flex. It allows you to distribute space proportionally between multiple children.

            // An Expanded widget MUST be a descendant of a Row, Column, or Flex.
            //If you try to put an Expanded inside a Container or directly under the Scaffold,
            //your app will crash with a massive red error screen. This is because Expanded needs a "Parent" that has a main axis
            // (like a Row's width) so it knows what space it is supposed to fill.

            // Expanded vs Flexible
            // Expanded: Forces the child to fill the space. If the child is small, Expanded makes it big.

            //Flexible: Allows the child to take up at most that much space, but if the child is smaller than the space, it's allowed to stay small.
            Expanded(
              //In Flutter, a Stack is a layout widget that allows you to overlay multiple children on top of each other.
              // Unlike a Column or Row which places widgets side-by-side, a Stack positions them in 3D space relative to the screen, where the first widget in the list is at the bottom and the last widget is on top.
              child: Stack(
                children: [
                  //PageView is the scrollable list that works page by page.
                  // Takes all the space given by the parent . When you swipe, it calculates the width of the screen and slides exactly that distance to reveal the next piece of content.
                  // page is build two ways one is pageview for static list and pageview.builder for dynamice list --> dynamice list is much better as it only renders the page that are currently visible. and thats why enhance the performance of the app.
                  PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      //   Here is why using setState inside onPageChanged can be problematic:

                      //1. Triggering Full Subtree Rebuilds
                      //When you call setState in your parent widget, Flutter rebuilds the entire widget and its children.

                      //The Problem: The PageView.builder is already in the middle of an animation. Calling setState forces the PageView itself to rebuild while it's still trying to finish its "snap" animation.

                      //The Result: On lower-end devices, this can cause "jank" (dropped frames) because the CPU is busy rebuilding the whole screen instead of focusing on a smooth 60fps/120fps animation.
                      setState(() {
                        //A. Use a ValueNotifier (The "Lighter" Way)
                        //Instead of a standard int, use a ValueNotifier. This allows you to rebuild only the widgets that care about the index.
                        _currentPage = index;
                      });
                    },
                    //In Flutter, specifically within widgets like ListView.builder or PageView.builder, the itemBuilder is a callback function that tells
                    //Flutter how to build each individual item in your list or slider.

                    //1. The Anatomy of itemBuilder
                    //The itemBuilder always provides you with two pieces of information:

                    //BuildContext context: Tells Flutter where this widget sits in the overall tree.

                    //int index: The specific number of the item currently being built (0, 1, 2, etc.).
                    itemBuilder: (content, index) {
                      return OnboardingItem(
                        title: onboardingData[index]['title']!,
                        description: onboardingData[index]['description']!,
                        icon: onboardingData[index]['image']!,
                      );
                    },
                  ),

                  //In Flutter, Positioned is a widget that controls exactly where a child of a Stack sits.
                  //While a Stack layers widgets on top of each other, the Positioned widget gives you the "GPS coordinates" to move those layers around.

                  // A Positioned widget must be a direct descendant of a Stack. If you try to use it inside a Column or Row, it won't work and will throw an error.
                  Positioned(
                    right: 10,
                    top: 16,
                    child: CustomButton.text(
                      text: AppConstants.skip.toUpperCase(),

                      onPressed: () {
                        context.go(RouteConstants.welcome);
                      },
                    ),
                  ),

                  _buildDots(),
                  _buildNextButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //List.generate is a powerful constructor in Dart used to create a list of a specific length
        // and fill it with values using a "recipe" (a callback function).
        //Small lists (3–10 items) like dots or buttons.
        children: List.generate(onboardingData.length, (index) {
          //AnimatedContainer is an Implicitly Animated Widget. This means you don't need to manage a complex AnimationController or Ticker.
          //You simply change a value, and the widget handles the "tweening" (the frames in between) for you.
          // The Two Required Pieces:
          //duration: How long the animation should take (e.g., Duration(milliseconds: 300)).

          //curve: The "flavor" of the movement (e.g., Curves.bounceOut, Curves.easeInOut).
          return AnimatedContainer(
            // In Flutter, Duration is a simple class that represents a span of time.
            //It doesn't "do" anything on its own; instead, it acts as a timer setting that you give to other widgets or functions
            // to tell them how long they should run.
            duration: const Duration(milliseconds: 300),
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == _currentPage ? 24 : 8,
            decoration: BoxDecoration(
              color: index == _currentPage
                  ? AppColors.primary
                  : AppColors.disabled,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNextButton() {
    return Positioned(
      bottom: 32,
      right: 16,
      child: CustomButton(
        width: AppDimensions.buttonWidthXS,
        bgGradient: AppColors.backgroundGradient.gradient,
        text: "",
        iconLeft: Icon(
          Icons.chevron_right,
          size: AppDimensions.iconSM,
          color: Colors.white,
        ),

        onPressed: () {
          if (_currentPage == onboardingData.length - 1) {
            context.go(RouteConstants.welcome);
            // Navigate to the next screen or perform any action you want
          } else if (_currentPage < onboardingData.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );
  }
}
