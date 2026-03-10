import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/theme/first_onboarding_decoration.dart' show FirstOnboardingDecorations;
import 'package:todo_list/utils/app_background.dart';
import 'package:todo_list/views/home/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageData {
  final Widget? decoration;
  final String title;
  final String description;

  const OnboardingPageData({
    this.decoration,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  final Widget Function()? ctaTrailingIconBuilder;

  const OnboardingScreen({
    super.key,
    this.ctaTrailingIconBuilder,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      decoration: FirstOnboardingDecorations(),
      title: 'Task Management &\n To-Do List',
      description:
          'This productive tool is designed to help\n you better manage your task\n project-wise conveniently!',
    ),
    // OnboardingPageData(
    //   title: 'Fast',
    //   description: 'Experience fast performance',
    // ),
    // OnboardingPageData(
    //   title: 'Secure',
    //   description: 'Your data is safe',
    // ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setBool('seenOnboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = pages[index];

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            if (page.decoration != null) page.decoration!,
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: AppTheme.onboardingTitle,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              page.description,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            if (index == pages.length - 1)
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(AppTheme.themeLavender),
                                  shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  padding: WidgetStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                ),
                                onPressed: _finishOnboarding,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "Let's Start",
                                          style: AppTheme.buttonText.copyWith(
                                            color: AppTheme.themeWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (widget.ctaTrailingIconBuilder != null)
                                      widget.ctaTrailingIconBuilder!(),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
