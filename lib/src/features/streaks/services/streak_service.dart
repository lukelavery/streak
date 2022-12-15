import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';

abstract class StreakService {
  Stream<Map<String, List<Streak>>> get retrieveStreaks;
  Future<void> addStreak({required String habitId, required DateTime dateTime});
  Future<void> deleteStreak({required String habitId});
}

final streakServiceProvider = Provider.autoDispose<FirebaseStreakService>(
    (ref) => FirebaseStreakService(ref.read(authControllerProvider).uid));

class FirebaseStreakService implements StreakService {
  FirebaseStreakService(this.uid);

  final String? uid;

  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');

  @override
  Stream<Map<String, List<Streak>>> get retrieveStreaks {
    final ref = streaksRef
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true);
    return ref.snapshots().map((event) {
      Map<String, List<Streak>> streaks = {};
      for (var doc in event.docs) {
        Streak streak = Streak.fromMap(doc.id, doc.data() as Map<String, dynamic>?);

        var oldList = streaks[streak.habitId];

        if (oldList != null) {
          List<Streak> newList = oldList;
          newList.add(streak);
          streaks[streak.habitId] = newList;
        } else {
          streaks[streak.habitId] = [streak];
        }
      }
      return streaks;
    });
  }

  @override
  Future<void> addStreak(
      {required String habitId, required DateTime dateTime}) {
    Map<String, dynamic> data = {};

    data['uid'] = uid;
    data['habitId'] = habitId;
    data['timestamp'] = Timestamp.fromDate(dateTime);

    return streaksRef.add(data);
  }

  @override
  Future<void> deleteStreak({required String habitId}) {
    return streaksRef.doc(habitId).delete();
  }
}
