import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';

abstract class ActivityService {
  Stream<List<ActivityModel>> getHabits({required String habitType});
  Stream<List<ActivityModel>> getUserHabits();
  Future<void> createHabit(
      {required ActivityPreset preset, required String name});
  Future<void> addHabit({required ActivityModel habit});
  Future<void> removeHabit({required String activityId});
  Future<void> deleteHabit({required String activityId});
}

final activityServiceProvider = Provider.autoDispose<FirebaseActivityService>(
    (ref) => FirebaseActivityService(ref.read(authControllerProvider).uid));

class FirebaseActivityService implements ActivityService {
  FirebaseActivityService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits_new');
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<ActivityModel>> getHabits({required String habitType}) {
    final ref = habitsRef.where('type', isEqualTo: habitType);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            ActivityModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Stream<List<ActivityModel>> getUserHabits() {
    final ref = usersRef.doc(uid).collection('habits');
    return ref.snapshots().map((event) => event.docs
        .map((doc) => ActivityModel.fromMap(doc.id, doc.data()))
        .toList());
  }

  @override
  Future<void> createHabit(
      {required ActivityPreset preset, required String name}) async {
    Map<String, dynamic> data = preset.toMap();
    data['name'] = name;
    data['uid'] = uid;
    final docRef = await habitsRef.add(data);
    addHabit(habit: ActivityModel.fromMap(docRef.id, data));
  }

  @override
  Future<void> deleteHabit({required String activityId}) async {
    return habitsRef.doc(activityId).delete();
  }

  @override
  Future<void> removeHabit({required String activityId}) {
    final userHabitsRef = usersRef.doc(uid).collection('habits');

    return userHabitsRef.doc(activityId).delete();
  }

  @override
  Future<void> addHabit({required ActivityModel habit}) async {
    final userHabitsRef = usersRef.doc(uid).collection('habits');

    userHabitsRef.doc(habit.id).get().then((doc) {
      if (!doc.exists) {
        return userHabitsRef.doc(habit.id).set(habit.toMap());
      }
    });
  }
}
