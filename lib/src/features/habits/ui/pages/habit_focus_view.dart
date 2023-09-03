import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/ui/pages/activity_icon.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/ui/streak_counter.dart';
import 'package:streak/src/features/streaks/controllers/counter_controller.dart';
import 'package:streak/src/features/streaks/controllers/grid_controller.dart';
import 'package:streak/src/features/streaks/ui/streak_grid_focus.dart';

class HabitFocusView extends ConsumerWidget {
  const HabitFocusView({
    super.key,
    required this.habit,
    required this.edit,
    required this.today,
  });

  final HabitModel habit;
  final bool edit;
  final bool today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final gridStateNotifier = ref.read(gridControllerProvider.notifier);
    final gridState = ref.watch(gridControllerProvider);
    final counters = ref.watch(counterControllerProvider);

    return gridState.when(
      data: (grids) {
        var today = grids.gridModels[habit.activity.id]!.today;

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                ActivityIcon(
                  activity: habit.activity,
                  color: colorScheme.onSurface,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  habit.activity.name,
                  style: const TextStyle(fontFamily: 'Montserrat'),
                ),
              ],
            ),
            actions: [
              StreakCounter(
                today: today,
                counter: counters.value?[habit.activity.id]?.count ?? 0,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10)
            ],
          ),
          body: NewStreakGridFocus(
            habit: habit,
          ),
          floatingActionButton: FloatingActionButton(
            elevation: today ? 1 : 0,
            backgroundColor: today
                ? colorScheme.primary
                : colorScheme.primary.withOpacity(0.3),
            onPressed: () {
              gridStateNotifier.handleButtonClick(
                activityId: habit.activity.id,
              );
            },
            child: Icon(
              Icons.task_alt,
              color: today ? Colors.white : Colors.grey,
            ),
          ),
        );
      },
      error: (e, st) => const Center(child: CircularProgressIndicator()),
      loading: (() => const Center(child: CircularProgressIndicator())),
    );
  }
}
