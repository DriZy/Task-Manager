import 'package:flutter/material.dart';
import 'package:todo_list/models/task_card_model.dart';
import 'package:todo_list/theme/app_theme.dart';
import 'package:todo_list/utils/widgets/app_background_widget.dart';
import 'package:todo_list/utils/widgets/appbar_widget.dart';
import 'package:todo_list/utils/widgets/bottom_navigation_widget.dart';
import 'package:todo_list/utils/widgets/date_filter_widget.dart';
import 'package:todo_list/utils/widgets/task_card_widget.dart';
import 'package:todo_list/views/add_task/add_task_screen.dart';
import 'package:todo_list/views/home/home_screen.dart';

class DailyTasksScreen extends StatefulWidget {
  final int initialIndex;

  const DailyTasksScreen({super.key, this.initialIndex = 1});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  String _selectedFilter = 'All';
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void onTabSelected(int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 0)),
      );
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  List<TaskCardModel> get _filteredTasks {
    if (_selectedFilter == 'All') {
      return taskCardsList;
    }
    return taskCardsList.where((task) => task.status == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBarWidget(
        title: 'Today’s Tasks',
        showBackButton: true,
        onBack: () {
          final navigator = Navigator.of(context);
          if (navigator.canPop()) {
            navigator.pop();
          } else {
            navigator.pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 0)),
            );
          }
        },
      ),
      body: AppBackground(
        blobs: [
          GradientBlob(color: const Color(0xFFEDF046), topFraction: 0.20, rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46F080), topFraction: -0.15,  leftFraction:  -0.30),
          GradientBlob(color: const Color(0xFF2555FF), bottomFraction: -0.15,  rightFraction: -0.30),
          GradientBlob(color: const Color(0xFF46BDF0), bottomFraction: 0.15,  leftFraction:  -0.35),
        ],
        child: SafeArea(
          child: Column(
          children: [
            SizedBox(height: kToolbarHeight - 40),
            DateFilterWidget(),
            // Filter Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 4,
                      separatorBuilder: (context, index) => const SizedBox(width: 20),
                      itemBuilder: (context, index) {
                        final filters = ['All', 'To-do', 'In Progress', 'Completed'];
                        return _buildFilterChip(filters[index], AppTheme.themeLavender);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Task Count
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Text(
                '${_filteredTasks.length} ${_filteredTasks.length == 1 ? 'Task' : 'Tasks'}',
                style: AppTheme.bodyStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Task List
            Expanded(
              child: _filteredTasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: AppTheme.themeLavender,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No tasks found',
                            style: AppTheme.bodyStyle.copyWith(
                              fontSize: 18,
                              color: AppTheme.themeLavender,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                      itemBuilder: (BuildContext context, int index) {
                        final taskCard = _filteredTasks[index];
                        return Container(
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
                          child: TaskCardWidget(
                            taskIcon: taskCard.taskIcon,
                            taskGroup: taskCard.taskGroup,
                            taskTitle: taskCard.taskTitle,
                            taskTime: taskCard.taskTime,
                            status: taskCard.status,
                            iconBackgroundColor: taskCard.iconBackgroundColor,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
                      itemCount: _filteredTasks.length,
                    ),
            ),
          ],
        ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
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

  Widget _buildFilterChip(String label, Color color) {
    final isSelected = _selectedFilter == label;

    return FilterChip(
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // labelPadding: const EdgeInsets.all(horizontal: 4),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppTheme.themeWhite : AppTheme.themeLavender,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: color,
      backgroundColor: AppTheme.themeLavender.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isSelected ? color : Colors.transparent,
          width: 1.5,
        ),
      ),
    );
  }
}
