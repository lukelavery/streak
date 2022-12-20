import 'package:flutter/material.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/activity_grid.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    Key? key,
    required this.habit,
    required this.tiles,
    required this.edit,
    required this.deleteStreak,
    required this.addStreak,
    required this.removeHabit,
  }) : super(key: key);

  final HabitModel habit;
  final bool edit;
  final List<GridTileModel> tiles;
  final Future<void> Function({required String habitId}) deleteStreak;
  final Future<void> Function({required String habitId}) addStreak;
  final Future<void> Function({required String habitId}) removeHabit;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0.5,
        child: ListTile(
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.pink.shade200,
                child: Icon(
                  IconData(habit.iconCodePoint,
                      fontFamily: habit.iconFontFamily,
                      fontPackage: habit.iconFontPackage),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10,),
              Text(habit.name, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500),),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    deleteStreak(habitId: habit.id);
                  },
                  icon: const Icon(Icons.undo)),
              GestureDetector(
                onTap: () {
                  addStreak(habitId: habit.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          subtitle: ActivityGrid(tiles: tiles),
        ),
      ),
      edit == true
          ? GestureDetector(
              onTap: () {
                removeHabit(habitId: habit.id);
              },
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 1,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey.shade700,
                    size: 15,
                  ),
                ),
              ),
            )
          : Container(),
    ]);
  }
}
