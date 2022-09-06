import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  HabitProvider({required String? uid}) : _uid = uid {
    init();
  }

  final String? _uid;

  List<HabitModel> _habits = [];
  List<HabitModel> get habits => _habits;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits');
  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');

  Future<void> init() async {
    final ref1 = habitsRef.where('uid', isEqualTo: _uid);

    ref1.snapshots().listen((event) {
      _habits = [];
      for (var doc in event.docs) {
        HabitModel habit =
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?);
        _habits.add(habit);
      }
      notifyListeners();
    }, onError: (error) {});
  }

  Future<void> addHabit(HabitModel habit) {
    var data = habit.toMap();
    data['active'] = true;
    data['uid'] = _uid;
    return habitsRef.add(data);
  }

  Future<void> deleteHabit(String id) {
    return habitsRef.doc(id).delete();
  }

  Future<void> addStreak(String habitId, DateTime dateTime) {
    Map<String, dynamic> data = {};

    data['uid'] = _uid;
    data['habitId'] = habitId;
    data['timestamp'] = Timestamp.fromDate(dateTime);

    return streaksRef.add(data);
  }

  int getCrossAxisCount() {
    if (_habits.length < 3) {
      return 1;
    }
    return 2;
  }
}
