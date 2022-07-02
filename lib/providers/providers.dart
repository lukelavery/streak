import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/habit_provider.dart';

import '../authenticate/services/application_state.dart';

final appStateProvider = ChangeNotifierProvider((ref) => ApplicationState());
final habitPovider = ChangeNotifierProvider((ref) => HabitProvider(uid: ref.watch(appStateProvider).uid));
