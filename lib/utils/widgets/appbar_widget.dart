import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onNotification;
  final String? profileImageUrl;

  const AppBarWidget({
    super.key,
    required this.showBackButton,
    required this.title,
    this.subtitle,
    this.onBack,
    this.onNotification,
    this.profileImageUrl,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              SizedBox(
                width: 46,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: showBackButton
                      ? GestureDetector(
                          onTap: onBack ?? () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left_icon.svg',
                            height: 24,
                            width: 24,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            profileImageUrl ?? 'https://i.pravatar.cc/120?img=12',
                            height: 46,
                            width: 46,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 46,
                              width: 46,
                              color: const Color(0xffEDE7FF),
                              alignment: Alignment.center,
                              child: const Icon(Icons.person, size: 24, color: Color(0xff6C4EFF)),
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                      showBackButton ? CrossAxisAlignment.center :CrossAxisAlignment.start,
                  children: [
                    if (subtitle != null && subtitle!.trim().isNotEmpty)
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.appBarSubTitle
                      ),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.appBarTitle
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 46,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: onNotification,
                        child: SvgPicture.asset('assets/icons/notification_icon.svg', height: 17, width: 16),
                      ),
                      Positioned(
                        right: -1,
                        top: -1,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.themeLavender,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}