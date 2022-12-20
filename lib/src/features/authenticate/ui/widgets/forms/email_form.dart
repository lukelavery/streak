import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text_field.dart';

class EmailForm extends ConsumerWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStateNotifier = ref.read(loginControllerProvider.notifier);
    return Column(
      children: [
        const Header3('Enter your email to begin.'),
        const SizedBox(
          height: 15,
        ),
        CustomTextField(
          initialValue: loginStateNotifier.email,
          hintText: 'Email',
          setText: loginStateNotifier.setEmail,
          obscureText: false,
        ),
      ],
    );
  }
}
