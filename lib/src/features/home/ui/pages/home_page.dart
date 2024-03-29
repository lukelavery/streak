import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/activities/ui/pages/search_view.dart';
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
    final habitsState = ref.watch(habitControllerProvider);
    final streaksState = ref.watch(streakControllerProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
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
                return const Center(
                  child: Column(
                    children: [
                      Spacer(),
                      FaIcon(
                        FontAwesomeIcons.bolt,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Spacer(),
                          Icon(Icons.add_circle, color: Colors.grey, size: 20),
                          SizedBox(width: 5),
                          Text(
                            'Create a habit to get started.',
                            style: TextStyle(
                                fontFamily: 'Montserrat', color: Colors.grey),
                          ),
                          Spacer()
                        ],
                      ),
                      Spacer()
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
