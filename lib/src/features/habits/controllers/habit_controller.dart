import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/user/services/user_preferences.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/services/habit_service.dart';

final habitControllerProvider = StateNotifierProvider.autoDispose<
    HabitController,
    AsyncValue<List<HabitModel>>>((ref) => HabitController(ref));

class HabitController extends StateNotifier<AsyncValue<List<HabitModel>>> {
  HabitController(this._ref) : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription =
        _ref.read(habitServiceProvider).getHabits().listen((habits) {
      final map = UserSimplePreferenes.getHabitOrder();
      if (map != null) {
        int maxVal = map.values.length + 1;
        habits.sort((a, b) {
          int va = map.containsKey(a.id) ? map[a.id]! : maxVal;
          int vb = map.containsKey(b.id) ? map[b.id]! : maxVal;
          return va - vb;
        });
      }
      state = AsyncValue.data(habits);
    });
  }

  @override
  void dispose() {
    _habitStreamSubscription?.cancel();
    super.dispose();
  }

  final Ref _ref;
  AsyncValue<List<HabitModel>>? previousState;

  StreamSubscription<List<HabitModel>>? _habitStreamSubscription;

  Future<void> removeHabit({required String habitId}) async {
    await _ref.read(habitServiceProvider).removeHabit(habitId: habitId);
  }

  void reorderHabits(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex--;
    }
    final item = state.value?.removeAt(oldIndex);
    state.value?.insert(newIndex, item!);

    final habitList = state.value;
    if (habitList != null) {
      UserSimplePreferenes.saveHabitOrder(habitList);
    }
  }
}
