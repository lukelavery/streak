import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
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
    final authState = ref.watch(authControllerProvider);
    final authStateNotifier = ref.watch(authControllerProvider.notifier);
    final loginState = ref.watch(loginControllerProvider);
    final loginStateNotifier = ref.read(loginControllerProvider.notifier);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          icon: loginState == LoginStateModel.welcome ? null : Icon(Icons.arrow_forward),
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
          onPressed: (() {
            loginStateNotifier.startLoginFlow();
          })),
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
            child: LoggedOut(
          loginState: loginState,
          email: authState.email,
          verifyEmail: loginStateNotifier.verifyEmail,
          setEmail: authStateNotifier.setEmail,
          signInWithEmailAndPassword:
              authStateNotifier.signInWithEmailAndPassword,
          cancelRegistration: loginStateNotifier.cancelRegistration,
          registerAccount: authStateNotifier.registerAccount,
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
    required this.verifyEmail,
    required this.setEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
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
          const Spacer(),
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
          const Spacer(
            flex: 2,
          ),
          LoginEntryForm(
              loginState: loginState,
              email: email,
              verifyEmail: verifyEmail,
              setEmail: setEmail,
              signInWithEmailAndPassword: signInWithEmailAndPassword,
              cancelRegistration: cancelRegistration,
              registerAccount: registerAccount),
          const Spacer(
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
    required this.verifyEmail,
    required this.setEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
  }) : super(key: key);

  final LoginStateModel loginState;
  final String? email;
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
      case LoginStateModel.welcome:
        return const WelcomeForm();
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
