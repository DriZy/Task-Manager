import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardHighlight extends StatelessWidget {
  final VoidCallback? onViewTaskTap;

  const DashboardHighlight({super.key, this.onViewTaskTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5A36D6),
            Color(0xFF6A45E6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your today’s task\nalmost done!",
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.themeWhite,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: onViewTaskTap ?? () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D4F3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        "View Task",
                        style: TextStyle(
                          color: Color(0xFF5A36D6),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              CircularPercentIndicator(
                lineWidth: 9,
                percent: 0.85,
                radius: 42.5,
                startAngle: 80,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "85%",
                  style: TextStyle(
                    color: AppTheme.themeWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                backgroundColor: AppTheme.themeWhite.withValues(alpha: 0.25),
                progressColor: AppTheme.themeWhite,
              ),
              const SizedBox(width: 24),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.themeWhite.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}