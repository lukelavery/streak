import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streak/src/features/activities/models/activity_model.dart';

class HabitModel {
  const HabitModel({
    required this.activity,
    required this.description,
    required this.id,
    required this.uid,
    required this.timestamp,
  });

  final String id;
  final String uid;
  final ActivityModel activity;
  final String description;
  final DateTime? timestamp;

  factory HabitModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    Timestamp timestamp = data['timestamp'];

    return HabitModel(
      id: id,
      description: data['description'],
      activity: ActivityModel.fromMap(data['activityId'], data),
      uid: data['uid'],
      timestamp: timestamp.toDate(),
    );
  }
}
