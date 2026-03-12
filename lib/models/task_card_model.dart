
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
      taskIcon: "assets/icons/briefcase_icon.svg",
      taskGroup: "Grocery shopping app design",
      taskTitle: "Market Research",
      taskTime: "10:00 AM",
      status: "Done",
      iconBackgroundColor: AppTheme.themeIconBgPink
  ),
  TaskCardModel(
    taskIcon: "assets/icons/briefcase_icon.svg",
    taskGroup: "Grocery shopping app design",
    taskTitle: "Competitive Analysis",
    taskTime: "12:00 PM",
    status: "In Progress",
    iconBackgroundColor: AppTheme.themeIconBgPink
  ),
  TaskCardModel(
    taskIcon: "assets/icons/user-octagon_icon.svg",
    taskGroup: "Uber Eats redesign challenge",
    taskTitle: "Create Low-fidelity Wireframe",
    taskTime: "07:00 PM",
    status: "To-do",
    iconBackgroundColor: AppTheme.themeIconBgLavender
  ),
  TaskCardModel(
    taskIcon: "assets/icons/book_icon.svg",
    taskGroup: "About design sprint",
    taskTitle: "How to pitch a Design Sprint",
    taskTime: "09:00 PM",
    status: "To-do",
    iconBackgroundColor: AppTheme.themeIconBgOrange
  ),
];

