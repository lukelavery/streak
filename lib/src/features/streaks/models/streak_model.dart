import 'package:cloud_firestore/cloud_firestore.dart';

class Streak {
  const Streak({
    required this.streakId,
    required this.habitId,
    required this.dateTime,
  });

  final String streakId;
  final String habitId;
  final DateTime dateTime;

  factory Streak.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }
    var timestamp = data['timestamp'] as Timestamp;
    DateTime dateTime = timestamp.toDate();

    var habitId = data['habitId'] as String;

    return Streak(streakId: id, habitId: habitId, dateTime: dateTime);
  }

  factory Streak.fromJSON(Map<String, dynamic> json, String habitId) {
    return Streak(
        streakId: json["id"],
        habitId: habitId,
        dateTime: DateTime.parse(json["created_at"]));
  }
}
