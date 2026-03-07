import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final String taskIcon;
  final String taskGroup;
  final String taskTitle;
  final String taskTime;
  final String status;
  final Color iconBackgroundColor;

  const TaskCard({
    super.key,
    required this.taskIcon,
    required this.taskGroup,
    required this.taskTitle,
    required this.taskTime,
    required this.status,
    required this.iconBackgroundColor
  });

  // Helper method to get color based on status
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'done':
      case 'completed':
        return AppTheme.lavender;
      case 'in progress':
      case 'ongoing':
        return AppTheme.softOrange;
      case 'to-do':
      case 'todo':
      case 'pending':
        return AppTheme.softBlue;
      case 'cancelled':
      case 'canceled':
        return Colors.red;
      default:
        return AppTheme.lightGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskGroup,
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 11,
                  color: AppTheme.lightGray,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: SvgPicture.asset(
                    taskIcon,
                    width: 14,
                    height: 14
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            taskTitle,
            style: AppTheme.sectionTitleStyle.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time_filled,
                    size: 14,
                    color: AppTheme.cardLavender,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    taskTime,
                    style: AppTheme.bodyStyle.copyWith(
                      fontSize: 11,
                      color: AppTheme.cardLavender,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: AppTheme.bodyStyle.copyWith(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}