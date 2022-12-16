import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/controllers/auth_controller.dart';
import 'package:streak/src/features/authenticate/domain/login_state_model.dart';
import 'package:streak/src/features/authenticate/services/auth_service.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginStateModel>(
        (ref) => LoginController(ref.read));

class LoginController extends StateNotifier<LoginStateModel> {
  LoginController(this._read) : super(LoginStateModel.welcome);

  final Reader _read;
  final String _email = '';
  final String _password = '';

  void startLoginFlow() {
    state = LoginStateModel.emailAddress;
  }

  Future<void> verifyEmail() async {
    var result =
        await _read(authControllerProvider.notifier).verifyEmail(_email);
    if (result == true) {
      state = LoginStateModel.password;
    } else {
      state = LoginStateModel.register;
    }
  }

  void cancelRegistration() {
    state = LoginStateModel.emailAddress;
  }

  void floatingActionButtonClick() {}
}
