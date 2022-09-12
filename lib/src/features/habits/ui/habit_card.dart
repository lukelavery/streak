import 'package:flutter/material.dart';
import 'package:streak/src/features/calendar/ui/calendar.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/ui/counter.dart';
import 'package:vibration/vibration.dart';

class HabitCard extends StatefulWidget {
  const HabitCard({
    Key? key,
    required this.habit,
    required this.name,
    required this.icon,
    required this.counter,
    required this.increment,
    required this.streaks,
  }) : super(key: key);

  final HabitModel habit;
  final String name;
  final IconData icon;
  final int? counter;
  final Future<void> Function(String, DateTime) increment;
  final List<Streak>? streaks;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
        if (controller.value == 1) {
          DateTime dateTime = DateTime.now();
          widget.increment(widget.habit.id, dateTime);
          // HapticFeedback.heavyImpact();
          Vibration.vibrate(duration: 500);
          controller.reset();
        }
      });
    super.initState();
  }

  void startAnimation() {
    controller.forward();
  }

  void endAnimation() {
            if (controller.value < 0.1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) =>
                      CalendarPage(streaks: widget.streaks))));
        }
    controller.reset();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTapDown: (details) => startAnimation(),
          onTapUp: (details) => endAnimation(),
          onTapCancel: () => endAnimation(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 110,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircularProgressIndicator(
                    color: Colors.grey[300],
                    value: 1,
                    strokeWidth: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 110,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircularProgressIndicator(
                    color: const Color.fromARGB(255, 255, 197, 23),
                    value: controller.value,
                    strokeWidth: 10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(
                    widget.icon,
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: MyCounter(
                counter: widget.counter,
                habit: widget.habit,
              ),
                // Container(
                //   padding: const EdgeInsets.all(8),
                //   decoration: const BoxDecoration(
                //       // borderRadius: BorderRadius.circular(10),
                //       color: Colors.red,
                //       shape: BoxShape.circle),
                //   child: Text(
                //     widget.counter.toString(),
                //     style: const TextStyle(color: Colors.white, fontSize: 20),
                //   ),
                // ),
              ),
            ],
          ),
        ),
        Text(widget.name,
            style: const TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class SlessHabitCard extends StatelessWidget {
  const SlessHabitCard({
    Key? key,
    required this.habit,
    required this.name,
    required this.icon,
    required this.counter,
  }) : super(key: key);

  final HabitModel habit;
  final String name;
  final IconData icon;
  final int? counter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircularProgressIndicator(
                  color: Colors.grey[50],
                  value: 1,
                  strokeWidth: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 197, 23),
                radius: 40,
                child: Icon(
                  color: const Color.fromARGB(255, 217, 143, 15),
                  icon,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: MyCounter(
                counter: counter,
                habit: habit,
              ),
            ),
          ],
        ),
        Text(name,
            style: const TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w700)),
      ],
    );
  }
}
