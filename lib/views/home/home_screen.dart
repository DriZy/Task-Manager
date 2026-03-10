import 'package:flutter/material.dart';
import 'package:todo_list/utils/app_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        blobs: [
          GradientBlob(color: const Color(0xFFEDF046), topFraction: 0.20, rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46F080), topFraction: -0.15,  leftFraction:  -0.25),
          GradientBlob(color: const Color(0xFF2555FF), bottomFraction: -0.15,  rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46BDF0), bottomFraction: 0.15,  leftFraction:  -0.35),
        ],
        child: SafeArea(
          child: Center(
            child: Text(
              'Welcome to the Home Screen!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}