import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/pages/habit_focus_view.dart';
import 'package:streak/src/features/streaks/ui/streak_grid.dart';
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
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HabitFocusView(
                            habit: habit,
                            tiles: tiles,
                          )));
            },
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: color.withOpacity(0.6),
                      child: HabitIcon(
                        color: Colors.white,
                        habit: habit,
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
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: StreakGrid(
                tiles: tiles,
                color: color,
              ),
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

class CompleteButton extends StatelessWidget {
  const CompleteButton({
    Key? key,
    required this.today,
    required this.handleButtonClick,
    required this.activity,
    required this.color,
  }) : super(key: key);

  final bool today;
  final Future<void> Function({required String activityId}) handleButtonClick;
  final ActivityModel activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(7),
      onLongPress: (() {
        handleButtonClick(activityId: activity.id);
      }),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: today ? color.withOpacity(0.8) : color.withOpacity(0.2),
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
              // Icons.check_circle_outline,
              Icons.task_alt,
              color: today ? Colors.white : Colors.grey,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}

class StreakCounter extends StatelessWidget {
  const StreakCounter(
      {Key? key,
      required this.today,
      required this.counter,
      required this.color})
      : super(key: key);

  final bool today;
  final int counter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final activeStreak = counter > 0 ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: today ? color.withOpacity(0.8) : color.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            FaIcon(
              FontAwesomeIcons.fireFlameCurved,
              size: 17,
              color: activeStreak
                  ? Theme.of(context).colorScheme.onSurface
                  : Colors.grey,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              counter.toString(),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: activeStreak
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HabitIcon extends StatelessWidget {
  const HabitIcon({super.key, required this.habit, required this.color});

  final HabitModel habit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return habit.activity.iconFontPackage == "font_awesome_flutter"
        ? FaIcon(
            IconData(habit.activity.iconCodePoint,
                fontFamily: habit.activity.iconFontFamily,
                fontPackage: habit.activity.iconFontPackage),
            color: color,
          )
        : Icon(
            IconData(habit.activity.iconCodePoint,
                fontFamily: habit.activity.iconFontFamily,
                fontPackage: habit.activity.iconFontPackage),
            color: color,
          );
  }
}
