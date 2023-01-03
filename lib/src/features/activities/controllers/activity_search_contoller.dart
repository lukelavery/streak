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
        .getHabits(habitType: habitType)
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
      if (q != '') {
        state = AsyncValue.data([
          ...state.value!,
          ActivityModel(
              id: '',
              name: 'Create custom habit: $q',
              iconCodePoint: 0xe047,
              iconFontFamily: 'MaterialIcons',
              type: habitType)
        ]);
      }
    }
  }

  void selectHabit(ActivityModel habit) {
    if (habit.id == '') {
      createHabit();
    } else {
      addHabit(habit: habit);
    }
  }

  void createHabit() async {
    ActivityPreset preset = activityPresets[habitType]!;
    await _read(activityServiceProvider)
        .createHabit(preset: preset, name: queryText);
  }

  void deleteHabit({required String activityId}) async {
    await _read(activityServiceProvider).deleteHabit(activityId: activityId);
  }

  void addHabit({required ActivityModel habit}) async {
    await _read(activityServiceProvider).addHabit(habit: habit);
  }
}
