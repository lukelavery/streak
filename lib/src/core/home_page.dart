import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/core/constants.dart';
import 'package:streak/src/features/habits/controllers/habit_view_controller.dart';
import 'package:streak/src/features/habits/ui/create_habit.dart';
import 'package:streak/src/features/habits/ui/grid_view.dart';
// import 'package:streak/src/features/habits/ui/search_delegate.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';
import 'package:streak/src/features/streaks/controllers/counter_controller.dart';
import 'package:streak/src/features/streaks/controllers/streak_controller.dart';
import 'package:streak/src/features/authenticate/ui/screens/user_profile_page.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColour,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColour,
        actions: [
          IconButton(
              onPressed: () {
                ref.read(habitViewController.notifier).update((state) {
                  return !state;
                });
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.grey,
              )),
          IconButton(
            color: Colors.grey,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()));
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
        title: Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.none,
          // alignment: Alignment.centerLeft,
          children: const [
            Positioned(
                left: 23,
                child: Text(
                  'streak',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                  ),
                )),
            FaIcon(
              FontAwesomeIcons.bolt,
              color: Colors.black,
              size: 22,
            ),
          ],
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final habitsState = ref.watch(habitControllerProvider);
        final streaksState = ref.watch(streakControllerProvider);
        return habitsState.when(
            data: (habits) {
              return streaksState.when(
                data: (data) => MyGridView(
                  counters: ref.watch(counterControllerProvider).value!,
                  habits: ref.watch(habitControllerProvider).value!,
                  crossAxisCount: ref
                      .watch(habitControllerProvider.notifier)
                      .getCrossAxisCount(),
                  increment:
                      ref.read(habitControllerProvider.notifier).addStreak,
                  streaks: ref.watch(streakControllerProvider).value!,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) =>
                    const Center(child: CircularProgressIndicator()),
              );
            },
            loading: (() => const Center(child: CircularProgressIndicator())),
            error: (e, st) => const Center(child: CircularProgressIndicator()));
      }),
      // child: MyCircularProgressIndicator()),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateHabitPage()));
          },
          child: const Icon(Icons.add),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const [
      //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
      //   BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'streaks')
      // ]),
    );
  }
}
