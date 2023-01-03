import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/streaks/models/streak_model.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';

abstract class StreakService {
  Stream<Map<String, List<StreakModel>>> get retrieveStreaks;
  Future<void> addStreak({required String activityId, required DateTime dateTime});
  Future<void> deleteStreak({required String activityId, required DateTime dateTime});
}

final streakServiceProvider = Provider.autoDispose<FirebaseStreakService>(
    (ref) => FirebaseStreakService(ref.read(authControllerProvider).uid));

class FirebaseStreakService implements StreakService {
  FirebaseStreakService(this.uid);

  final String? uid;

  CollectionReference streaksRef =
      FirebaseFirestore.instance.collection('streaks');

  @override
  Stream<Map<String, List<StreakModel>>> get retrieveStreaks {
    final ref = streaksRef
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true);
    return ref.snapshots().map((event) {
      Map<String, List<StreakModel>> streaks = {};
      for (var doc in event.docs) {
        StreakModel streak =
            StreakModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?);

        var oldList = streaks[streak.activityId];

        if (oldList != null) {
          List<StreakModel> newList = oldList;
          newList.add(streak);
          streaks[streak.activityId] = newList;
        } else {
          streaks[streak.activityId] = [streak];
        }
      }
      return streaks;
    });
  }

  @override
  Future<void> addStreak(
      {required String activityId, required DateTime dateTime}) {
    Map<String, dynamic> data = {};

    data['uid'] = uid;
    data['habitId'] = activityId;
    data['timestamp'] = Timestamp.fromDate(dateTime);

    return streaksRef.add(data);
  }

  @override
  Future<void> deleteStreak({required String activityId, required DateTime dateTime}) {
    return streaksRef
        .where('uid', isEqualTo: uid)
        .where('habitId', isEqualTo: activityId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((value) {
      var doc = value.docs.first;
      var data = doc.data() as Map<String, dynamic>;
      Timestamp timestamp = data['timestamp'];
      var streakDateTime = timestamp.toDate();

      if (DateTime(dateTime.year, dateTime.month, dateTime.day) ==
          DateTime(streakDateTime.year, streakDateTime.month, streakDateTime.day)) {
        streaksRef.doc(doc.id).delete();
      }
    });
  }
}
