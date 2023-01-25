import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/edit_habit_controller.dart';
import 'package:streak/src/features/activities/ui/pages/select_activity_page.dart';
import 'package:streak/src/features/habits/ui/habit_list_view.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/home/ui/widgets/buttons/app_bar_action_button.dart';
import 'package:streak/src/features/home/ui/widgets/design/logo_banner.dart';
import 'package:streak/src/features/streaks/controllers/counter_controller.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/user/ui/pages/user_profile_page.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editHabitState = ref.read(editHabitController.notifier);
    final habitsState = ref.watch(habitControllerProvider);
    final streaksState = ref.watch(streakControllerProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          AppBarActionButton(
            icon: Icons.edit,
            onPressed: () {
              editHabitState.update(
                (state) {
                  return !state;
                },
              );
            },
          ),
          AppBarActionButton(
            icon: Icons.add_circle,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SelectActivityPage()));
            },
          ),
          AppBarActionButton(
            icon: Icons.account_circle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfilePage(),
                ),
              );
            },
          ),
        ],
        title: const LogoBanner(),
      ),
      body: habitsState.when(
        data: (habits) {
          return streaksState.when(
            data: (data) {
              if (habits.isEmpty) {
                return Center(
                  child: Column(
                    children: const [
                      Spacer(),
                      Text(
                        'Create a habit to get started.',
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                );
              }
              return HabitListView(
                counters: ref.watch(counterControllerProvider).value!,
                habits: ref.watch(habitControllerProvider).value!,
                streaks: ref.watch(streakControllerProvider).value!,
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => const Center(child: CircularProgressIndicator()),
          );
        },
        loading: (() => const Center(child: CircularProgressIndicator())),
        error: (e, st) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
