import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/ui/wrappers/auth_wrapper.dart';
import 'package:streak/src/features/theme/theme.dart';
import 'package:streak/src/features/theme/ui/const.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData? themeState = ref.watch(themeDataController);
    bool darkMode = ref.read(themeController).darkMode;

    SystemChrome.setSystemUIOverlayStyle(
        darkMode ? lightSystemOverlayStyle : darkSystemOverlayStyle);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'streak',
      home: const AuthWrapper(),
      theme: themeState,
    );
  }
}
