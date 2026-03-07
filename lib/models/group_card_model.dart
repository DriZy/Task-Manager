import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class GroupCardModel {
  final String iconAsset;
  final String projectType;
  final double progressValue;
  final Color progressColor;
  final int totalTasks;
  final Color iconBackgroundColor;

  GroupCardModel({
    required this.iconAsset,
    required this.projectType,
    required this.progressValue,
    required this.progressColor,
    required this.totalTasks,
    required this.iconBackgroundColor,
  });
}

// Sample data for group cards
final List<GroupCardModel> groupCardsList = [
  GroupCardModel(
    iconAsset: "lib/assets/briefcase.svg",
    projectType: "Office Project",
    progressValue: 0.85,
    progressColor: AppTheme.softPink,
    totalTasks: 30,
    iconBackgroundColor: AppTheme.iconBgPink
  ),
  GroupCardModel(
    iconAsset: "lib/assets/user-octagon.svg",
    projectType: "Personal Project",
    progressValue: 0.60,
    progressColor: AppTheme.lavenderLight,
    totalTasks: 80,
    iconBackgroundColor: AppTheme.iconBgLavender
  ),
  GroupCardModel(
    iconAsset: "lib/assets/book.svg",
    projectType: "Daily Study",
    progressValue: 0.75,
    progressColor: AppTheme.softOrange,
    totalTasks: 12,
    iconBackgroundColor: AppTheme.iconBgOrange
  ),
  GroupCardModel(
    iconAsset: "lib/assets/briefcase.svg",
    projectType: "QA Testing",
    progressValue: 0.63,
    progressColor: AppTheme.lavender,
    totalTasks: 6,
    iconBackgroundColor: AppTheme.iconBgPink
  ),
];

