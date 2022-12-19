import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/services/_habit_service.dart';

final habitControllerProvider =
    StateNotifierProvider.autoDispose<HabitController, AsyncValue<List<HabitModel>>>(
        (ref) => HabitController(ref.read));

class HabitController extends StateNotifier<AsyncValue<List<HabitModel>>> {
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
  AsyncValue<List<HabitModel>>? previousState;

  StreamSubscription<List<HabitModel>>? _habitStreamSubscription;

  Future<void> removeHabit(String habitId) async {
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
