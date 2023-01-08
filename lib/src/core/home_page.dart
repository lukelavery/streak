import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/habits/controllers/edit_habit_controller.dart';
import 'package:streak/src/features/activities/ui/pages/select_activity_page.dart';
import 'package:streak/src/features/habits/ui/habit_list_view.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/streaks/controllers/counter_controller.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/authenticate/ui/pages/user_profile_page.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editHabitState = ref.read(editHabitController.notifier);

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
      body: Consumer(builder: (context, ref, child) {
        final habitsState = ref.watch(habitControllerProvider);
        final streaksState = ref.watch(streakControllerProvider);
        return habitsState.when(
            data: (habits) {
              return streaksState.when(
                data: (data) {
                  if (habits.isEmpty) {
                    return Center(
                      child: Column(
                        children: const [
                          Spacer(),
                          Text('Create a habit to get started.', style: TextStyle(fontFamily: 'Montserrat'),),
                          Spacer(flex: 2,),
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
                error: (e, st) =>
                    const Center(child: CircularProgressIndicator()),
              );
            },
            loading: (() => const Center(child: CircularProgressIndicator())),
            error: (e, st) => const Center(child: CircularProgressIndicator()));
      }),
      // child: MyCircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectActivityPage()));
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.background,),
      ),
    );
  }
}

class AppBarActionButton extends StatelessWidget {
  const AppBarActionButton(
      {super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}

class LogoBanner extends StatelessWidget {
  const LogoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.none,
      // alignment: Alignment.centerLeft,
      children: const [
        Positioned(
            left: 23,
            child: Text(
              'streak',
              style: TextStyle(
                // color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            )),
        FaIcon(
          FontAwesomeIcons.bolt,
          // color: Colors.black,
          size: 22,
        ),
      ],
    );
  }
}
