import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/ui/pages/activity_icon.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';
import 'package:streak/src/features/streaks/ui/streak_grid_focus.dart';

class HabitFocusView extends StatelessWidget {
  const HabitFocusView({super.key, required this.habit, required this.tiles});

  final HabitModel habit;
  final List<GridTileModel> tiles;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ActivityIcon(
              activity: habit.activity,
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              habit.activity.name,
              style: const TextStyle(fontFamily: 'Montserrat'),
            ),
          ],
        ),
      ),
      body: NewStreakGridFocus(
        habit: habit,
      ),
    );
  }
}
