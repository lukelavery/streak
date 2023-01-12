import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';

abstract class ActivityService {
  Stream<List<ActivityModel>> getActivitiesByType({required String habitType});
  Stream<List<ActivityModel>> getActivities();
  Future<void> createActivity({required ActivityModel activity});
  Future<void> deleteActivity({required String activityId});
}

final activityServiceProvider = Provider.autoDispose<FirebaseActivityService>(
    (ref) => FirebaseActivityService(ref.read(authControllerProvider).uid));

class FirebaseActivityService implements ActivityService {
  FirebaseActivityService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits_new');

  @override
  Stream<List<ActivityModel>> getActivitiesByType({required String habitType}) {
    final ref = habitsRef.where('type', isEqualTo: habitType);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            ActivityModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Stream<List<ActivityModel>> getActivities() {
    return habitsRef.snapshots().map((event) => event.docs
        .map((doc) =>
            ActivityModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<String> createActivity({required ActivityModel activity}) async {
    Map<String, dynamic> data = activity.toMap();
    data['uid'] = uid;
    final docRef = await habitsRef.add(data);
    return docRef.id;
  }

  @override
  Future<void> deleteActivity({required String activityId}) async {
    return habitsRef.doc(activityId).delete();
  }
}
