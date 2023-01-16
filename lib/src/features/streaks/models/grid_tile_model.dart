import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

class GridTileModel {
  const GridTileModel(
      {required this.streak, required this.future, required this.dateTime});

  final bool streak;
  final bool future;
  final DateTime dateTime;
}

class NewGridModel {
  const NewGridModel({required this.gridTiles, required this.today});

  final List<List<GridTileModel>> gridTiles;
  final bool today;

  factory NewGridModel.fromStreaks(List<StreakModel> streaks) {
    DateTime now = DateTime.now();
    DateTime nowYMD = DateTime(now.year, now.month, now.day);
    int offset = 7 - now.weekday;
    bool today = false;

    Set streakSet = Set.from(streaks.map(
      (e) {
        DateTime date = e.dateTime;
        return DateTime(date.year, date.month, date.day);
      },
    ));

    List<List<GridTileModel>> gridTiles = List.generate(
      26,
      (int week_index) {
        return List.generate(7, (day_index) {
          int index = 6 - day_index + week_index * 7;

          if (index < offset) {
            return GridTileModel(
                streak: false,
                future: true,
                dateTime: nowYMD.add(Duration(days: offset - index)));
          }
          if (streakSet
              .contains(nowYMD.subtract(Duration(days: index - offset)))) {
            return GridTileModel(
                streak: true,
                future: false,
                dateTime: nowYMD.add(Duration(days: offset - index)));
          }
          if (streakSet.contains(nowYMD)) {
            today = true;
          }
          return GridTileModel(
              streak: false,
              future: false,
              dateTime: nowYMD.add(Duration(days: offset - index)));
        }, growable: false);
      },
    );

    return NewGridModel(gridTiles: gridTiles, today: today);
  }
}

class NewGridViewModel {
  const NewGridViewModel({required this.gridModels});

  final Map<String, NewGridModel> gridModels;

  factory NewGridViewModel.fromHabits(
      Map<String, List<StreakModel>>? streaks, List<HabitModel> habits) {
    Map<String, NewGridModel> gridModels = {};

    if (streaks != null) {
      for (var habit in habits) {
        if (streaks[habit.activity.id] != null) {
          gridModels[habit.activity.id] = NewGridModel.fromStreaks(streaks[habit.activity.id]!);
        }
      }
    }
    return NewGridViewModel(gridModels: gridModels);
  }
}

class GridModel {
  const GridModel({required this.gridTiles, required this.today});

  final List<GridTileModel> gridTiles;
  final bool today;
}

class GridViewModel {
  const GridViewModel({required this.gridModels});

  final Map<String, GridModel> gridModels;

  factory GridViewModel.fromStreaks(
      Map<String, List<StreakModel>>? streaks, List<HabitModel> habits) {
    DateTime now = DateTime.now();
    DateTime nowYMD = DateTime(now.year, now.month, now.day);
    int offset = 7 - now.weekday;

    Map<String, GridModel> gridState = {};

    for (var habit in habits) {
      bool today = false;
      List streakDateList = [];

      if (streaks != null) {
        if (streaks[habit.activity.id] != null) {
          for (var streak in streaks[habit.activity.id]!) {
            DateTime streakYMD = DateTime(streak.dateTime.year,
                streak.dateTime.month, streak.dateTime.day);
            streakDateList.add(streakYMD);
          }
        }
      }
      gridState[habit.activity.id] = GridModel(
        gridTiles: List.generate(182, (index) {
          if (index < offset) {
            return GridTileModel(
                streak: false,
                future: true,
                dateTime: nowYMD.add(Duration(days: offset - index)));
          }
          if (streakDateList
              .contains(nowYMD.subtract(Duration(days: index - offset)))) {
            return GridTileModel(
                streak: true,
                future: false,
                dateTime: nowYMD.add(Duration(days: offset - index)));
          }
          if (streakDateList.contains(nowYMD)) {
            today = true;
          }

          return GridTileModel(
              streak: false,
              future: false,
              dateTime: nowYMD.add(Duration(days: offset - index)));
        }),
        today: today,
      );
    }
    return GridViewModel(
      gridModels: gridState,
    );
  }
}
