import 'package:flutter/material.dart';
import 'package:streak/src/features/activities/ui/pages/activity_icon.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/complete_button.dart';
import 'package:streak/src/features/habits/ui/pages/habit_focus_view.dart';
import 'package:streak/src/features/habits/ui/streak_counter.dart';
import 'package:streak/src/features/streaks/models/grid_tile_model.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    Key? key,
    required this.habit,
    required this.tiles,
    required this.edit,
    required this.handleButtonClick,
    required this.removeHabit,
    required this.today,
    required this.counter,
    required this.color,
  }) : super(key: key);

  final HabitModel habit;
  final bool edit;
  final bool today;
  final List<GridTileModel> tiles;
  final Future<void> Function({required String activityId}) handleButtonClick;
  final Future<void> Function({required String habitId}) removeHabit;
  final int counter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = Theme.of(context).colorScheme.surface;
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          surfaceTintColor: surfaceColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0.5,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitFocusView(
                    habit: habit,
                    edit: edit,
                    today: today,
                  ),
                ),
              );
            },
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: color.withOpacity(0.6),
                      child: ActivityIcon(
                        color: Colors.white,
                        activity: habit.activity,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    habit.activity.name,
                    style: const TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  StreakCounter(
                    today: today,
                    counter: counter,
                    color: color,
                  ),
                  CompleteButton(
                    today: today,
                    handleButtonClick: handleButtonClick,
                    activity: habit.activity,
                    color: color,
                  ),
                ],
              ),
            ),
            // subtitle: Padding(
            //   padding: const EdgeInsets.only(bottom: 5.0),
            //   child: StreakGrid(
            //     tiles: tiles,
            //     color: color,
            //   ),
            // ),
          ),
        ),
      ),
      edit == true
          ? GestureDetector(
              onTap: () {
                removeHabit(habitId: habit.id);
              },
              child: Material(
                shadowColor: Colors.grey,
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
