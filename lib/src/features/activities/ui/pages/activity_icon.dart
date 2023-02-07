import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';

class ActivityIcon extends StatelessWidget {
  const ActivityIcon({super.key, required this.activity, required this.color});

  final ActivityModel activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return activity.iconFontPackage == "font_awesome_flutter"
        ? FaIcon(
            IconData(activity.iconCodePoint,
                fontFamily: activity.iconFontFamily,
                fontPackage: activity.iconFontPackage),
            color: color,
          )
        : Icon(
            IconData(activity.iconCodePoint,
                fontFamily: activity.iconFontFamily,
                fontPackage: activity.iconFontPackage),
            color: color,
          );
  }
}