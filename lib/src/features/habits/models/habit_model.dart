import 'package:streak/src/features/activities/models/activity_model.dart';

class HabitModel {
  const HabitModel(
      {required this.activity,
      required this.color,
      required this.description,
      required this.id,
      required this.uid,
      });

  final String? id;
  final String uid;
  final ActivityModel activity;
  final int color;
  final String description;

  factory HabitModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    return HabitModel(
      id: id,
      color: data['color'],
      description: data['description'],
      activity: ActivityModel.fromMap(data['activityId'], data),
      uid: data['uid'],
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'color': color,
  //     'description': description,
  //     'habitId': habit,
  //     'uid': uid,
  //   };
  // }
}
