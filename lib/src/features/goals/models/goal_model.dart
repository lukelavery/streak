import 'package:streak/src/features/habits/models/habit_model.dart';

class GoalModel {
  const GoalModel(
      {required this.habit,
      required this.color,
      required this.description,
      required this.id,
      required this.uid,
      });

  final String? id;
  final String uid;
  final HabitModel habit;
  final String color;
  final String description;

  factory GoalModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    return GoalModel(
      id: id,
      color: data['color'],
      description: data['description'],
      habit: data['habitId'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'description': description,
      'habitId': habit,
      'uid': uid,
    };
  }
}
