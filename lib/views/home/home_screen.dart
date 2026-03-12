import 'package:flutter/material.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/utils/widgets/app_background_widget.dart';
import 'package:todo_list/utils/widgets/appbar_widget.dart';
import 'package:todo_list/utils/widgets/dashboard_highlight_widget.dart';
import 'package:todo_list/utils/widgets/progress_card.dart';
import 'package:todo_list/models/group_card_model.dart';
import 'package:todo_list/utils/widgets/group_card.dart';
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
      appBar: AppBarWidget(
        title: 'Livia Vaccaro',
        subtitle: 'Hello!',
        showBackButton: false,
      ),
      body: AppBackground(
        blobs: [
          GradientBlob(color: const Color(0xFFEDF046), topFraction: 0.20, rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46F080), topFraction: -0.15,  leftFraction:  -0.30),
          GradientBlob(color: const Color(0xFF2555FF), bottomFraction: -0.15,  rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46BDF0), bottomFraction: 0.15,  leftFraction:  -0.35),
        ],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                child: DashboardHighlight(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15, left: 24, right: 24),
                child: Row(
                      children: [
                        Text(
                          'In Progress',
                          style: AppTheme.sectionTitle,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.themeLightLavender.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Text(
                              '6',
                              style: AppTheme.bodyStyle
                          ),
                        ),
                      ],
                    ),
              ),
              SingleChildScrollView(
                physics: ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 24),
                    ProgressCard(
                        backgroundColor: AppTheme.themeLightBlue,
                        iconAsset: "assets/icons/briefcase_icon.svg",
                        projectType: "Office Project",
                        content: "Grocery shopping app design",
                        progressValue: 0.67,
                        progressColor: AppTheme.themeSoftBlue,
                        iconBackgroundColor: AppTheme.themeIconBgPink
                    ),
                    const SizedBox(width: 20),
                    ProgressCard(
                        backgroundColor: AppTheme.themeLightOrange,
                        iconAsset: "assets/icons/user-octagon_icon.svg",
                        projectType: "Personal Project",
                        content: "Uber Eats redesign challange",
                        progressValue: 0.59,
                        progressColor: AppTheme.themeSoftOrange,
                        iconBackgroundColor: AppTheme.themeIconBgLavender
                    ),
                    const SizedBox(width: 24),
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 15, left: 24, right: 24),
                child: Row(
                      children: [
                        Text(
                          'Task Groups',
                          style: AppTheme.sectionTitle,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.themeLightLavender.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Text(
                              '4',
                              style: AppTheme.bodyStyle
                          ),
                        ),
                      ],
                    ),
              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final groupCard = groupCardsList[index];
                  return Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: AppTheme.themeWhite,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.themeGray.withValues(alpha: 0.1),
                          spreadRadius: 15,
                          blurRadius: 15,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: GroupCard(
                      iconAsset: groupCard.iconAsset,
                      projectType: groupCard.projectType,
                      progressValue: groupCard.progressValue,
                      progressColor: groupCard.progressColor,
                      totalTasks: groupCard.totalTasks,
                      iconBackgroundColor: groupCard.iconBackgroundColor,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12.5);
                },
                itemCount: groupCardsList.length,
              ),
            ],
          ),
        )
      ),
    );
  }
}