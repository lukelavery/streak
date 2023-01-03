import 'package:streak/src/features/streaks/models/streak_model.dart';

class Counter {
  const Counter({required this.count});

  final int count;

  factory Counter.fromStreaks(List<StreakModel>? streaks) {
    DateTime now = DateTime.now();

    if (streaks == null) {
      return const Counter(count: 0);
    }

    int difference = getDifferenceInDays(streaks[0].dateTime, now);

    if (difference > 1) {
      return const Counter(count: 0);
    } else {
      int count = 1;

      for (var i = 1; i < streaks.length; i++) {
        int? difference3 =
            getDifferenceInDays(streaks[i].dateTime, streaks[i - 1].dateTime);

        if (difference3 > 1) {
          return Counter(count: count);
        } else {
          count++;
        }
      }
      return Counter(count: count);
    }
  }
}

int getDifferenceInDays(DateTime start, DateTime end) {
  Duration difference = end.difference(start);
  // If the difference is not a whole number of days, round up to the nearest day
  if (difference != Duration(days: difference.inDays)) {
    difference += const Duration(days: 1);
  }
  return difference.inDays;
}
