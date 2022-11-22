import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/controllers/habit_type_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/services/_habit_service.dart';

final habitSearchControllerProvider = StateNotifierProvider.autoDispose<
        HabitController, AsyncValue<List<HabitModel>>>(
    (ref) => HabitController(ref.read, ref.watch(habitTypeController)));

class HabitController extends StateNotifier<AsyncValue<List<HabitModel>>> {
  HabitController(this._read, this.habitType)
      : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription = _read(newHabitServiceProvider)
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
  late List<HabitModel> habitList;
  StreamSubscription<List<HabitModel>>? _habitStreamSubscription;

  void query(String q) {
    if (state.value != null) {
      state = AsyncValue.data(habitList
          .where(
              (element) => element.name.toLowerCase().contains(q.toLowerCase()))
          .toList());
      if (q != '') {
        state = AsyncValue.data([...state.value!, HabitModel(id: '', name: 'Create custom habit: $q', iconCodePoint: 0xe047, iconFontFamily: 'MaterialIcons', counter: 0)]);
      }
    }
  }
}
