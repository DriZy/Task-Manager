import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/theme/app_theme.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onAddPressed;

  const BottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [

          Positioned(
            bottom: 0,
            left: 2,
            right: 2,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Color(0xFFEEE9FF),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _navItem(SvgPicture.asset('lib/assets/home.svg'), 0),
                      const SizedBox(width: 30),
                      _navItem(SvgPicture.asset('lib/assets/calendar.svg'), 1),
                    ],
                  ),
                  Row(
                    children: [
                      _navItem(SvgPicture.asset('lib/assets/document_text.svg'), 2),
                      const SizedBox(width: 30),
                      _navItem(SvgPicture.asset('lib/assets/profile_user.svg'), 3),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onAddPressed,
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.lavender,
                      AppTheme.lavender,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lavender.withOpacity(.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(Widget icon, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: icon is IconData
          ? Icon(
              icon as IconData,
              color: isSelected ? AppTheme.lavender : AppTheme.lavenderLight,
              size: 28,
            )
          : IconTheme(
              data: IconThemeData(
                color: isSelected ? AppTheme.lavender : AppTheme.lavenderLight,
              ),
              child: icon,
            ),
    );
  }
}