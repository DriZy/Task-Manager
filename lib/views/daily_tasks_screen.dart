import 'package:flutter/material.dart';
import 'package:task_manager/views/widgets/appbar.dart';
import 'package:task_manager/views/widgets/bottom_navigation.dart';
import 'package:task_manager/views/widgets/horizontal_date_picker.dart';
import '../models/task_card_model.dart';
import '../theme/app_theme.dart';
import 'add_task.dart';
import 'widgets/task_card.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  String _selectedFilter = 'All';
  int currentIndex = 0;

  void onTabSelected(int index) {
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
      appBar: AppTopBar(
        title: 'Today’s Tasks',
        showBackButton: true,
      ),
      body: Column(
        children: [
          HorizontalDatePicker(),
          // Filter Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter by status',
                  style: AppTheme.bodyStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightGray,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 4,
                    separatorBuilder: (context, index) => const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      final filters = ['All', 'To-do', 'In Progress', 'Done'];
                      return _buildFilterChip(filters[index], AppTheme.lavender);
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
                          color: AppTheme.lavender,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks found',
                          style: AppTheme.bodyStyle.copyWith(
                            fontSize: 18,
                            color: AppTheme.lavender,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      final taskCard = _filteredTasks[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TaskCard(
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

  Widget _buildFilterChip(String label, Color color) {
    final isSelected = _selectedFilter == label;

    return FilterChip(
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // labelPadding: const EdgeInsets.all(horizontal: 4),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppTheme.primaryColor : AppTheme.lavender,
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
      backgroundColor: AppTheme.lavender.withValues(alpha: 0.1),
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
