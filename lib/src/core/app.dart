import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';

import 'home_page.dart';
import '../features/authenticate/ui/screens/logged_out.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'streak',
      // theme: ThemeData(
      //   primarySwatch: Colors.black,
      // ),
      home: Wrapper(),
    );
  }
}

class Wrapper extends ConsumerWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(authControllerProvider).uid !=
        null) {
      return const MyHomePage();
    } else {
      return const LogInPage();
    }
  }
}
