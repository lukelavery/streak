import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text_field.dart';

import '../design/text.dart';
import '../design/styled_button.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback, super.key});
  final void Function(String email) callback;
  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header3('Enter your email to begin.'),
        const SizedBox(
          height: 15,
        ),
        Consumer(
          builder: ((context, ref, child) {
            return CustomTextField(
              initialValue: ref.read(loginControllerProvider.notifier).email,
              hintText: 'Email',
              setText: ref.read(loginControllerProvider.notifier).setEmail,
              obscureText: false,
            );
          }),
        ),
      ],
    );
  }
}
