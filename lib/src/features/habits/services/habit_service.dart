import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

abstract class HabitService {
  Stream<List<HabitModel>> get retrieveHabits;
  Future<void> createHabit({required HabitPreset habit});
  Future<void> deleteHabit({required String habitId});
}

final habitServiceProvider = Provider.autoDispose<FirebaseHabitService>(
    (ref) => FirebaseHabitService(ref.read(authControllerProvider).uid));

class FirebaseHabitService implements HabitService {
  FirebaseHabitService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits');
  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');

  @override
  Stream<List<HabitModel>> get retrieveHabits {
    final ref = habitsRef.where('uid', isEqualTo: uid);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<void> createHabit({required HabitPreset habit}) {
    Map data = habit.toMap();
    data['active'] = true;
    data['uid'] = uid;
    return habitsRef.add(data);
  }

  @override
  Future<void> deleteHabit({required String habitId}) {
    return habitsRef.doc(habitId).delete();
  }

  Future<void> addStreak(String habitId, DateTime dateTime) {
    Map<String, dynamic> data = {};

    data['uid'] = uid;
    data['habitId'] = habitId;
    data['timestamp'] = Timestamp.fromDate(dateTime);

    return streaksRef.add(data);
  }
}
