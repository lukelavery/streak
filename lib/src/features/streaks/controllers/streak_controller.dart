import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/streaks/services/streak_service.dart';

final streakControllerProvider = StateNotifierProvider.autoDispose<
    StreakController,
    AsyncValue<Map<String, List<StreakModel>>>>((ref) => StreakController(ref.read));

class StreakController
    extends StateNotifier<AsyncValue<Map<String, List<StreakModel>>>> {
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

  StreamSubscription<Map<String, List<StreakModel>>>? _streakStreamSubscription;

  Future<void> addStreak(
      {required String activityId, required DateTime dateTime}) async {
    await _read(streakServiceProvider)
        .addStreak(activityId: activityId, dateTime: dateTime);
  }
}
