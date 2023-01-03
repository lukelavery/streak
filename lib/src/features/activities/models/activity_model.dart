import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityModel {
  const ActivityModel(
      {
      required this.id,
      required this.name,
      required this.iconCodePoint,
      required this.iconFontFamily,
      this.iconFontPackage,
      required this.type,
      this.uid,
    });

  final String id;
  final String name;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;
  final String type;
  final String? uid;

  factory ActivityModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    return ActivityModel(
      id: id,
      name: data['name'],
      iconCodePoint: data['iconCodePoint'],
      iconFontFamily: data['iconFontFamily'],
      iconFontPackage: data['iconFontPackage'],
      type: data['type'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
      'type': type,
      'uid': uid,
    };
  }
}

class HabitPreset {
  const HabitPreset({
    required this.name,
    required this.type,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.iconFontPackage,
  });

  final String name;
  final String type;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;

  Map<String, dynamic> toMap() {
    var now = Timestamp.now();
    return {
      'name': name,
      'type': type,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
      'timestamp': now,
      // 'streak': now,
    };
  }
}

class ActivityPreset {
  const ActivityPreset({
    required this.type,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.iconFontPackage,
  });

  final String type;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
    };
  }
}

Map<String, ActivityPreset> activityPresets = {
  'exercise': const ActivityPreset(
      type: 'exercise',
      iconCodePoint: 0xf44b,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  'skill': const ActivityPreset(
      type: 'skill',
      iconCodePoint: 0xf02d,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
};
