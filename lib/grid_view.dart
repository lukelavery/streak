import 'package:flutter/material.dart';
import 'package:streak/models/habit_model.dart';
import 'package:streak/models/streak_model.dart';
import 'package:streak/ui/habit_card.dart';

import 'models/counter_model.dart';

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
  final List<Habit> habits;
  final int crossAxisCount;
  final Future<void> Function(String, DateTime) increment;
  final Map<String, List<Streak>> streaks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // mainAxisExtent: (MediaQuery.of(context).size.height - 82) / 2,
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
          if (now.difference(streak[0].dateTime).inDays == 0) {
          return slessHabitCard(
            habit: habit,
            name: habit.name,
            icon: IconData(habit.iconCodePoint,
                fontFamily: habit.iconFontFamily,
                fontPackage: habit.iconFontPackage),
            counter: counters[habit.id]?.count,
          );
        }


        }
        return HabitCard(
          habit: habit,
          name: habit.name,
          icon: IconData(habit.iconCodePoint,
              fontFamily: habit.iconFontFamily,
              fontPackage: habit.iconFontPackage),
          counter: counters[habit.id]?.count,
          increment: increment,
        );
      },
    );
  }
}
