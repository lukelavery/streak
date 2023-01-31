import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/habits/services/habit_service.dart';

// final editHabitController = StateProvider<bool>((ref) {
//   return false;
// });

final editHabitController =
    StateNotifierProvider.autoDispose<EditHabitController, bool>(
        (ref) => EditHabitController(ref.read));

class EditHabitController extends StateNotifier<bool> {
  EditHabitController(this._read) : super(false);

  final Reader _read;

  Timer? timer;

  void edit() {
    timer?.cancel();
    state = true;
    timer = Timer(const Duration(seconds: 3), () => state = false);
  }

  Future<void> removeHabit({required String habitId}) async {
    edit();
    await _read(habitServiceProvider).removeHabit(habitId: habitId);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
