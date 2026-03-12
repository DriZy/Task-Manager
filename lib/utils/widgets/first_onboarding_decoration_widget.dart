import 'package:flutter/material.dart';

class FirstOnboardingDecorations extends StatelessWidget {
  const FirstOnboardingDecorations({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        // Scale factors relative to a 390×340 design canvas
        final sx = w / 390;
        final sy = h / 340;

        double x(double v) => v * sx;
        double y(double v) => v * sy;

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: y(0),
                left: x(49),
                child: Image.asset(
                  "assets/images/blue_stopwatch.png",
                  width: x(40),
                  height: y(50),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: y(60),
                left: x(280),
                child: Image.asset(
                  "assets/images/blue_desk_calendar.png",
                  width: x(32),
                  height: y(27),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: y(110),
                left: x(30),
                child: Image.asset(
                  "assets/images/pie_chart.png",
                  width: x(26),
                  height: y(26),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: y(155),
                left: x(260),
                child: Image.asset(
                  "assets/images/smartphone_notifications.png",
                  width: x(62),
                  height: y(42),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: y(220),
                left: x(30),
                child: Image.asset(
                  "assets/images/vase.png",
                  width: x(36),
                  height: y(52),
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: y(245),
                left: x(20),
                child: Image.asset(
                  "assets/images/coffee_cup.png",
                  width: x(18),
                  height: y(22),
                  fit: BoxFit.contain,
                ),
              ),
              Center(
              child: Image.asset(
                "assets/images/female_with_laptop.png",
                width: x(159) * 1.5,
                height: y(184) * 1.5,
                fit: BoxFit.contain,
              ),
            ),
            ],
          ),
        );
      },
    );
  }
}