
import 'dart:ui';

import '../theme/app_theme.dart';

class TaskCardModel {
  final String taskIcon;
  final String taskGroup;
  final String taskTitle;
  final String taskTime;
  final String status;
  final Color iconBackgroundColor;

  TaskCardModel({
    required this.taskIcon,
    required this.taskGroup,
    required this.taskTitle,
    required this.taskTime,
    required this.status,
    required this.iconBackgroundColor,
  });
}

// Sample data for group cards
final List<TaskCardModel> taskCardsList = [
  TaskCardModel(
      taskIcon: "lib/assets/briefcase.svg",
      taskGroup: "Grocery shopping app design",
      taskTitle: "Market Research",
      taskTime: "10:00 AM",
      status: "Done",
      iconBackgroundColor: AppTheme.iconBgPink
  ),
  TaskCardModel(
    taskIcon: "lib/assets/briefcase.svg",
    taskGroup: "Grocery shopping app design",
    taskTitle: "Competitive Analysis",
    taskTime: "12:00 PM",
    status: "In Progress",
    iconBackgroundColor: AppTheme.iconBgPink
  ),
  TaskCardModel(
    taskIcon: "lib/assets/user-octagon.svg",
    taskGroup: "Uber Eats redesign challenge",
    taskTitle: "Create Low-fidelity Wireframe",
    taskTime: "07:00 PM",
    status: "To-do",
    iconBackgroundColor: AppTheme.iconBgLavender
  ),
  TaskCardModel(
    taskIcon: "lib/assets/book.svg",
    taskGroup: "About design sprint",
    taskTitle: "How to pitch a Design Sprint",
    taskTime: "09:00 PM",
    status: "To-do",
    iconBackgroundColor: AppTheme.iconBgOrange
  ),
];

