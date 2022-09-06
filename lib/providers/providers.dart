import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/streaks_provider.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/controllers/habit_controller.dart';

// final habitPovider = ChangeNotifierProvider.autoDispose(
//     (ref) => HabitProvider(uid: ref.read(authControllerProvider).uid));

final streakProvider = ChangeNotifierProvider.autoDispose(((ref) =>
    StreakProvider(
        uid: ref.read(authControllerProvider).uid,
        habits: ref.watch(habitControllerProvider).value!)));

final editStateProvider = StateProvider<bool>((ref) {
  return false;
});
