import 'package:flutter/material.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/habit_card.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';
import 'package:streak/src/features/streaks/ui/streak_grid_focus.dart';

class HabitFocusView extends StatelessWidget {
  const HabitFocusView({super.key, required this.habit, required this.tiles});

  final HabitModel habit;
  final List<GridTileModel> tiles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            HabitIcon(habit: habit, color: Theme.of(context).colorScheme.onSurface,),
            const SizedBox(width: 10,),
            Text(habit.activity.name, style: const TextStyle(fontFamily: 'Montserrat'),),
          ],
        ),
      ),
      body: StreakGridFocus(tiles: tiles,),
    );
  }
}
