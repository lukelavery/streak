import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/habit_controller.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/counter_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';

final counterControllerProvider =
    StateNotifierProvider.autoDispose<CounterController, AsyncValue<Map<String, Counter>>>(
        (ref) => CounterController(ref.watch(streakControllerProvider).value, ref.watch(habitControllerProvider).value));

class CounterController
    extends StateNotifier<AsyncValue<Map<String, Counter>>> {
  CounterController(this.streaks, this.habits) : super(const AsyncValue.loading()) {
    // streaks = _read(streakControllerProvider).value;
    // habits = _read(habitControllerProvider).value;
    if (habits != null && streaks != null) {
      for (var habit in habits!) {
        counters[habit.id] = const Counter(count: 0);
      }
      for (var element in streaks!.keys) {
        counters[element] = Counter.fromStreaks(streaks![element]);
      }
    }
    state = AsyncValue.data(counters);
  }

  // final Reader _read;
  Map<String, List<Streak>>? streaks;
  List<ActivityModel>? habits;
  Map<String, Counter> counters = {};
  Map<String, Counter> baseCounters = {};
}
