import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../theme/app_theme.dart';

class HorizontalDatePicker extends StatefulWidget {
  final int numberOfDays;
  final ValueChanged<DateTime>? onDateSelected;

  const HorizontalDatePicker({
    super.key,
    this.numberOfDays = 7, // default 7 days
    this.onDateSelected,
  });

  @override
  State<HorizontalDatePicker> createState() =>
      _HorizontalDatePickerState();
}

class _HorizontalDatePickerState
    extends State<HorizontalDatePicker> {

  late List<DateTime> _dates;
  late DateTime _selectedDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();

    _selectedDate = DateTime(
      today.year,
      today.month,
      today.day,
    );

    // Generate dates: 90 days before today, today, and 90 days after today
    _dates = [
      ...List.generate(
        90,
        (index) => _selectedDate.subtract(Duration(days: 90 - index)),
      ),
      _selectedDate,
      ...List.generate(
        90,
        (index) => _selectedDate.add(Duration(days: index + 1)),
      ),
    ];

    _scrollController = ScrollController();

    // Scroll to today's date after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToDate(90);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToDate(int index) {
    const itemWidth = 80.0;
    const separatorWidth = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate position to center the item
    final itemPosition = index * (itemWidth + separatorWidth);
    final offset = itemPosition - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      offset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });

    widget.onDateSelected?.call(date);
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 80.0;
    const separatorWidth = 16.0;

    // Calculate width for 5 items to be visible
    const fiveItemsWidth = (itemWidth * 5) + (separatorWidth * 4);

    // Center the 5 items in the screen, but ensure padding is never negative
    final sidePadding = ((screenWidth - fiveItemsWidth) / 2).clamp(0.0, double.infinity);

    return SizedBox(
      height: 115,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // Enable bouncy scrolling
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        itemCount: _dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: separatorWidth),
        itemBuilder: (context, index) {
          final date = _dates[index];
          final selected = _isSameDate(date, _selectedDate);

          return _DateTimeCard(
            date: date,
            isSelected: selected,
            onTap: () => _selectDate(date),
          );
        },
      ),
    );
  }
}

class _DateTimeCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateTimeCard({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMM().format(date);
    final weekday = DateFormat.E().format(date);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.5),
          gradient: isSelected
              ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.lavender,
              AppTheme.lavender,
            ],
          )
              : null,
          color: isSelected ? null : const Color(0xFFF1F1F3),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.lavender.withValues(alpha: 0.13),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              month,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppTheme.primaryColor : Colors.black54,
              ),
            ),
            Text(
              date.day.toString(),
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppTheme.primaryColor : Colors.black87,
              ),
            ),
            Text(
              weekday,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: isSelected ? AppTheme.primaryColor : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}