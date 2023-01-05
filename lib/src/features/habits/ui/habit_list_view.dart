import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/edit_habit_controller.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/habits/ui/habit_card.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/streaks/controllers/grid_controller.dart';
import 'package:streak/src/features/streaks/models/counter_model.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';

class HabitListView extends ConsumerWidget {
  const HabitListView({
    Key? key,
    required this.counters,
    required this.habits,
    required this.streaks,
  }) : super(key: key);
  final Map<String, Counter> counters;
  final List<HabitModel> habits;
  final Map<String, List<StreakModel>> streaks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridStateNotifier = ref.read(gridControllerProvider.notifier);
    final habitStateNotifier = ref.read(habitControllerProvider.notifier);

    return ListView.builder(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 75),
      itemCount: habits.length,
      itemBuilder: ((context, index) {
        ActivityModel activity = habits[index].activity;

        return Consumer(builder: (context, ref, child) {
          final gridState = ref.watch(gridControllerProvider);
          return gridState.when(
            data: (grid) {
              return HabitCard(
                color: Colors.blue,
                counter: counters[activity.id]!.count,
                habit: habits[index],
                tiles: grid.gridModels[activity.id]!.gridTiles,
                today: grid.gridModels[activity.id]!.today,
                edit: ref.watch(editHabitController),
                handleButtonClick: gridStateNotifier.handleButtonClick,
                removeHabit: habitStateNotifier.removeHabit,
              );
            },
            error: (e, st) => const Center(child: CircularProgressIndicator()),
            loading: (() => const Center(child: CircularProgressIndicator())),
          );
        });
      }),
    );
  }
}
