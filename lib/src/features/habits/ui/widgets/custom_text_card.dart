import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/habits/ui/widgets/custom_text_field.dart';
import 'package:streak/src/features/habits/ui/widgets/custom_text_form_field.dart';

class CustomTextCard extends StatelessWidget {
  const CustomTextCard(
      {super.key,
      required this.maxLength,
      required this.onChanged,
      required this.title,
      this.initialValue,
      this.activity});

  final int? maxLength;
  final void Function(String) onChanged;
  final String title;
  final String? initialValue;
  final ActivityModel? activity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Container(
          decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0),
              child: initialValue == null
                  ? CustomTextField(maxLength: maxLength, onChanged: onChanged)
                  : CustomTextFormField(
                    activityModel: activity,
                      maxLength: maxLength,
                      onChanged: onChanged,
                      initialValue: initialValue!,
                    )),
        ),
      ],
    );
  }
}