import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';

class CompleteButtonSmall extends StatelessWidget {
  const CompleteButtonSmall({
    Key? key,
    required this.today,
    required this.handleButtonClick,
    required this.activity,
    required this.color,
  }) : super(key: key);

  final bool today;
  final Future<void> Function({required String activityId}) handleButtonClick;
  final ActivityModel activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onLongPress: (() {
        handleButtonClick(activityId: activity.id);
      }),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: today ? color.withOpacity(0.8) : color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Icon(
                Icons.task_alt,
                color: today ? Colors.white : Colors.grey,
                size: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
