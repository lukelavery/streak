import 'package:flutter/material.dart';
import 'package:streak/habit_model.dart';
import 'package:streak/ui/habit_card.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({
    Key? key,
    required this.streaks,
    required this.habits,
    required this.crossAxisCount,
    required this.increment,
  }) : super(key: key);
  final Map<String, int> streaks;
  final List<Habit> habits;
  final int crossAxisCount;
  final Future<void> Function(Map<dynamic, dynamic>) increment;

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
        return HabitCard(
            habit: habit,
            name: habit.name,
            icon: IconData(habit.iconCodePoint,
                fontFamily: habit.iconFontFamily,
                fontPackage: habit.iconFontPackage),
            counter: streaks[habit.name],
            increment: increment);
      },
    );
  }
}
