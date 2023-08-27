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

    final Color surfaceColor = Theme.of(context).colorScheme.surface;
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          onChanged: (value) {
            activitySearchStateNotifier.query(value);
          },
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      FilterModel filter = filters[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            activitySearchStateNotifier.filter(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: activitySearchState.value?.category ==
                                          index
                                      ? primaryColor
                                      : surfaceColor,
                                ),
                                color: surfaceColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(filter.display),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            )),
      ),
      body: activitySearchState.when(
        data: (searchModel) {
          List<ActivityModel> activities = searchModel.activities;
          return ListView.builder(
            itemCount: activities.length + 1,
            itemBuilder: ((context, index) {
              final query = activitySearchStateNotifier.queryText;
              if (index == activities.length) {
                if (query != '') {
                  return ListTile(
                    leading: const Icon(Icons.add),
                    title: Text(
                      'Create custom habit: "${activitySearchStateNotifier.queryText}"',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateHabitPage(
                                    name: activitySearchStateNotifier.queryText,
                                  )));
                    },
                  );
                } else {
                  return Container();
                }
              } else {
                final ActivityModel activity = activities[index];

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
                            builder: (context) => CreateHabitPage(
                                  activity: activity,
                                  name: activity.name,
                                )));
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
