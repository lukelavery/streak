import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectColorController =
    StateNotifierProvider.autoDispose<SelectColorController, int?>(
        (ref) => SelectColorController());

class SelectColorController extends StateNotifier<int?> {
  SelectColorController() : super(null);

  final List<MaterialColor> colorList = Colors.primaries;

  void setColor(int index) {
    state = index;
  }
}
