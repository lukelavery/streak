import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/core/custom_exception.dart';
import 'package:streak/src/features/authenticate/domain/login_state_model.dart';
import 'package:streak/src/features/authenticate/services/auth_service.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginStateModel>(
        (ref) => LoginController(ref));

class LoginController extends StateNotifier<LoginStateModel> {
  LoginController(this._ref) : super(LoginStateModel.welcome);

  final Ref _ref;
  String _email = '';
  String _password = '';
  String _confirmationPassword = '';

  String get email => _email;

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setConfirmationPassword(String confirmationPassword) {
    _confirmationPassword = confirmationPassword;
  }

  void startLoginFlow() {
    state = LoginStateModel.emailAddress;
  }

  Future<void> _verifyEmail() async {
    if (_email != '') {
      try {
        var result = await _ref.read(authRepositoryProvider).verifyEmail(email);
        if (result == true) {
          state = LoginStateModel.password;
        } else {
          state = LoginStateModel.register;
        }
      } on CustomException catch (e) {
        _handleException(e);
      }
    } else {
      _handleException(
          const CustomException(message: 'Email address is empty.'));
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      if (_password == '') {
        throw const CustomException(message: 'Password is empty');
      }
      await _ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(_email, _password);
    } on CustomException catch (e) {
      _handleException(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await _ref.read(authRepositoryProvider).signInWithGoogle();
    } on CustomException catch (e) {
      _handleException(e);
    }
  }

  Future<void> _registerAccount() async {
    try {
      if (_password == '') {
        throw const CustomException(message: 'Password is empty');
      }
      if (_password != _confirmationPassword) {
        throw const CustomException(message: 'Passwords do not match.');
      }
      await _ref
          .read(authRepositoryProvider)
          .registerAccount(_email, _password);
    } on CustomException catch (e) {
      _handleException(e);
    }
  }

  void cancelRegistration() {
    state = LoginStateModel.emailAddress;
  }

  void floatingActionButtonClick() async {
    switch (state) {
      case LoginStateModel.welcome:
        return startLoginFlow();
      case LoginStateModel.emailAddress:
        return _verifyEmail();
      case LoginStateModel.password:
        return _signInWithEmailAndPassword();
      case LoginStateModel.register:
        return _registerAccount();
    }
  }

  void _handleException(CustomException e) {
    _ref.read(customExceptionProvider.notifier).state = null;
    _ref.read(customExceptionProvider.notifier).state = e;
  }
}
