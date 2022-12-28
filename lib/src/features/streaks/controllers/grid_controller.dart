import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/habit_controller.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/services/streak_service.dart';

final gridControllerProvider = StateNotifierProvider.autoDispose<GridController,
        AsyncValue<GridViewModel>>(
    (ref) => GridController(ref.watch(streakControllerProvider).value,
        ref.watch(habitControllerProvider).value, ref.read));

class GridController extends StateNotifier<AsyncValue<GridViewModel>> {
  GridController(this.streaks, this.habits, this._read)
      : super(const AsyncValue.loading()) {
    // DateTime now = DateTime.now();
    // DateTime nowYMD = DateTime(now.year, now.month, now.day);
    // int offset = 7 - now.weekday;

    if (habits != null) {
      state = AsyncValue.data(GridViewModel.fromStreaks(streaks, habits!));
    }
  }

  Future<void> _addStreak({required String habitId}) async {
    await _read(streakServiceProvider)
        .addStreak(habitId: habitId, dateTime: DateTime.now());
  }

  Future<void> _deleteStreak({required String habitId}) async {
    await _read(streakServiceProvider)
        .deleteStreak(habitId: habitId, dateTime: DateTime.now());
  }

  Future<void> handleButtonClick({required String habitId}) async {
    var value = state.value;
    if (value != null) {
      if (value.gridModels[habitId] != null) {
        if (value.gridModels[habitId]!.today) {
          _deleteStreak(habitId: habitId);
        } else {
          _addStreak(habitId: habitId);
        }
      }
    }
  }

  Map<String, List<Streak>>? streaks;
  List<ActivityModel>? habits;
  final Reader _read;
}

class GridViewModel {
  const GridViewModel({required this.gridModels});

  final Map<String, GridModel> gridModels;

  factory GridViewModel.fromStreaks(
      Map<String, List<Streak>>? streaks, List<ActivityModel> habits) {
    DateTime now = DateTime.now();
    DateTime nowYMD = DateTime(now.year, now.month, now.day);
    int offset = 7 - now.weekday;

    Map<String, GridModel> gridState = {};

    for (var habit in habits) {
      bool today = false;
      List streakDateList = [];

      if (streaks != null) {
        if (streaks[habit.id] != null) {
          for (var streak in streaks[habit.id]!) {
            DateTime streakYMD = DateTime(streak.dateTime.year,
                streak.dateTime.month, streak.dateTime.day);
            streakDateList.add(streakYMD);
          }
        }
      }
      gridState[habit.id] = GridModel(
        gridTiles: List.generate(182, (index) {
          if (index < offset) {
            return GridTileModel(streak: false, future: true);
          }
          if (streakDateList
              .contains(nowYMD.subtract(Duration(days: index - offset)))) {
            return GridTileModel(streak: true, future: false);
          }
          if (streakDateList.contains(nowYMD)) {
            today = true;
          }

          return GridTileModel(streak: false, future: false);
        }),
        today: today,
      );
    }
    return GridViewModel(
      gridModels: gridState,
    );
  }
}

class GridModel {
  const GridModel({required this.gridTiles, required this.today});

  final List<GridTileModel> gridTiles;
  final bool today;
}
