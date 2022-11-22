import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/habits/models/habit_model.dart';

abstract class NewHabitService {
  Stream<List<HabitModel>> getHabits({required String habitType});
  Future<void> createHabit(
      {required NewHabitPreset preset, required String name});
  Future<void> addHabit({required String habitId});
  // Future<void> deleteHabit({required String habitId});
}

final newHabitServiceProvider = Provider.autoDispose<FirebaseHabitService>(
    (ref) => FirebaseHabitService(ref.read(authControllerProvider).uid));

class FirebaseHabitService implements NewHabitService {
  FirebaseHabitService(this.uid);

  final String? uid;

  CollectionReference habitsRef =
      FirebaseFirestore.instance.collection('habits_new');
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  @override
  Stream<List<HabitModel>> getHabits({required String habitType}) {
    final ref = habitsRef.where('type', isEqualTo: habitType);
    return ref.snapshots().map((event) => event.docs
        .map((doc) =>
            HabitModel.fromMap(doc.id, doc.data() as Map<String, dynamic>?))
        .toList());
  }

  @override
  Future<void> createHabit(
      {required NewHabitPreset preset, required String name}) async {
    Map data = preset.toMap();
    data['name'] = name;
    data['uid'] = uid;
    final docRef = await habitsRef.add(data);
    addHabit(habitId: docRef.id);
  }

  @override
  Future<void> addHabit({required String habitId}) {
    final docRef = usersRef.doc(uid);

    return docRef.get().then((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final habits = data['habit_list'] as List?;
      if (habits == null) {
        return docRef.update({
          'habit_list': [habitId]
        });
      } else {
        habits.add(habitId);
        return docRef.update({'habit_list': habits});
      }
    });
  }

  // @override
  // Future<void> deleteHabit({required String habitId}) {
  //   return habitsRef.doc(habitId).delete();
  // }

}
