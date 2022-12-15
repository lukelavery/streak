import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_search_contoller.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate();
  // final void Function() addHabit;
  // final Future<void> Function(HabitPreset) addHabit;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // return ListView.builder(
    //     itemCount: habitList.length,
    //     itemBuilder: (context, index) {
    //       var habit = habitList[index];

    //       return ListTile(
    //           leading: Icon(IconData(habit.iconCodePoint,
    //               fontFamily: habit.iconFontFamily,
    //               fontPackage: habit.iconFontPackage)),
    //           title: Text(habit.name),
    //           onTap: () {
    //             Navigator.pop(context);
    //           });
    //     });
    return Consumer(builder: (context, ref, child) {
      final habitsState = ref.watch(habitSearchControllerProvider);
      return habitsState.when(
          data: (habits) {
            return ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  var habit = habits[index];

                  return ListTile(
                      leading: Icon(IconData(habit.iconCodePoint,
                          fontFamily: habit.iconFontFamily,
                          fontPackage: habit.iconFontPackage),),
                      title: Text(habit.name),
                      onTap: () {
                        Navigator.pop(context);
                      });
                });
          },
          loading: (() => const Center(child: CircularProgressIndicator())),
          error: (e, st) => const Center(child: CircularProgressIndicator()));
    });
  }
}
