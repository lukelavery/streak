import 'package:streak/src/features/streaks/models/streak_model.dart';

class Counter {
  const Counter({required this.count});

  final int count;

  factory Counter.fromStreaks(List<Streak>? streaks) {
    DateTime now = DateTime.now();

    if (streaks == null) {
      return const Counter(count: 0);
    }

    // int difference = now.difference(streaks[0].dateTime).inDays;
    int difference = getDifference(streaks[0].dateTime, now)!;

    if (difference > 1) {
      return const Counter(count: 0);
    } else {
      int count = 1;

      for (var i = 1; i < streaks.length; i++) {
        int difference3 =
            streaks[i - 1].dateTime.difference(streaks[i].dateTime).inDays;

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

int? getDifference(DateTime date1, DateTime date2) {
  var year1 = date1.year;
  var month1 = date1.month;
  var day1 = date1.day;

  var year2 = date2.year;
  var month2 = date2.month;
  var day2 = date2.day;

  if (year1 == year2) {
    if (month1 == month2) {
      return day2 - day1;
    }
  } 
  return null;
}
