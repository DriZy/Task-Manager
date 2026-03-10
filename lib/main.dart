import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/views/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: AppTheme.lightTheme,
      home: OnboardingScreen(
        ctaTrailingIconBuilder: () => SvgPicture.asset(
          'assets/icons/arrow_right_icon.svg',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
