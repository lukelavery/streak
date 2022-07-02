import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.iconFontPackage,
    required this.counter,
  });

  final String id;
  final String name;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;
  final int counter;

  factory Habit.fromMap(String id, Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data');
    }
    var timestamp = data['timestamp'] as Timestamp;
    var streakTimestamp = data['streak'] as Timestamp?;

    DateTime dateTime = timestamp.toDate();
    DateTime? streakDateTime = streakTimestamp?.toDate();

    final difference = streakDateTime?.difference(dateTime);
    if (difference == null) {
      var counter1 = 0;

      return Habit(
        id: id,
        name: data['name'],
        iconCodePoint: data['iconCodePoint'],
        iconFontFamily: data['iconFontFamily'],
        iconFontPackage: data['iconFontPackage'],
        counter: counter1,
      );
    } else {
      return Habit(
        id: id,
        name: data['name'],
        iconCodePoint: data['iconCodePoint'],
        iconFontFamily: data['iconFontFamily'],
        iconFontPackage: data['iconFontPackage'],
        counter: difference.inDays + 1,
      );
    }

    // return Habit(
    //   id: id,
    //   name: data['name'],
    //   iconCodePoint: data['iconCodePoint'],
    //   iconFontFamily: data['iconFontFamily'],
    //   iconFontPackage: data['iconFontPackage'],
    //   counter: counter,
    // );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
    };
  }
}

class HabitPreset {
  const HabitPreset({
    required this.name,
    required this.iconCodePoint,
    required this.iconFontFamily,
    this.iconFontPackage,
  });

  final String name;
  final int iconCodePoint;
  final String iconFontFamily;
  final String? iconFontPackage;

  // factory Habit.fromMap(String id, Map<String, dynamic>? data) {
  //   if (data == null) {
  //     throw StateError('missing data');
  //   }
  //   return Habit(
  //     id: id,
  //     name: data['name'],
  //     iconCodePoint: data['iconCodePoint'],
  //     iconFontFamily: data['iconFontFamily'],
  //     iconFontPackage: data['iconFontPackage'],
  //   );
  // }

  Map<String, dynamic> toMap() {
    var now = Timestamp.now();
    return {
      'name': name,
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
      name: 'code', iconCodePoint: 0xe185, iconFontFamily: 'MaterialIcons'),
  const HabitPreset(
      name: 'run',
      iconCodePoint: 0xf70c,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'workout',
      iconCodePoint: 0xf44b,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'read',
      iconCodePoint: 0xf02d,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'language',
      iconCodePoint: 0xf1ab,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
  const HabitPreset(
      name: 'instrument',
      iconCodePoint: 0xf001,
      iconFontFamily: 'FontAwesomeSolid',
      iconFontPackage: 'font_awesome_flutter'),
];
