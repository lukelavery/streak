import 'package:streak/src/features/streaks/models/streak_model.dart';

class Counter {
  const Counter({required this.count});

  final int count;

  factory Counter.fromStreaks(List<StreakModel>? streaks) {
    print('start');
    DateTime now = DateTime.now();

    if (streaks == null) {
      print('end');
      return const Counter(count: 0);
    }

    int difference = getDifferenceInDays(streaks[0].dateTime, now);

    if (difference > 1) {
      print('end');
      return const Counter(count: 0);
    } else {
      int count = 1;

      for (var i = 1; i < streaks.length; i++) {
        int? difference3 =
            getDifferenceInDays(streaks[i].dateTime, streaks[i - 1].dateTime);

        if (difference3 > 1) {
          print('end');
          return Counter(count: count);
        } else {
          count++;
        }
      }
      print('end');
      return Counter(count: count);
    }
  }
}

int getDifferenceInDays(DateTime start, DateTime end) {
  start = DateTime(start.year, start.month, start.day);
  end = DateTime(end.year, end.month, end.day);
  Duration difference = end.difference(start);
  return difference.inDays;
}
