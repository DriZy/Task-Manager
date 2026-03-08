import 'package:flutter/material.dart';
import 'package:task_manager/views/add_task.dart';
import 'package:task_manager/views/widgets/appbar.dart';
import 'package:task_manager/views/widgets/bottom_navigation.dart';
import 'package:task_manager/views/widgets/dashboard_highlight.dart';
import 'package:task_manager/views/widgets/group_card.dart';
import 'package:task_manager/views/widgets/progress_card.dart';
import 'package:task_manager/models/group_card_model.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTopBar(
        subtitle: 'Hello!',
        title: 'Livia Vaccaro',
        showBackButton: false
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHighlight(),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("In Progress", style: AppTheme.sectionTitleStyle.copyWith(fontSize: 19, color: Colors.black),),
                  SizedBox(width: 10),
                  Text("6", style: AppTheme.subTextStyle.copyWith(fontSize: 13, fontStyle: FontStyle.normal, color: AppTheme.lavender),),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ProgressCard(
                        backgroundColor: AppTheme.cardCyan,
                        iconAsset: "lib/assets/briefcase.svg",
                        projectType: "Office Project",
                        content: "Grocery shopping app design",
                        progressValue: 0.67,
                        progressColor: AppTheme.softBlue,
                        iconBackgroundColor: AppTheme.iconBgPink
                    ),
                    const SizedBox(width: 10),
                    ProgressCard(
                        backgroundColor: AppTheme.cardOrange,
                        iconAsset: "lib/assets/user-octagon.svg",
                        projectType: "Personal Project",
                        content: "Uber Eats redesign challange",
                        progressValue: 0.45,
                        progressColor: AppTheme.softOrange,
                        iconBackgroundColor: AppTheme.iconBgLavender
                    ),

                  ],),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Task Groups", style: AppTheme.sectionTitleStyle.copyWith(fontSize: 19, color: Colors.black),),
                  SizedBox(width: 10),
                  Text("4", style: AppTheme.subTextStyle.copyWith(fontSize: 13, fontStyle: FontStyle.normal, color: AppTheme.lavender),),
                ],
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final groupCard = groupCardsList[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(19.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
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
                  return const SizedBox(height: 20);
                },
                itemCount: groupCardsList.length,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(
      selectedIndex: currentIndex,
      onItemSelected: onTabSelected,
      onAddPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
      },
    ),
    );
  }
}