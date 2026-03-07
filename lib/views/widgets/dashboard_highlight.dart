import 'package:flutter/material.dart';
import 'package:task_manager/views/daily_tasks_screen.dart';
import 'package:task_manager/views/widgets/styled_button.dart';
import '../../theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardHighlight extends StatelessWidget {
  const DashboardHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppTheme.lavender,
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your today\'s task\nalmost done!',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppTheme.primaryColor,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StyledButton(
                      text: "View Task",
                      sideRadius: 9,   // ← rectangle-style corner radius
                      // slopeDepth: 8,
                      // minimumSize: const Size(120, 44),
                      useSoftSlopeShape: false,  // ← use rectangle shape
                      onPressed: (){
                      Navigator. push(
                        context,
                        MaterialPageRoute(builder: (context) => const DailyTasksScreen()),
                      );
                  }),
                ],
              ),
            ),
            const SizedBox(width: 10),
            CircularPercentIndicator(
              lineWidth: 9.0,
              percent: 0.85,
              center: Text(
                "85%",
                style: TextStyle(color: AppTheme.primaryColor),
              ),
              backgroundColor: AppTheme.lavenderLight,
              progressColor: AppTheme.primaryColor,
              startAngle: 80.0,
              radius: 42.5,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopupMenuButton(
                  icon: const Icon(Icons.more_horiz),
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Text('Share'),
                    ),
                  ],
                  onSelected: (value) {
                    // Handle menu selection
                    print('Selected: $value');
                  },
                ),
              ],
            ),
          ],
        ),
    );
  }
}