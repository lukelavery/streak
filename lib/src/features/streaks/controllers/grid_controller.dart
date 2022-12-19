import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/services/streak_service.dart';

final gridControllerProvider = StateNotifierProvider.autoDispose<GridController,
        AsyncValue<Map<String, List<GridTileModel>>>>(
    (ref) => GridController(ref.watch(streakControllerProvider).value,
        ref.watch(habitControllerProvider).value, ref.read));

class GridController
    extends StateNotifier<AsyncValue<Map<String, List<GridTileModel>>>> {
  GridController(this.streaks, this.habits, this._read)
      : super(const AsyncValue.loading()) {
    DateTime now = DateTime.now();
    DateTime nowYMD = DateTime(now.year, now.month, now.day);
    int offset = 7 - now.weekday;

    if (habits != null) {
      Map<String, List<GridTileModel>> gridState = {};

      for (var habit in habits!) {
        List streakDateList = [];

        if (streaks != null) {
          if (streaks![habit.id] != null) {
            for (var streak in streaks![habit.id]!) {
              DateTime streakYMD = DateTime(streak.dateTime.year,
                  streak.dateTime.month, streak.dateTime.day);
              streakDateList.add(streakYMD);
            }
          }
        } else {}
        gridState[habit.id] = List.generate(182, (index) {
          if (index < offset) {
            return GridTileModel(streak: false, future: true);
          }
          if (streakDateList
              .contains(nowYMD.subtract(Duration(days: index - offset)))) {
            return GridTileModel(streak: true, future: false);
          }

          return GridTileModel(streak: false, future: false);
        });
      }
      state = AsyncValue.data(gridState);
    }
  }

  Future<void> addStreak({required String habitId}) async {
    await _read(streakServiceProvider)
        .addStreak(habitId: habitId, dateTime: DateTime.now());
  }

  Future<void> deleteStreak({required String habitId}) async {
    await _read(streakServiceProvider)
        .deleteStreak(habitId: habitId, dateTime: DateTime.now());
  }

  Map<String, List<Streak>>? streaks;
  List<HabitModel>? habits;
  final Reader _read;
}
