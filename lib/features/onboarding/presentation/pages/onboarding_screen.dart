import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routiner/core/constants/app_constants.dart';
import 'package:routiner/core/constants/route_constants.dart';
import 'package:routiner/core/theme/theme_imports.dart';
import 'package:routiner/core/utils/extensions.dart';
import 'package:routiner/core/widgets/custom/custom_button.dart';
import 'package:routiner/features/onboarding/presentation/widgets/onboarding_item.dart';

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

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int _currentPage = 0;

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
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (content, index) {
                      return OnboardingItem(
                        title: onboardingData[index]['title']!,
                        description: onboardingData[index]['description']!,
                        icon: onboardingData[index]['image']!,
                      );
                    },
                  ),

                  Positioned(
                    right: 0,
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
            // ],
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
        children: List.generate(onboardingData.length, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
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
            context.go('/welcome_screen');
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
