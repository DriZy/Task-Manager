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
            left: 20,
            right: 20,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: const Color(0xffECEAF6),
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
                      _navItem(Icons.home_rounded, 0),
                      const SizedBox(width: 30),
                      _navItem(Icons.calendar_month_rounded, 1),
                    ],
                  ),
                  Row(
                    children: [
                      _navItem(Icons.description_rounded, 2),
                      const SizedBox(width: 30),
                      _navItem(SvgPicture('lib/assets/'), 3),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// CENTER ADD BUTTON
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
                      Color(0xff5A3FD8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff7B61FF).withOpacity(.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Icon(
        icon,
        color: isSelected ? const Color(0xff5A3FD8) : AppTheme.lavender,
        size: 28,
      ),
    );
  }
}