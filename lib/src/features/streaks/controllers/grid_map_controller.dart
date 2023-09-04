import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

final gridMapControllerProvider =
    StateNotifierProvider.autoDispose<GridMapController, AsyncValue<GridMap>>(
        (ref) => GridMapController(ref.watch(streakControllerProvider).value,
            ref.watch(habitControllerProvider).value));

class GridMapController extends StateNotifier<AsyncValue<GridMap>> {
  GridMapController(this.streaks, this.habits)
      : super(const AsyncValue.loading()) {
    if (habits != null) {
      state = AsyncValue.data(GridMap.fromHabits(streaks, habits!));
    }
  }

  Map<String, List<StreakModel>>? streaks;
  List<HabitModel>? habits;
}
