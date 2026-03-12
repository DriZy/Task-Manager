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
    iconAsset: "assets/icons/briefcase_icon.svg",
    projectType: "Office Project",
    progressValue: 0.85,
    progressColor: AppTheme.themeSoftPink,
    totalTasks: 30,
    iconBackgroundColor: AppTheme.themeIconBgPink
  ),
  GroupCardModel(
    iconAsset: "assets/icons/user-octagon_icon.svg",
    projectType: "Personal Project",
    progressValue: 0.60,
    progressColor: AppTheme.themeLightLavender,
    totalTasks: 80,
    iconBackgroundColor: AppTheme.themeIconBgLavender
  ),
  GroupCardModel(
    iconAsset: "assets/icons/book_icon.svg",
    projectType: "Daily Study",
    progressValue: 0.75,
    progressColor: AppTheme.themeSoftOrange,
    totalTasks: 12,
    iconBackgroundColor: AppTheme.themeIconBgOrange
  ),
  GroupCardModel(
    iconAsset: "assets/icons/briefcase_icon.svg",
    projectType: "QA Testing",
    progressValue: 0.63,
    progressColor: AppTheme.themeSoftPink,
    totalTasks: 6,
    iconBackgroundColor: AppTheme.themeIconBgPink
  ),
];

