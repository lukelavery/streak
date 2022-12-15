import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/authenticate/controllers/login_controller.dart';
import '../../domain/login_state_model.dart';
import '../widgets/forms/email_form.dart';
import '../widgets/forms/password_form.dart';
import '../widgets/forms/register_form.dart';
import '../widgets/design/styled_button.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: (() {

        // })),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Consumer(
              builder: ((context, ref, child) => LoggedOut(
                    loginState: ref.watch(loginControllerProvider),
                    email: ref.read(authControllerProvider).email,
                    startLoginFlow: ref
                        .read(loginControllerProvider.notifier)
                        .startLoginFlow,
                    verifyEmail:
                        ref.read(loginControllerProvider.notifier).verifyEmail,
                    setEmail:
                        ref.read(authControllerProvider.notifier).setEmail,
                    signInWithEmailAndPassword: ref
                        .read(authControllerProvider.notifier)
                        .signInWithEmailAndPassword,
                    cancelRegistration: ref
                        .read(loginControllerProvider.notifier)
                        .cancelRegistration,
                    registerAccount: ref
                        .read(authControllerProvider.notifier)
                        .registerAccount,
                  )),
            ),
          ),
        ));
  }
}

class LoggedOut extends StatelessWidget {
  const LoggedOut({
    Key? key,
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.setEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
  ) verifyEmail;
  final void Function(String) setEmail;
  final void Function(
    String email,
    String password,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
  ) registerAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Spacer(),
          Column(
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
          ),
          Spacer(flex: 2,),
          LoginEntryForm(
              loginState: loginState,
              email: email,
              startLoginFlow: startLoginFlow,
              verifyEmail: verifyEmail,
              setEmail: setEmail,
              signInWithEmailAndPassword: signInWithEmailAndPassword,
              cancelRegistration: cancelRegistration,
              registerAccount: registerAccount),
          Spacer(
            flex: 10,
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
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.setEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
  ) verifyEmail;
  final void Function(String) setEmail;
  final void Function(
    String email,
    String password,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
  ) registerAccount;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case LoginStateModel.loggedOut:
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
      case LoginStateModel.emailAddress:
        return EmailForm(callback: (email) {
          verifyEmail(
            email,
            // (e) => showErrorDialog(context, 'Invalid email', e)
          );
          setEmail(email);
        });
      case LoginStateModel.password:
        return PasswordForm(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          login: (email, password) {
            signInWithEmailAndPassword(
              email, password,
              // (e) => showErrorDialog(context, 'Failed to sign in', e)
            );
          },
        );
      case LoginStateModel.register:
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
              email, displayName, password,
              // (e) => showErrorDialog(context, 'Failed to create account', e),
            );
          },
        );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
}
