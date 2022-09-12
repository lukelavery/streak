import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarViewController = StateNotifierProvider<CalendarController, DateTime>((ref) {
  return CalendarController();
});

class CalendarController extends StateNotifier<DateTime> {
  CalendarController() : super(DateTime.now());

  void incrementMonth() {
    if (state.month == 12) {
      state = DateTime(state.year + 1, 1);
    } else {
      state = DateTime(state.year, state.month + 1);
    }
  }

  void decrementMonth() {
    if (state.month == 1) {
      state = DateTime(state.year - 1, 12);
    } else {
      state = DateTime(state.year, state.month - 1);
    }
  }
}
