import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../theme/app_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class GroupCard extends StatelessWidget {
  final String iconAsset;
  final String projectType;
  final double progressValue;
  final Color progressColor;
  final int totalTasks;
  final Color iconBackgroundColor;

  const GroupCard({
    super.key,
    required this.iconAsset,
    required this.projectType,
    required this.progressValue,
    required this.progressColor,
    required this.totalTasks,
    required this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: iconBackgroundColor,
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: SvgPicture.asset(
            iconAsset,
            width: 20,
            height: 20
        ),
      ),
      title: Text(
          projectType,
          style: AppTheme.sectionTitleStyle.copyWith(color: Colors.black)
      ),
      subtitle: Text("$totalTasks Tasks"),
      trailing: CircularPercentIndicator(
        lineWidth: 4.0,
        percent: progressValue,
        center: Text(
          "${progressValue*100}%",
          style: AppTheme.bodyStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: AppTheme.primaryColor,
        progressColor: progressColor,
        startAngle: 80.0,
        radius: 25.0,
      ),
    );
  }
}