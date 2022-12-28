import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/habit_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/goal_model.dart';

abstract class GoalService {
  Stream<List<GoalModel>> getGoals();
   Future<void> addGoal(
      {required ActivityModel habit, required int color, required String description});
  Future<void> removeGoal({required String goalId});
}

final goalServiceProvider = Provider.autoDispose<FirebaseGoalService>(
    (ref) => FirebaseGoalService(ref.read(authControllerProvider).uid));

class FirebaseGoalService implements GoalService {
  FirebaseGoalService(this.uid);

  final String? uid;

  final CollectionReference goalsRef =
      FirebaseFirestore.instance.collection('goals');
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<GoalModel>> getGoals() {
    return goalsRef.snapshots().map((event) => event.docs
        .map((doc) =>
            GoalModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<void> addGoal(
      {required ActivityModel habit, required int color, required String description}) async {
    await goalsRef.add({
      'color': color,
      'description': description,
      'habitId': habit.id,
      'uid': uid,
    });
  }

  @override
  Future<void> removeGoal({required String goalId}) {
    return goalsRef.doc(goalId).delete();
  }
}
