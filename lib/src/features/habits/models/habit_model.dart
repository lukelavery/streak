import 'package:cloud_firestore/cloud_firestore.dart';

class HabitModel {
  const HabitModel(
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

  factory HabitModel.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }

    return HabitModel(
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

List<HabitPreset> habitList = [
  const HabitPreset(
      name: 'run',
      type: 'exercise',
      iconCodePoint: 0xf70c,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'workout',
      type: 'exercise',
      iconCodePoint: 0xf44b,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'walk',
      type: 'exercise',
      iconCodePoint: 0xf554,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
    name: 'yoga',
    type: 'exercise',
    iconCodePoint: 0xe56f,
    iconFontFamily: 'MaterialIcons',
  ),
  const HabitPreset(
      name: 'hike',
      type: 'exercise',
      iconCodePoint: 0xf6ec,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'cycle',
      type: 'exercise',
      iconCodePoint: 0xf84a,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'swim',
      type: 'exercise',
      iconCodePoint: 0xf5c4,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
    name: 'tennis',
    type: 'exercise',
    iconCodePoint: 0xe5f3,
    iconFontFamily: 'MaterialIcons',
  ),
  const HabitPreset(
      name: 'basketball',
      type: 'exercise',
      iconCodePoint: 0xf434,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'football',
      type: 'exercise',
      iconCodePoint: 0xf1e3,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'language',
      type: 'skill',
      iconCodePoint: 0xf1ab,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'code',
      type: 'skill',
      iconCodePoint: 0xe185,
      iconFontFamily: 'MaterialIcons'),
  const HabitPreset(
      name: 'instrument',
      type: 'skill',
      iconCodePoint: 0xf001,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'art',
      type: 'skill',
      iconCodePoint: 0xf53f,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'photography',
      type: 'skill',
      iconCodePoint: 0xf030,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'drive',
      type: 'skill',
      iconCodePoint: 0xf1b9,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'read',
      type: 'me',
      iconCodePoint: 0xf02d,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
];

class NewHabitPreset {
  const NewHabitPreset({
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

Map<String, NewHabitPreset> habitPresets = {
  'exercise': const NewHabitPreset(
      type: 'exercise',
      iconCodePoint: 0xf44b,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  'skill': const NewHabitPreset(
      type: 'skill',
      iconCodePoint: 0xf02d,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
};
