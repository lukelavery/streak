import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

abstract class HabitService {
  Stream<List<HabitModel>> getHabits();
  Future<void> addHabit(
      {required ActivityModel activity,
      required int color,
      required String description});
  Future<void> removeHabit({required String habitId});
}

final habitServiceProvider = Provider.autoDispose<FirebaseHabitService>(
    (ref) => FirebaseHabitService(ref.read(authControllerProvider).uid));

class FirebaseHabitService implements HabitService {
  FirebaseHabitService(this.uid);

  final String? uid;

  final CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('goals');

  @override
  Stream<List<HabitModel>> getHabits() {
    final userHabitsRef = habitsRef.where('uid', isEqualTo: uid);
    return userHabitsRef.snapshots().map((event) => event.docs
        .map((doc) =>
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<void> addHabit(
      {required ActivityModel activity,
      required int color,
      required String description}) async {
    await habitsRef.add({
      'color': color,
      'description': description,
      'activityId': activity.id,
      'uid': uid,
      'type': activity.type,
      'iconCodePoint': activity.iconCodePoint,
      'iconFontFamily': activity.iconFontFamily,
      'iconFontPackage': activity.iconFontPackage,
      'name': activity.name
    });
  }

  @override
  Future<void> removeHabit({required String habitId}) {
    return habitsRef.doc(habitId).delete();
  }
}
