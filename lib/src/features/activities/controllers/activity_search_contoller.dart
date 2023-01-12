import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/activity_type_controller.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/activities/services/activity_service.dart';

final activitySearchControllerProvider = StateNotifierProvider.autoDispose<
        ActivitySearchController, AsyncValue<List<ActivityModel>>>(
    (ref) => ActivitySearchController(ref.read, ref.watch(activityTypeController)));

class ActivitySearchController extends StateNotifier<AsyncValue<List<ActivityModel>>> {
  ActivitySearchController(this._read, this.habitType)
      : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription = _read(activityServiceProvider)
        .getActivitiesByType(habitType: habitType)
        .listen((habits) {
      habitList = habits;
      state = AsyncValue.data(habitList);
    });
  }

  @override
  void dispose() {
    _habitStreamSubscription?.cancel();
    super.dispose();
  }

  final Reader _read;
  final String habitType;
  late List<ActivityModel> habitList;
  StreamSubscription<List<ActivityModel>>? _habitStreamSubscription;
  String queryText = '';

  void query(String q) {
    queryText = q;
    if (state.value != null) {
      state = AsyncValue.data(habitList
          .where(
              (element) => element.name.toLowerCase().contains(q.toLowerCase()))
          .toList());
    }
  }

  void deleteActivity({required String activityId}) async {
    await _read(activityServiceProvider).deleteActivity(activityId: activityId);
  }
}
