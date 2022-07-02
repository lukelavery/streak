import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/providers/providers.dart';

import '../../domain/application_login_model.dart';
import '../widgets/forms/email_form.dart';
import '../widgets/forms/password_form.dart';
import '../widgets/forms/register_form.dart';
import '../widgets/design/styled_button.dart';
import '../widgets/dialogs/error_dialog.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Consumer(
        builder: ((context, ref, child) => LoggedOut(
                loginState: ref.watch(appStateProvider).loginState,
                email: ref.read(appStateProvider).email,
                startLoginFlow: ref.read(appStateProvider).startLoginFlow,
                verifyEmail: ref.read(appStateProvider).verifyEmail,
                signInWithEmailAndPassword: ref.read(appStateProvider).signInWithEmailAndPassword,
                cancelRegistration: ref.read(appStateProvider).cancelRegistration,
                registerAccount: ref.read(appStateProvider).registerAccount,
              )),
      ),
          )),
    );
  }
}

class LoggedOut extends StatelessWidget {
  const LoggedOut({
    Key? key,
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
  }) : super(key: key);

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                onPressed: () {
                  startLoginFlow();
                },
                child: const Text('RSVP'),
              ),
            ),
          ],
        );
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => showErrorDialog(context, 'Invalid email', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => showErrorDialog(context, 'Failed to sign in', e));
          },
        );
      case ApplicationLoginState.register:
        return RegisterForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    showErrorDialog(context, 'Failed to create account', e));
          },
        );
      // case ApplicationLoginState.loggedIn:
      //   return Row(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(left: 24, bottom: 8),
      //         child: StyledButton(
      //           onPressed: () {
      //             signOut();
      //           },
      //           child: const Text('LOGOUT'),
      //         ),
      //       ),
      //     ],
      //   );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
}
