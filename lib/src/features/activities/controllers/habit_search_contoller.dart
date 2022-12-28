import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/controllers/habit_type_controller.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/activities/services/habit_service.dart';

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
          HabitModel(
              id: '',
              name: 'Create custom habit: $q',
              iconCodePoint: 0xe047,
              iconFontFamily: 'MaterialIcons',
              type: habitType)
        ]);
      }
    }
  }

  void selectHabit(HabitModel habit) {
    if (habit.id == '') {
      createHabit();
    } else {
      addHabit(habit: habit);
    }
  }

  void createHabit() async {
    NewHabitPreset preset = habitPresets[habitType]!;
    await _read(newHabitServiceProvider)
        .createHabit(preset: preset, name: queryText);
  }

  void deleteHabit({required String habitId}) async {
    await _read(newHabitServiceProvider).deleteHabit(habitId: habitId);
  }

  void addHabit({required HabitModel habit}) async {
    await _read(newHabitServiceProvider).addHabit(habit: habit);
  }
}