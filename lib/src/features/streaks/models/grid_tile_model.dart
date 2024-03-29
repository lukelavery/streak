import 'package:intl/intl.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
List<String> monthStringList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class GridTileModel {
  const GridTileModel(
      {required this.streak, required this.future, required this.dateTime});

  final bool streak;
  final bool future;
  final DateTime dateTime;

  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(dateTime);
  }
}

class GridWeekModel {
  const GridWeekModel({
    required this.days,
    required this.dateTime,
  });

  final List<GridTileModel> days;
  final DateTime dateTime;
}

class GridMonthModel {
  const GridMonthModel({required this.weeks, required this.dateTime});

  final List<GridWeekModel> weeks;
  final DateTime dateTime;
}

class NewerGridModel {
  const NewerGridModel({required this.gridMonths});

  final List<GridMonthModel> gridMonths;

  factory NewerGridModel.fromStreaks(List<StreakModel>? streaks) {
    DateTime now = DateTime.now();
    DateTime nowYMD = DateTime(now.year, now.month, now.day);
    int offset = 7 - now.weekday;
    List<GridMonthModel> monthList = [];
    List<GridWeekModel> weekList = [];

    Set streakSet = streaks != null
        ? Set.from(streaks.map(
            (e) {
              DateTime date = e.dateTime;
              return DateTime(date.year, date.month, date.day);
            },
          ))
        : {};

    for (int weekIndex = 0; weekIndex < 26; weekIndex++) {
      var week = GridWeekModel(
        days: List.generate(
          7,
          (dayIndex) {
            int index = 6 - dayIndex + weekIndex * 7;

            if (index < offset) {
              return GridTileModel(
                streak: false,
                future: true,
                dateTime: nowYMD.add(
                  Duration(days: offset - index),
                ),
              );
            }
            if (streakSet.contains(
              nowYMD.subtract(
                Duration(days: index - offset),
              ),
            )) {
              return GridTileModel(
                streak: true,
                future: false,
                dateTime: nowYMD.add(
                  Duration(days: offset - index),
                ),
              );
            }
            return GridTileModel(
                streak: false,
                future: false,
                dateTime: nowYMD.add(Duration(days: offset - index)));
          },
          growable: false,
        ),
        dateTime: nowYMD.subtract(Duration(days: weekIndex * 7 - 6 + offset)),
      );
      if (weekList.isEmpty) {
        weekList.insert(0, week);
      } else {
        if (week.days.first.dateTime.month ==
            weekList.first.days.first.dateTime.month) {
          weekList.insert(0, week);
        } else {
          monthList.add(GridMonthModel(
              weeks: weekList, dateTime: weekList.first.dateTime));
          weekList = [];
          weekList.insert(0, week);
        }
      }
      if (weekIndex == 25 && weekList.isNotEmpty) {
        monthList.add(GridMonthModel(
            weeks: weekList, dateTime: weekList.first.days.first.dateTime));
      }
    }
    return NewerGridModel(gridMonths: monthList);
  }
}

class GridMap {
  const GridMap({required this.gridMap});

  final Map<String, NewerGridModel> gridMap;

  factory GridMap.fromHabits(
      Map<String, List<StreakModel>>? streaks, List<HabitModel> habits) {
    Map<String, NewerGridModel> gridModels = {};

    if (streaks != null) {
      for (var habit in habits) {
        // if (streaks[habit.activity.id] != null) {
        gridModels[habit.activity.id] =
            NewerGridModel.fromStreaks(streaks[habit.activity.id]);
        // }
      }
    }
    return GridMap(gridMap: gridModels);
  }
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
      (int weekIndex) {
        return List.generate(7, (dayIndex) {
          int index = 6 - dayIndex + weekIndex * 7;

          if (index < offset) {
            return GridTileModel(
              streak: false,
              future: true,
              dateTime: nowYMD.add(
                Duration(days: offset - index),
              ),
            );
          }
          if (streakSet.contains(
            nowYMD.subtract(
              Duration(days: index - offset),
            ),
          )) {
            return GridTileModel(
              streak: true,
              future: false,
              dateTime: nowYMD.add(
                Duration(days: offset - index),
              ),
            );
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
          gridModels[habit.activity.id] =
              NewGridModel.fromStreaks(streaks[habit.activity.id]!);
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
