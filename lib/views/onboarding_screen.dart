import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final Widget? ctaTrailingIcon;

  const OnboardingScreen({super.key, this.ctaTrailingIcon});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      "title": "Task Management & To-Do List",
      "description": "This productive tool is designed to help you better manage your task project-wise conveniently!"
    },
    // {
    //   "title": "Fast",
    //   "description": "Experience fast performance"
    // },
    // {
    //   "title": "Secure",
    //   "description": "Your data is safe"
    // },
  ];

  Future<void> _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pages[index]["title"]!,
                  textAlign: TextAlign.center,
                  style: AppTheme.headingStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w800
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  pages[index]["description"]!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                if (index == pages.length - 1)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(AppTheme.lavender),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(""),
                          Text("Let's Start"),
                          if (widget.ctaTrailingIcon != null) ...[
                            widget.ctaTrailingIcon!,
                          ],
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}