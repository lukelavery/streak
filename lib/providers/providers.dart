import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/habit_provider.dart';
import 'package:streak/providers/streaks_provider.dart';

import '../authenticate/services/application_state.dart';

final appStateProvider = ChangeNotifierProvider((ref) => ApplicationState());
final habitPovider = ChangeNotifierProvider(
    (ref) => HabitProvider(uid: ref.read(appStateProvider).uid));
// final streakPovider = ChangeNotifierProvider(
//     (ref) => StreakProvider(uid: ref.watch(appStateProvider).uid), habits: ref.watch(habitPovider).habits);

final streakProvider = ChangeNotifierProvider(((ref) => StreakProvider(uid: ref.read(appStateProvider).uid, habits: ref.watch(habitPovider).habits)));