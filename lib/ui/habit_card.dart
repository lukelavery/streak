import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/providers.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:vibration/vibration.dart';

// class HabitCard extends StatelessWidget {
//   const HabitCard({
//     Key? key,
//     required this.name,
//     required this.icon,
//     required this.counter,
//   }) : super(key: key);

//   final String name;
//   final IconData icon;
//   final int counter;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           alignment: Alignment.topRight,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: CircleAvatar(
//                 radius: 40,
//                 child: Icon(
//                   icon,
//                   size: 35,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: const BoxDecoration(
//                   // borderRadius: BorderRadius.circular(10),
//                   color: Colors.red,
//                   shape: BoxShape.circle),
//               child: Text(
//                 counter.toString(),
//                 style: const TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ],
//         ),
//         Text(name,
//             style: const TextStyle(
//                 fontFamily: 'Montserrat', fontWeight: FontWeight.w700)),
//       ],
//     );
//   }
// }

class HabitCard extends StatefulWidget {
  const HabitCard({
    Key? key,
    required this.habit,
    required this.name,
    required this.icon,
    required this.counter,
    required this.increment,
  }) : super(key: key);

  final HabitModel habit;
  final String name;
  final IconData icon;
  final int? counter;
  final Future<void> Function(String, DateTime) increment;

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
                    color: Color.fromARGB(255, 255, 197, 23),
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
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                      shape: BoxShape.circle),
                  child: Text(
                    widget.counter.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
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

class slessHabitCard extends StatelessWidget {
  const slessHabitCard({
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
                backgroundColor: Color.fromARGB(255, 255, 197, 23),
                radius: 40,
                child: Icon(
                  color: Color.fromARGB(255, 217, 143, 15),
                  icon,
                  size: 25,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: MyCounter(counter: counter, habit: habit,),
              // child: Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: const BoxDecoration(
              //       // borderRadius: BorderRadius.circular(10),
              //       color: Colors.red,
              //       shape: BoxShape.circle),
              //   child: Text(
              //     counter.toString(),
              //     style: const TextStyle(color: Colors.white, fontSize: 20),
              //   ),
              // ),
              // child: Stack(alignment: Alignment.center, children: [
              //   Container(decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(100)), height: 30, width: 30,),
              //   FaIcon(FontAwesomeIcons.fire, size: 35, color: Colors.orange,),
              //   Text(counter.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              // ],)
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

class MyCounter extends ConsumerWidget {
  const MyCounter({Key? key, required this.counter, required this.habit}) : super(key: key);

  final int? counter;
  final HabitModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edit = ref.watch(editStateProvider);
    final habits = ref.read(habitControllerProvider.notifier);

    if (edit) {
      return GestureDetector(
        onTap: (() {
          habits.deleteHabit(habit.id);
          ref.read(editStateProvider.notifier).update((state) => !state);
        }),
        child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                shape: BoxShape.circle),
            child: Icon(Icons.remove)),
      );
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(10),
          color: Colors.red,
          shape: BoxShape.circle),
      child: Text(
        counter.toString(),
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
