import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import 'package:streak/src/features/authenticate/ui/widgets/forms/welcome_form.dart';
import '../../domain/login_state_model.dart';
import '../widgets/forms/email_form.dart';
import '../widgets/forms/password_form.dart';
import '../widgets/forms/register_form.dart';

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
          : FloatingActionButton.extended(
              icon: loginState == LoginStateModel.welcome
                  ? null
                  : const Icon(Icons.arrow_forward),
              label: Row(
                children: const [
                  Text(
                    'Get started',
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
              isExtended: loginState == LoginStateModel.welcome ? true : false,
              backgroundColor: Colors.black,
              onPressed: () {
                loginStateNotifier.floatingActionButtonClick();
              },
            ),
      body: SafeArea(
        child: Center(
            child: LoggedOut(
          loginState: loginState,
          email: loginStateNotifier.email,
          cancelRegistration: loginStateNotifier.cancelRegistration,
          signInWithGoogle: loginStateNotifier.signInWithGoogle,
        )),
      ),
    );
  }
}

class LoggedOut extends StatelessWidget {
  const LoggedOut({
    Key? key,
    required this.loginState,
    required this.email,
    required this.cancelRegistration,
    required this.signInWithGoogle,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
  final void Function() cancelRegistration;
  final void Function() signInWithGoogle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: WelcomeLogo()),
          LoginEntryForm(
            loginState: loginState,
            email: email,
            cancelRegistration: cancelRegistration,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 20),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                signInWithGoogle();
              },
              label: const Text('Sign in with Google.'),
              icon: const FaIcon(FontAwesomeIcons.google),
            ),
          ),
          Text(
            'Or sign in with email',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: 'Montserrat',
              decoration: TextDecoration.underline,
            ),
          )
        ],
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

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FaIcon(
          FontAwesomeIcons.bolt,
          color: Colors.black,
          size: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'streak',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
