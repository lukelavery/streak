import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/home_page.dart';
import 'package:streak/src/features/theme/theme.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/authenticate/ui/pages/logged_out.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var themeState = ref.watch(themeDataController);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'streak',
        home: const Wrapper(),
        theme: themeState);
  }
}

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(authControllerProvider).uid != null) {
      return const MyHomePage();
    } else {
      return const LogInPage();
    }
  }
}
