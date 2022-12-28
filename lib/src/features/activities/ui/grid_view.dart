import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/habit_controller.dart';
import 'package:streak/src/features/activities/controllers/habit_view_controller.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/activities/ui/habit_card.dart';
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
  final List<ActivityModel> habits;
  final int crossAxisCount;
  final Future<void> Function(String, DateTime) increment;
  final Map<String, List<Streak>> streaks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridStateNotifier = ref.read(gridControllerProvider.notifier);
    final habitStateNotifier = ref.read(habitControllerProvider.notifier);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: habits.length,
      itemBuilder: ((context, index) {
        ActivityModel habit = habits[index];

        return Consumer(builder: (context, ref, child) {
          final gridState = ref.watch(gridControllerProvider);
          return gridState.when(
            data: (grid) {
              return HabitCard(
                color: Colors.teal,
                  counter: counters[habit.id]!.count,
                  habit: habits[index],
                  tiles: grid.gridModels[habit.id]!.gridTiles,
                  today: grid.gridModels[habit.id]!.today,
                  edit: ref.watch(habitViewController),
                  handleButtonClick: gridStateNotifier.handleButtonClick,
                  removeHabit: habitStateNotifier.removeHabit);
            },
            error: (e, st) => const Center(child: CircularProgressIndicator()),
            loading: (() => const Center(child: CircularProgressIndicator())),
          );
        });
      }),
    );
  }
}
