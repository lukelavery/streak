import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/counter_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';

final counterControllerProvider =
    StateNotifierProvider.autoDispose<CounterController, AsyncValue<Map<String, Counter>>>(
        (ref) => CounterController(ref.watch(streakControllerProvider).value, ref.watch(habitControllerProvider).value));

class CounterController
    extends StateNotifier<AsyncValue<Map<String, Counter>>> {
  CounterController(this.streaks, this.habits) : super(const AsyncValue.loading()) {
    if (habits != null && streaks != null) {
      for (var habit in habits!) {
        counters[habit.activity.id] = const Counter(count: 0);
      }
      for (var element in streaks!.keys) {
        counters[element] = Counter.fromStreaks(streaks![element]);
      }
    }
    state = AsyncValue.data(counters);
  }

  // final Reader _read;
  Map<String, List<StreakModel>>? streaks;
  List<HabitModel>? habits;
  Map<String, Counter> counters = {};
  Map<String, Counter> baseCounters = {};
}
