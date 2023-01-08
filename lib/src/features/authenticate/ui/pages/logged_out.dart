import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import 'package:streak/src/features/authenticate/domain/login_state_model.dart';
import 'package:streak/src/features/authenticate/ui/widgets/buttons/google_sign_in_button.dart';
import 'package:streak/src/features/authenticate/ui/widgets/design/welcome_logo.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/email_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/password_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/register_form.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/welcome_form.dart';

class LogInPage extends ConsumerWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginControllerProvider);
    final loginStateNotifier = ref.read(loginControllerProvider.notifier);

    ref.listen<CustomException?>(
      customExceptionProvider,
      (prev, next) {
        if (next != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red[800],
              content: Text(
                next.message!,
              ),
            ),
          );
        }
      },
    );

    return Scaffold(
      floatingActionButton: loginState == LoginStateModel.welcome
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                loginStateNotifier.floatingActionButtonClick();
              },
              child: const Icon(Icons.arrow_forward),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Spacer(),
              const WelcomeLogo(),
              const SizedBox(height: 50),
              LoginEntryForm(
                loginState: loginState,
                email: loginStateNotifier.email,
                cancelRegistration: loginStateNotifier.cancelRegistration,
              ),
              const SizedBox(height: 50),
              GoogleSignInButton(signInWithGoogle: loginStateNotifier.signInWithGoogle,),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginEntryForm extends StatelessWidget {
  const LoginEntryForm({
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
