import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/ui/pages/activity_icon.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.maxLength,
    required this.onChanged,
    required this.initialValue,
    required this.activityModel,
  });

  final int? maxLength;
  final void Function(String) onChanged;
  final String initialValue;
  final ActivityModel? activityModel;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: false,
      maxLength: maxLength,
      decoration: InputDecoration(
          border: InputBorder.none,
          icon: activityModel != null ? ActivityIcon(activity: activityModel!, color: Theme.of(context).colorScheme.onSurface) : null),
      onChanged: (value) => onChanged(value),
    );
  }
}