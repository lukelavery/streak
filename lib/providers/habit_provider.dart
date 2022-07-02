import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streak/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  HabitProvider({required String? uid}) : _uid = uid {
    init();
  }

  final String? _uid;
  // Map<String, int> _streaks = {};
  // Map<String, int> get streaks => _streaks;
  List<Habit> _habits = [];
  List<Habit> get habits => _habits;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits');
  // CollectionReference streaksRef =
  //     FirebaseFirestore.instance.collection('streaks');

  Future<void> init() async {
    final ref = habitsRef.where('uid', isEqualTo: _uid);
    ref.snapshots().listen((event) {
      _habits = [];
      for (var doc in event.docs) {
        Habit habit = Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>);
        _habits.add(habit);
      }
      notifyListeners();
    }, onError: (error) {});

    // final ref2 = streaksRef.where('uid', isEqualTo: _uid);
    // ref2.snapshots().listen((event) {
    //   _streaks = {};
    //   for (var doc in event.docs) {
    //     var data = doc.data();
    //     Habit habit = Habit.fromMap(doc.id, data as Map<String, dynamic>);
    //     _streaks[habit.name] = data['streak'];
    //   }
    //   notifyListeners();
    // },
    onError:
    (error) {};
  }

  Future<void> addHabit(Map data) {
    data['active'] = true;
    data['uid'] = _uid;
    return habitsRef.add(data);
  }

  Future<void> _addStreak(Map data, Timestamp timestamp) {
    data['uid'] = _uid;
    data['active'] = true;
    data['streak'] = timestamp;
    data['timestamp'] = timestamp;
    return habitsRef.add(data);
  }

  Future<void> _incrementStreak(String id, Timestamp timestamp) async {
    var doc = habitsRef.doc(id);

    doc.update(
      {"streak": timestamp},
    );
  }

  Future<void> streak(Map data, DateTime dateTime) async {
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    final ref = habitsRef
        .where('uid', isEqualTo: _uid)
        .where('name', isEqualTo: data['name'])
        .where('active', isEqualTo: true);

    var result = await ref.get();
    if (result.docs.isEmpty) {
      _addStreak(data, timestamp);
      print('no streak');
    } else {
      print('streak');
      final docs = ref.get();
      docs.then((value) {
        var id = value.docs.first.id;
        _incrementStreak(id, timestamp);
      });
    }

    // if (result) {
    //     _addStreak(data);
    //     print('no streak');
    // } else {
    //     print('streak');
    //     final docs = ref.get();
    //     docs.then((value) {
    //       var id = value.docs.first.id;
    //       _incrementStreak(id);
    //     });
    // }
  }

  int getCrossAxisCount() {
    if (_habits.length < 3) {
      return 1;
    }
    return 2;
  }

  // int _count = 0;

  // int get count => _count;

  // void incrementCount() {
  //   _count++;
  //   notifyListeners();
  // }
}
