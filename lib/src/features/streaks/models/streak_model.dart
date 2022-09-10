import 'package:cloud_firestore/cloud_firestore.dart';

class Streak {
  const Streak({
    required this.habitId,
    required this.dateTime,
  });

  final String habitId;
  final DateTime dateTime;

  factory Streak.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }
    var timestamp = data['timestamp'] as Timestamp;
    DateTime dateTime = timestamp.toDate();

    var habitId = data['habitId'] as String;

    return Streak(habitId: habitId, dateTime: dateTime);
  }
}