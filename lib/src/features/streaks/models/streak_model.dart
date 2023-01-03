import 'package:cloud_firestore/cloud_firestore.dart';

class StreakModel {
  const StreakModel({
    required this.streakId,
    required this.activityId,
    required this.dateTime,
  });

  final String streakId;
  final String activityId;
  final DateTime dateTime;

  factory StreakModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }
    var timestamp = data['timestamp'] as Timestamp;
    DateTime dateTime = timestamp.toDate();

    var activityId = data['habitId'] as String;

    return StreakModel(streakId: id, activityId: activityId, dateTime: dateTime);
  }

  factory StreakModel.fromJSON(Map<String, dynamic> json, String activityId) {
    return StreakModel(
        streakId: json["id"],
        activityId: activityId,
        dateTime: DateTime.parse(json["created_at"]));
  }
}
