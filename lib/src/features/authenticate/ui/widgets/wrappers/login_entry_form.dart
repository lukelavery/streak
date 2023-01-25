import 'package:flutter/material.dart';
import 'package:streak/src/features/authenticate/domain/login_state_model.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/email_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/password_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/register_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/welcome_form.dart';

class LoginEntryWrapper extends StatelessWidget {
  const LoginEntryWrapper({
    Key? key,
    required this.loginState,
    required this.email,
    required this.cancelRegistration,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
  final void Function() cancelRegistration;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case LoginStateModel.welcome:
        return const WelcomeForm();
      case LoginStateModel.emailAddress:
        return const EmailForm();
      case LoginStateModel.password:
        return const PasswordForm();
      case LoginStateModel.register:
        return const RegisterForm();
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
}
