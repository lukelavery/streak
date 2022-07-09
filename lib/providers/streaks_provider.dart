import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streak/models/counter_model.dart';
import 'package:streak/models/habit_model.dart';

import '../models/streak_model.dart';

class StreakProvider extends ChangeNotifier {
  StreakProvider({required String? uid, required List<Habit> habits})
      : _uid = uid,
        _habits = habits {
    init();
  }

  final String? _uid;
  final List<Habit> _habits;

  Map<String, List<Streak>> _streaks = {};
  Map<String, List<Streak>> get streaks => _streaks;

  Map<String, Counter> _counters = {};
  Map<String, Counter> _baseCounters = {};
  Map<String, Counter> get counters => _counters;

  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');
  // CollectionReference streaksRef =
  //     FirebaseFirestore.instance.collection('streaks');

  Future<void> init() async {
    final ref2 = streaksRef
        .where('uid', isEqualTo: _uid)
        .orderBy('timestamp', descending: true);

    for (var habit in _habits) {
      _baseCounters[habit.id] = Counter(count: 0);
    }

    ref2.snapshots().listen((event) {
      _streaks = {};
      _counters = _baseCounters;
      for (var doc in event.docs) {
        Streak streak = Streak.fromMap(doc.data() as Map<String, dynamic>?);

        var oldList = _streaks[streak.habitId];

        if (oldList != null) {
          List<Streak> newList = oldList;
          newList.add(streak);
          _streaks[streak.habitId] = newList;
        } else {
          _streaks[streak.habitId] = [streak];
        }
      }
      _streaks.keys.forEach((element) {
        _counters[element] = Counter.fromStreaks(_streaks[element]);
      });
      notifyListeners();
    }, onError: (error) {});
  }

  Future<void> addStreak(String habitId, DateTime dateTime) {
    Map<String, dynamic> data = {};

    data['uid'] = _uid;
    data['habitId'] = habitId;
    data['timestamp'] = Timestamp.fromDate(dateTime);

    return streaksRef.add(data);
  }
}
