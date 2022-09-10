import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/services/habit_service.dart';

final habitControllerProvider =
    StateNotifierProvider.autoDispose<HabitController, AsyncValue<List<HabitModel>>>(
        (ref) => HabitController(ref.read));

class HabitController extends StateNotifier<AsyncValue<List<HabitModel>>> {
  HabitController(this._read) : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription =
        _read(habitServiceProvider).retrieveHabits.listen((habits) {
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

  Future<void> createHabit(HabitPreset habit) async {
    await _read(habitServiceProvider).createHabit(habit: habit);
  }

  Future<void> deleteHabit(String habitId) async {
    await _read(habitServiceProvider).deleteHabit(habitId: habitId);
  }

  Future<void> addStreak(String habitId, DateTime dateTime) async {
    await _read(habitServiceProvider).addStreak(habitId, dateTime);
  }

  int getCrossAxisCount() {
    if (state.value!.length < 3) {
      return 1;
    }
    return 2;
  }
}
