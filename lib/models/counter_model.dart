import 'package:streak/models/streak_model.dart';

class Counter {
  const Counter({required this.count});

  final int count;

  factory Counter.fromStreaks(List<Streak>? streaks) {
    DateTime now = DateTime.now();

    if (streaks == null) {
      return const Counter(count: 0);
    }

    int difference = now.difference(streaks[0].dateTime).inDays;

    if (difference > 1) {
      return const Counter(count: 0);
    } else {
      int count = 1;

      for (var i = 1; i < streaks.length; i++) {
        int difference2 =
            streaks[i].dateTime.difference(streaks[(i - 1)].dateTime).inDays;

        int difference3 =
            streaks[i - 1].dateTime.difference(streaks[i].dateTime).inDays;
        print(difference3);

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
