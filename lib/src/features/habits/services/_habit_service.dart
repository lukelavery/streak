import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

abstract class NewHabitService {
  Stream<List<HabitModel>> getHabits({required String habitType});
  Stream<List<HabitModel>> getUserHabits();
  Future<void> createHabit(
      {required NewHabitPreset preset, required String name});
  Future<void> addHabit({required HabitModel habit});
  Future<void> removeHabit({required String habitId});
  Future<void> deleteHabit({required String habitId});
}

final newHabitServiceProvider = Provider.autoDispose<FirebaseHabitService>(
    (ref) => FirebaseHabitService(ref.read(authControllerProvider).uid));

class FirebaseHabitService implements NewHabitService {
  FirebaseHabitService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits_new');
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<HabitModel>> getHabits({required String habitType}) {
    final ref = habitsRef.where('type', isEqualTo: habitType);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Stream<List<HabitModel>> getUserHabits() {
    final ref = usersRef.doc(uid).collection('habits');
    return ref.snapshots().map((event) => event.docs
        .map((doc) => HabitModel.fromMap(doc.id, doc.data()))
        .toList());
  }

  @override
  Future<void> createHabit(
      {required NewHabitPreset preset, required String name}) async {
    Map<String, dynamic> data = preset.toMap();
    data['name'] = name;
    data['uid'] = uid;
    final docRef = await habitsRef.add(data);
    addHabit(habit: HabitModel.fromMap(docRef.id, data));
  }

  @override
  Future<void> deleteHabit({required String habitId}) async {
    return habitsRef.doc(habitId).delete();
  }

  @override
  Future<void> removeHabit({required String habitId}) {
    final userHabitsRef = usersRef.doc(uid).collection('habits');

    return userHabitsRef.doc(habitId).delete();
  }

  @override
  Future<void> addHabit({required HabitModel habit}) async {
    final userHabitsRef = usersRef.doc(uid).collection('habits');

    userHabitsRef.doc(habit.id).get().then((doc) {
      if (!doc.exists) {
        return userHabitsRef.doc(habit.id).set(habit.toMap());
      }
    });
  }
}
