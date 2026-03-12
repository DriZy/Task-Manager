import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressCard extends StatelessWidget {
  final Color backgroundColor;
  final String iconAsset;
  final String projectType;
  final String content;
  final double progressValue;
  final Color progressColor;
  final Color iconBackgroundColor;

  const ProgressCard({
    super.key,
    required this.backgroundColor,
    required this.iconAsset,
    required this.projectType,
    required this.content,
    required this.progressValue,
    required this.progressColor,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 215,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color:backgroundColor,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectType,
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppTheme.themeGray,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: SvgPicture.asset(
                  iconAsset,
                  width: 14,
                  height: 14
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: AppTheme.cardTitle.copyWith(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 16),
          LinearPercentIndicator(
            padding: EdgeInsets.symmetric(horizontal: 0),
            // width: 218,
            lineHeight: 8.0,
            percent: progressValue,
            backgroundColor: AppTheme.themeWhite,
            progressColor: progressColor,
            barRadius: const Radius.circular(4),
          ),
        ],
      ),
    );
  }
}