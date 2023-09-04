import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/models/filter_model.dart';
import 'package:streak/src/features/activities/models/search_model.dart';
import 'package:streak/src/features/activities/services/activity_service.dart';

final activitySearchControllerProvider = StateNotifierProvider.autoDispose<
    ActivitySearchController,
    AsyncValue<SearchModel>>((ref) => ActivitySearchController(ref));

const List<FilterModel> filters = [
  FilterModel(display: 'All', value: null),
  FilterModel(display: 'Exercise', value: 'exercise'),
  FilterModel(display: 'Build a skill', value: 'skill'),
  FilterModel(display: 'Organise my life', value: 'organise'),
  FilterModel(display: 'Me time', value: 'me'),
  FilterModel(display: 'Family & firends', value: 'friends')
];

class ActivitySearchController extends StateNotifier<AsyncValue<SearchModel>> {
  ActivitySearchController(this._ref) : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription = _ref
        .read(activityServiceProvider)
        .getActivities(habitType: filters[habitType].value)
        .listen((habits) {
      habitList = habits;
      state = AsyncValue.data(
          SearchModel(activities: habitList, category: habitType));
    });
  }

  @override
  void dispose() {
    _habitStreamSubscription?.cancel();
    super.dispose();
  }

  final Ref _ref;
  int habitType = 0;
  late List<ActivityModel> habitList;
  StreamSubscription<List<ActivityModel>>? _habitStreamSubscription;
  String queryText = '';

  void query(String q) {
    if (q.length < 16) {
      queryText = q;
    } else {
      queryText = '${q.substring(0, 15)}...';
    }
    if (state.value != null) {
      state = AsyncValue.data(SearchModel(
        activities: habitList
            .where((element) =>
                element.name.toLowerCase().contains(queryText.toLowerCase()))
            .toList(),
        category: state.value!.category,
      ));
    }
  }

  void filter(int index) {
    var filter = filters[index];
    if (state.value != null) {
      state = AsyncValue.data(SearchModel(
        activities: filter.value == null
            ? habitList
                .where((element) => element.name
                    .toLowerCase()
                    .contains(queryText.toLowerCase()))
                .toList()
            : habitList
                .where((element) =>
                    element.type == filter.value &&
                    element.name
                        .toLowerCase()
                        .contains(queryText.toLowerCase()))
                .toList(),
        category: index,
      ));
    }
  }

  void deleteActivity({required String activityId}) async {
    await _ref
        .read(activityServiceProvider)
        .deleteActivity(activityId: activityId);
  }
}
