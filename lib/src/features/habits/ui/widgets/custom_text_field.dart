import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.maxLength,
    required this.onChanged,
    this.activityModel,
  });

  final int? maxLength;
  final void Function(String) onChanged;
  final ActivityModel? activityModel;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength,
      decoration: const InputDecoration(border: InputBorder.none),
      onChanged: (value) => onChanged(value),
    );
  }
}