import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/controllers/habit_view_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

class MyCounter extends ConsumerWidget {
  const MyCounter({Key? key, required this.counter, required this.habit}) : super(key: key);

  final int? counter;
  final HabitModel habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final edit = ref.watch(habitViewController);
    final habits = ref.read(habitControllerProvider.notifier);

    if (edit) {
      return GestureDetector(
        onTap: (() {
          habits.removeHabit(habit.id);
          ref.read(habitViewController.notifier).update((state) => !state);
        }),
        child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                shape: BoxShape.circle),
            child: const Icon(Icons.remove)),
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
