import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/constants.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/controllers/habit_view_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/grid_controller.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

import '../../streaks/models/counter_model.dart';

class MyGridView extends ConsumerWidget {
  const MyGridView({
    Key? key,
    required this.counters,
    required this.habits,
    required this.crossAxisCount,
    required this.increment,
    required this.streaks,
  }) : super(key: key);
  final Map<String, Counter> counters;
  final List<HabitModel> habits;
  final int crossAxisCount;
  final Future<void> Function(String, DateTime) increment;
  final Map<String, List<Streak>> streaks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridStateNotifier = ref.read(gridControllerProvider.notifier);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: habits.length,
      itemBuilder: ((context, index) {
        HabitModel habit = habits[index];

        return Consumer(builder: (context, ref, child) {
          final gridState = ref.watch(gridControllerProvider);
          return gridState.when(
            data: (grid) {
              return Stack(children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                        Text(habit.name),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              gridStateNotifier.deleteStreak(habitId: habit.id);
                            },
                            icon: Icon(Icons.undo)),
                        GestureDetector(
                          onTap: () {
                            gridStateNotifier.addStreak(habitId: habit.id);
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
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          26,
                          (parentIndex) => Column(
                                children: List.generate(
                                    7,
                                    (index) => Padding(
                                          padding: const EdgeInsets.all(1.5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: grid[habit.id]![(181 -
                                                          (parentIndex * 7 +
                                                              index))]
                                                      .future
                                                  ? Colors.white
                                                  : grid[habit.id]![(181 -
                                                              (parentIndex * 7 +
                                                                  index))]
                                                          .streak
                                                      ? Colors.pink
                                                      : Colors.pink
                                                          .withOpacity(0.1),
                                            ),
                                            height: 8,
                                            width: 8,
                                          ),
                                        )),
                              )),
                    ),
                  ),
                ),
                ref.watch(habitViewController) == true
                    ? GestureDetector(
                        onTap: () {
                          ref
                              .read(habitControllerProvider.notifier)
                              .removeHabit(habits[index].id);
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 1,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade700,
                              size: 15,
                            ),
                            radius: 10,
                          ),
                        ),
                      )
                    : Container(),
              ]);
            },
            error: (e, st) => const Center(child: CircularProgressIndicator()),
            loading: (() => const Center(child: CircularProgressIndicator())),
          );
        });
      }),
    );
  }
}
