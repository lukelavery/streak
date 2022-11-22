import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

abstract class NewHabitService {
  Stream<List<HabitModel>> getHabits({required String habitType});
  Future<DocumentReference> createHabit({required NewHabitPreset habit, required String name});
  // Future<void> deleteHabit({required String habitId});
}

final newHabitServiceProvider = Provider.autoDispose<FirebaseHabitService>(
    (ref) => FirebaseHabitService(ref.read(authControllerProvider).uid));

class FirebaseHabitService implements NewHabitService {
  FirebaseHabitService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits_new');
  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');

  @override
  Stream<List<HabitModel>> getHabits({required String habitType}) {
    final ref = habitsRef.where('type', isEqualTo: habitType);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<DocumentReference> createHabit(
      {required NewHabitPreset habit, required String name}) {
    Map data = habit.toMap();
    data['name'] = name;
    data['active'] = true;
    data['uid'] = uid;
    return habitsRef.add(data);
  }

  // @override
  // Future<void> deleteHabit({required String habitId}) {
  //   return habitsRef.doc(habitId).delete();
  // }

}
