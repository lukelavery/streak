import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/calendar/controllers/calendar_controller.dart';
import 'package:streak/src/features/calendar/domain/calendar_model.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({Key? key, this.streaks, required this.habit})
      : super(key: key);

  final List<Streak>? streaks;
  final HabitModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    DateTime view = ref.watch(calendarViewController);

    var calendar = ref.read(calendarProvider);
    List<String> days = calendar.days;
    String month = calendar.getMonthString(view);
    List<DateTime> dates = calendar.getDates(view);

    Map<DateTime, bool> streakDates = {};

    for (var d in dates) {
      streakDates[d] = false;
      if (streaks != null) {
        for (var s in streaks!) {
          if (d ==
              DateTime(s.dateTime.year, s.dateTime.month, s.dateTime.day)) {
            streakDates[d] = true;
          }
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      ref
                          .read(calendarViewController.notifier)
                          .decrementMonth();
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                // Text(month),
                Text(month,
                    style: const TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w700)),
                IconButton(
                  onPressed: () {
                    ref.read(calendarViewController.notifier).incrementMonth();
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                  child: Text(days[0],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[1],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[2],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[3],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[4],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[5],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text(days[6],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600))),
            ]),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, childAspectRatio: width / height),
                // SliverGridDelegateWithMaxCrossAxisExtent(
                //     maxCrossAxisExtent: width / 7,
                //     // childAspectRatio: 3 / 2,
                //     mainAxisSpacing: 0,
                //     mainAxisExtent: height / 6,
                //   ),
                itemCount: 42,
                itemBuilder: (BuildContext context, index) {
                  DateTime date = dates[index];
                  DateTime date2 = dates[21];
                  DateTime now = DateTime.now();
                  bool isToday = DateTime(now.year, now.month, now.day) == date;
                  bool isStreak = streakDates[dates[index]]!;
                  bool isCurrentMonth = DateTime(date.year, date.month) ==
                      DateTime(date2.year, date2.month);

                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        showAlertDialog(context, habit, ref);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: isToday
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.blue, width: 1))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 0.25),
                              ),
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            isCurrentMonth
                                ? Text(dates[index].day.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500))
                                : Text(
                                    dates[index].day.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500),
                                  ),
                            const Spacer(
                              flex: 4,
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  isStreak ? Colors.blue : Colors.grey[50],
                            ),
                            const Spacer(
                              flex: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (() {})),
    );
  }
}

showAlertDialog(BuildContext context, HabitModel habit, WidgetRef ref) {
  Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('OK'));

  Widget undoButton = TextButton(
      onPressed: () {
        // ref
        //     .read(streakControllerProvider.notifier)
        //     .deleteStreak(habitId: habit.id);
        Navigator.pop(context);
      },
      child: const Text('Undo'));

  AlertDialog alert = AlertDialog(
    title: const Text('Alert Dialog'),
    content: const Text('message'),
    actions: [undoButton, okButton],
  );

  showDialog(context: context, builder: ((context) => alert));
}
