import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/text_field.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStateNotifier = ref.read(loginControllerProvider.notifier);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
                        IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                loginStateNotifier.startLoginFlow();
              },
              splashRadius: 20,
            ),
            const Header3('Create account'),
            const IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ),
              onPressed: null,
              splashRadius: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(
              initialValue: loginStateNotifier.email,
              enabled: false,
              obscureText: false,
            ),
            CustomTextField(
              hintText: 'Password',
              setText: loginStateNotifier.setPassword,
              obscureText: true,
            ),
            CustomTextField(
              hintText: 'Confirm password',
              setText: loginStateNotifier.setConfirmationPassword,
              obscureText: true,
            ),
            ],
          ),
      ],
    );
  }
}