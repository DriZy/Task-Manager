import 'package:flutter/material.dart';
import 'package:task_manager/views/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme, // Apply the external theme
      home: SplashScreen(),
    );
  }
}