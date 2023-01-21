import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
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
    if (habits != null) {
      state = AsyncValue.data(GridViewModel.fromStreaks(streaks, habits!));
    }
  }

  Future<void> _addStreak({required String activityId}) async {
    await _read(streakServiceProvider)
        .addStreak(activityId: activityId, dateTime: DateTime.now());
  }

  Future<void> _deleteStreak({required String activityId}) async {
    await _read(streakServiceProvider)
        .deleteStreak(activityId: activityId, dateTime: DateTime.now());
  }

  Future<void> handleButtonClick({required String activityId}) async {
    var value = state.value;
    if (value != null) {
      if (value.gridModels[activityId] != null) {
        if (value.gridModels[activityId]!.today) {
          _deleteStreak(activityId: activityId);
        } else {
          _addStreak(activityId: activityId);
        }
      }
    }
  }

  Map<String, List<StreakModel>>? streaks;
  List<HabitModel>? habits;
  final Reader _read;
}

// final newGridControllerProvider = StateNotifierProvider.autoDispose<
//         NewGridController, AsyncValue<NewGridViewModel>>(
//     (ref) => NewGridController(ref.watch(streakControllerProvider).value,
//         ref.watch(habitControllerProvider).value));

// class NewGridController extends StateNotifier<AsyncValue<NewGridViewModel>> {
//   NewGridController(this.streaks, this.habits)
//       : super(const AsyncValue.loading()) {
//     if (habits != null) {
//       state = AsyncValue.data(NewGridViewModel.fromHabits(streaks, habits!));
//     }
//   }

//   Map<String, List<StreakModel>>? streaks;
//   List<HabitModel>? habits;
//   // final Reader _read;
// }

final newerGridControllerProvider = StateNotifierProvider.autoDispose<
        NewerGridController, AsyncValue<NewerGridModel>>(
    (ref) => NewerGridController(ref.watch(streakControllerProvider).value,
        ref.watch(habitControllerProvider).value));

class NewerGridController extends StateNotifier<AsyncValue<NewerGridModel>> {
  NewerGridController(this.streaks, this.habits)
      : super(const AsyncValue.loading()) {
    if (habits != null) {
      state = AsyncValue.data(
          NewerGridModel.fromStreaks(streaks![habits!.first.activity.id]!));
      List<GridMonthModel> monthList = state.value!.gridMonths;
      // print('controller: ' + monthList.length.toString());
      for (var month in monthList) {
        print(month.dateTime.month);
      }
    }
  }

  Map<String, List<StreakModel>>? streaks;
  List<HabitModel>? habits;
}
