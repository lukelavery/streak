

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/activities/services/habit_service.dart';

final habitControllerProvider = StateNotifierProvider.autoDispose<
    HabitController,
    AsyncValue<List<ActivityModel>>>((ref) => HabitController(ref.read));

class HabitController extends StateNotifier<AsyncValue<List<ActivityModel>>> {
  HabitController(this._read) : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription =
        _read(newHabitServiceProvider).getUserHabits().listen((habits) {
      state = AsyncValue.data(habits);
    });
  }

  @override
  void dispose() {
    _habitStreamSubscription?.cancel();
    super.dispose();
  }

  final Reader _read;
  AsyncValue<List<ActivityModel>>? previousState;

  StreamSubscription<List<ActivityModel>>? _habitStreamSubscription;

  Future<void> removeHabit({required String habitId}) async {
    await _read(newHabitServiceProvider).removeHabit(habitId: habitId);
  }

  Future<void> addStreak(String habitId, DateTime dateTime) async {
    // await _read(newHabitServiceProvider).addStreak(habitId, dateTime);
  }

  int getCrossAxisCount() {
    if (state.value!.length < 3) {
      return 1;
    }
    return 2;
  }
}
