import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/activity_search_contoller.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/habits/ui/pages/create_habit_page.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitySearchState = ref.watch(activitySearchControllerProvider);
    final activitySearchStateNotifier =
        ref.read(activitySearchControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(onChanged: (value) {
          activitySearchStateNotifier.query(value);
        }),
      ),
      body: activitySearchState.when(
        data: (activitiesList) {
          return ListView.builder(
            itemCount: activitiesList.length + 1,
            itemBuilder: ((context, index) {
              final query = activitySearchStateNotifier.queryText;
              if (index == activitiesList.length) {
                if (query != '') {
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title: Text(
                        'Create custom habit: "${activitySearchStateNotifier.queryText}"',
                    ),
                    onTap: () {
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateHabitPage(name: activitySearchStateNotifier.queryText,)));
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                final ActivityModel activity = activitiesList[index];

                return ListTile(
                  trailing: activity.uid == null
                      ? const IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.transparent,
                          ),
                          onPressed: null)
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: (() {
                            activitySearchStateNotifier.deleteActivity(
                                activityId: activity.id);
                          }),
                        ),
                  leading: Icon(
                    IconData(activity.iconCodePoint,
                        fontFamily: activity.iconFontFamily,
                        fontPackage: activity.iconFontPackage),
                  ),
                  title: Text(activity.name),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CreateHabitPage(activity: activity, name: activity.name,)));
                  },
                );
              }
            }),
          );
        },
        error: (error, st) {
          return Text(error.toString());
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
