import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: ((context, index) {
        HabitModel habit = habits[index];

        return Consumer(builder: (context, ref, child) {
          final gridState = ref.watch(gridControllerProvider);
          return gridState.when(
            data: (grid) {
              return Card(
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(
                        IconData(habit.iconCodePoint,
                            fontFamily: habit.iconFontFamily,
                            fontPackage: habit.iconFontPackage),
                      ),
                      Text(habit.name),
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
                                              color: grid[habit.id]![(181 - (parentIndex * 7 + index))].future ? Colors.white : grid[habit.id]![(181 - (parentIndex * 7 + index))].streak ? Colors.pink : Colors.grey[200],
                                              ),
                                          height: 8,
                                          width: 8,
                                        ),
                                      )),
                            )),
                  ),
                ),
              );
            },
            error: (e, st) =>
                    const Center(child: CircularProgressIndicator()),
            loading: (() => const Center(child: CircularProgressIndicator())),
          );
        });
      }),
    );
  }
}
