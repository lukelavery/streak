import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/habit_provider.dart';
import 'package:streak/providers/streaks_provider.dart';

import '../authenticate/services/application_state.dart';

final appStateProvider = ChangeNotifierProvider.autoDispose((ref) => ApplicationState());
final habitPovider = ChangeNotifierProvider.autoDispose(
    (ref) => HabitProvider(uid: ref.read(appStateProvider).uid));
// final streakPovider = ChangeNotifierProvider(
//     (ref) => StreakProvider(uid: ref.watch(appStateProvider).uid), habits: ref.watch(habitPovider).habits);

final streakProvider = ChangeNotifierProvider.autoDispose(((ref) => StreakProvider(uid: ref.read(appStateProvider).uid, habits: ref.watch(habitPovider).habits)));

final editStateProvider = StateProvider<bool>((ref) {
  return false;
});