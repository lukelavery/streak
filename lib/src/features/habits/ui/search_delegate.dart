import 'package:flutter/material.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.addHabit});
  // final void Function() addHabit;
  final Future<void> Function(HabitPreset) addHabit;

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
    return ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          var habit = habitList[index];

          return ListTile(
              leading: Icon(IconData(habit.iconCodePoint,
                  fontFamily: habit.iconFontFamily,
                  fontPackage: habit.iconFontPackage)),
              title: Text(habit.name),
              onTap: () {
                addHabit(habit);
                Navigator.pop(context);
              });
        });
  }
}
