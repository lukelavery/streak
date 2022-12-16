import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/services/streak_service.dart';

final streakControllerProvider = StateNotifierProvider.autoDispose<
    StreakController,
    AsyncValue<Map<String, List<Streak>>>>((ref) => StreakController(ref.read));

class StreakController
    extends StateNotifier<AsyncValue<Map<String, List<Streak>>>> {
  StreakController(this._read) : super(const AsyncValue.loading()) {
    _streakStreamSubscription?.cancel();
    _streakStreamSubscription =
        _read(streakServiceProvider).retrieveStreaks.listen((streaks) {
      state = AsyncValue.data(streaks);
    });
  }

  @override
  void dispose() {
    _streakStreamSubscription?.cancel();
    super.dispose();
  }

  final Reader _read;
  // AsyncValue<Map<String, List<Streak>>>? previousState;

  StreamSubscription<Map<String, List<Streak>>>? _streakStreamSubscription;

  Future<void> addStreak(
      {required String habitId, required DateTime dateTime}) async {
    await _read(streakServiceProvider)
        .addStreak(habitId: habitId, dateTime: dateTime);
  }

  Future<void> deleteStreak({required String habitId}) async {
    await _read(streakServiceProvider).deleteStreak(habitId: habitId);
  }
}