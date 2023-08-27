import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/models/icons.dart';
import 'package:streak/src/features/activities/services/activity_service.dart';
import 'package:streak/src/features/habits/services/habit_service.dart';

final createHabitControllerProvider =
    StateNotifierProvider.autoDispose<CreateHabitController, int?>(
        (ref) => CreateHabitController(ref));

class CreateHabitController extends StateNotifier<int?> {
  CreateHabitController(this._ref) : super(null);

  final Ref _ref;
  String? _name;
  IconData? _icon;
  String _description = '';

  String get description => _description;

  void setName(String name) {
    _name = name;
  }

  void setDescription(String description) {
    _description = description;
  }

  void setIcon(int index) {
    _icon = icons[index];
    state = index;
  }

  Future<void> handleButtonClick({
    required ActivityModel? activity,
    required BuildContext context,
  }) async {
    try {
      if (activity != null) {
        await _addHabit(activity);
      } else {
        final activity = await _createActivity();
        await _addHabit(activity);
      }
    } on CustomException catch (e) {
      _handleException(e);
    }
  }

  Future<void> _addHabit(ActivityModel activity) async {
    if (_description == '') {
      throw const CustomException(message: 'Please enter a description.');
    } else {
      if (activity.id == '') {
        await _ref
            .read(activityServiceProvider)
            .createActivity(activity: activity);
      } else {
        await _ref.read(habitServiceProvider).addHabit(
              activity: activity,
              description: description,
            );
      }
    }
  }

  Future<ActivityModel> _createActivity() async {
    if (_icon == null) {
      throw const CustomException(message: 'Please select an icon.');
    }
    if (_name == null) {
      throw const CustomException(message: 'Something went wrong.');
    }
    final ActivityModel activity = ActivityModel(
      id: '',
      name: _name!,
      iconCodePoint: _icon!.codePoint,
      iconFontFamily: _icon!.fontFamily!,
      iconFontPackage: _icon!.fontPackage,
      // fix
      type: '',
    );
    final id = await _ref
        .read(activityServiceProvider)
        .createActivity(activity: activity);
    final ActivityModel result = ActivityModel(
      id: id,
      name: _name!,
      iconCodePoint: _icon!.codePoint,
      iconFontFamily: _icon!.fontFamily!,
      iconFontPackage: _icon!.fontPackage,
      // fix
      type: '',
    );
    return result;
  }

  void _handleException(CustomException e) {
    _ref.read(customExceptionProvider.notifier).state = null;
    _ref.read(customExceptionProvider.notifier).state = e;
  }
}
