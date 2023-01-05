import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/habits/services/habit_service.dart';

final createHabitControllerProvider =
    StateNotifierProvider.autoDispose<CreateHabitController, int?>(
        (ref) => CreateHabitController(ref.read));

class CreateHabitController extends StateNotifier<int?> {
  CreateHabitController(this._read) : super(null);

  final Reader _read;
  String _description = '';

  String get description => _description;

  void setDescription(String description) {
    _description = description;
  }

  void setColor(int color) {
    state = color;
  }

  Future<void> handleButtonClick(
      {required ActivityModel activity, required BuildContext context}) async {
    try {
      await _addHabit(activity);
    } on CustomException catch (e) {
      _handleException(e);
    }
  }

  Future<void> _addHabit(ActivityModel activity) async {
    if (_description == '') {
      throw const CustomException(message: 'Please enter a description.');
    } else if (state == null) {
      throw const CustomException(message: 'Please select a color.');
    } else {
      await _read(habitServiceProvider).addHabit(
          activity: activity,
          color: colors[state!].value,
          description: description);
    }
  }

  void _handleException(CustomException e) {
    _read(customExceptionProvider.notifier).state = null;
    _read(customExceptionProvider.notifier).state = e;
  }
}

// List<MaterialColor> colorz = [
//   Colors.pink,
//   Colors.purple,
//   Colors.deepPurple,
//   Colors.indigo,
//   Colors.blue,
//   Colors.lightBlue,
//   Colors.cyan,
//   Colors.teal,
//   Colors.green,
//   Colors.lightGreen,
//   Colors.lime,
//   Colors.yellow,
//   Colors.amber,
//   Colors.orange,
//   Colors.deepOrange,
//   Colors.red,
//   Colors.brown,
//   Colors.blueGrey,
// ];

List<MaterialColor> colors = Colors.primaries;
