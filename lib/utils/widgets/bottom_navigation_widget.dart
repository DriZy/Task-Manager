import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/theme/app_theme.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onAddPressed;

  const BottomNavigationWidget({
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
                color: AppTheme.themeLightLavender.withValues(alpha: 0.22),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _navItem('assets/icons/home_icon.svg', 0),
                      const SizedBox(width: 30),
                      _navItem('assets/icons/calendar_icon.svg', 1),
                    ],
                  ),
                  Row(
                    children: [
                      _navItem('assets/icons/document_text_icon.svg', 2),
                      const SizedBox(width: 30),
                      _navItem('assets/icons/profile_user_icon.svg', 3),
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
              child: SizedBox(
                width: 64,
                height: 78,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    // Bottom semicircle shadow under the add button
                    Positioned(
                      bottom: 2,
                      left: 8,
                      right: 8,
                      child: Container(
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.themeLightLavender.withValues(alpha: 0.19),
                              blurRadius: 14,
                              spreadRadius: 50,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.themeLightLavender.withValues(alpha: 0.19),
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: const Offset(0, 6),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.themeLavender,
                            AppTheme.themeLavender,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.themeWhite,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String iconAsset, int index) {
    final bool isSelected = selectedIndex == index;
    final iconColor = isSelected ? AppTheme.themeLavender : AppTheme.themeLightLavender;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: SvgPicture.asset(
        iconAsset,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      ),
    );
  }
}