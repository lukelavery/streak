import 'package:flutter/material.dart';
import 'package:streak/src/features/calendar/ui/calendar.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/habits/ui/habit_card.dart';

import '../../streaks/models/counter_model.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({
    Key? key,
    required this.counters,
    required this.habits,
    required this.crossAxisCount,
    required this.increment,
    required this.streaks,
  }) : super(key: key);
  final Map<String, Counter> counters;
  final List<HabitModel> habits;
  final int crossAxisCount;
  final Future<void> Function(String, DateTime) increment;
  final Map<String, List<Streak>> streaks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: (MediaQuery.of(context).size.height - 200) / 2,
        crossAxisCount: crossAxisCount,
      ),
      itemCount: habits.length,
      itemBuilder: (context, index) {
        var habit = habits[index];
        DateTime now = DateTime.now();
        var streak = streaks[habit.id];
        // return HabitCard(
        //     habit: habit,
        //     name: habit.name,
        //     icon: IconData(habit.iconCodePoint,
        //         fontFamily: habit.iconFontFamily,
        //         fontPackage: habit.iconFontPackage),
        //     counter: counters[habit.id]?.count,
        //     increment: increment);

        if (streak != null) {
          if (
            // now.difference(streak[0].dateTime).inDays == 0
            getDifference(streak[0].dateTime, now) == 0
            ) {
          return GestureDetector(
            onTap: (() => Navigator.push(context, MaterialPageRoute(builder: ((context) => CalendarPage(streaks: streaks[habit.id], habit: habit,))))),
            child: SlessHabitCard(
              habit: habit,
              name: habit.name,
              icon: IconData(habit.iconCodePoint,
                  fontFamily: habit.iconFontFamily,
                  fontPackage: habit.iconFontPackage),
              counter: counters[habit.id]?.count,
            ),
          );
        }


        }
        // return GestureDetector(
        //   onTap: (() => Navigator.push(context, MaterialPageRoute(builder: ((context) => CalendarPage(streaks: streaks[habit.id]))))),
          return HabitCard(
            habit: habit,
            name: habit.name,
            icon: IconData(habit.iconCodePoint,
                fontFamily: habit.iconFontFamily,
                fontPackage: habit.iconFontPackage),
            counter: counters[habit.id]?.count,
            increment: increment,
            streaks: streaks[habit.id],
          // );
        );
      },
    );
  }
}
