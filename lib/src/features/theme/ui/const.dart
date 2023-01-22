import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle lightSystemOverlayStyle = const SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.light,
);

SystemUiOverlayStyle darkSystemOverlayStyle = SystemUiOverlayStyle(
  systemNavigationBarColor: Colors.grey.shade100,
  systemNavigationBarIconBrightness: Brightness.dark,
  statusBarColor: Colors.grey.shade100,
  statusBarBrightness: Brightness.dark,
);