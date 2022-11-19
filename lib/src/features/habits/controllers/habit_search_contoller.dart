import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';
import 'package:streak/src/features/habits/services/_habit_service.dart';

final habitSearchControllerProvider = StateNotifierProvider.autoDispose<
    HabitController,
    AsyncValue<List<HabitModel>>>((ref) => HabitController(ref.read));

class HabitController extends StateNotifier<AsyncValue<List<HabitModel>>> {
  HabitController(this._read) : super(const AsyncValue.loading()) {
    _habitStreamSubscription?.cancel();
    _habitStreamSubscription =
        _read(newHabitServiceProvider).getHabits.listen((habits) {
      state = AsyncValue.data(habits.toList());
    });
  }

  @override
  void dispose() {
    _habitStreamSubscription?.cancel();
    super.dispose();
  }

  final Reader _read;
  final String _query = '';

  void query(String q) {
    if (state.value != null) {
      state = AsyncValue.data(state.value
          !.where((element) => element.name.toLowerCase().contains(_query))
          .toList());
    }
  }

  StreamSubscription<List<HabitModel>>? _habitStreamSubscription;
}
