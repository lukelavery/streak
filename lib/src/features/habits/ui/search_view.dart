import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/goals/ui/pages/create_goal_page.dart';
import 'package:streak/src/features/habits/controllers/habit_search_contoller.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitSearchState = ref.watch(habitSearchControllerProvider);
    final habitSearchStateNotifier =
        ref.read(habitSearchControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(onChanged: (value) {
          ref.read(habitSearchControllerProvider.notifier).query(value);
        }),
        backgroundColor: Colors.grey[50],
      ),
      body: habitSearchState.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return ListTile(
                trailing: data[index].uid == null
                    ? const IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.transparent,
                        ),
                        onPressed: null)
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: (() {
                          habitSearchStateNotifier.deleteHabit(
                              habitId: data[index].id);
                        }),
                      ),
                leading: Icon(
                  IconData(data[index].iconCodePoint,
                      fontFamily: data[index].iconFontFamily,
                      fontPackage: data[index].iconFontPackage),
                ),
                title: Text(data[index].name),
                onTap: () {
                  // habitSearchStateNotifier.selectHabit(data[index]);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateGoalPage(habit: data[index])));
                },
              );
            }),
          );
        },
        error: (error, st) {
          return Text(error.toString());
        },
        loading: () {
          return const Text('loading');
        },
      ),
    );
  }
}
