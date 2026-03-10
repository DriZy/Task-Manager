import 'package:flutter/material.dart';

class FirstOnboardingDecorations extends StatelessWidget {
  const FirstOnboardingDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -190,
            left: 64,
            child: Image.asset(
              "assets/images/blue_stopwatch.png",
              width: 40,
              height: 50,
            ),
          ),

          Positioned(
            top: -125,
            left: 260,
            child: Image.asset(
              "assets/images/blue_desk_calendar.png",
              width: 32,
              height: 27,
            ),
          ),

          Positioned(
            top: -35,
            left: 49,
            child: Image.asset(
              "assets/images/pie_chart.png",
              width: 26,
              height: 26,
            ),
          ),

          Positioned(
            top: 10,
            left: 245,
            child: Image.asset(
              "assets/images/smartphone_notifications.png",
              width: 62,
              height: 42,
            ),
          ),
          Positioned(
            top: 60,
            left: 49,
            child: Image.asset(
              "assets/images/vase.png",
              width: 36,
              height: 52,
            ),
          ),
          Positioned(
            top: 90,
            left: 43,
            child: Image.asset(
              "assets/images/coffee_cup.png",
              width: 18,
              height: 22,
            ),
          ),

          Positioned(
            top: -120,
            left: 75,
            child: Image.asset(
              "assets/images/female_with_laptop.png",
              width: 250,
              height: 275,
            ),
          ),
        ],
      ),
    );
  }
}