import 'package:flutter/material.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/activity_grid.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class HabitCard extends StatelessWidget {
  const HabitCard(
      {Key? key,
      required this.habit,
      required this.tiles,
      required this.edit,
      required this.handleButtonClick,
      required this.removeHabit,
      required this.today})
      : super(key: key);

  final HabitModel habit;
  final bool edit;
  final bool today;
  final List<GridTileModel> tiles;
  final Future<void> Function({required String habitId}) handleButtonClick;
  final Future<void> Function({required String habitId}) removeHabit;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0.5,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    habit.name,
                    style: const TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(7),
                    onLongPress: (() {
                      handleButtonClick(habitId: habit.id);
                    }),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: today
                              ? Colors.pink.withOpacity(0.8)
                              : Colors.pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'complete',
                              style: TextStyle(
                                color: today ? Colors.white : Colors.grey,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.check_circle_outline,
                            color: today ? Colors.white : Colors.grey,
                            size: 17,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: ActivityGrid(tiles: tiles),
            ),
          ),
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
