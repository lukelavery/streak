import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/domain/login_state_model.dart';
import 'package:streak/src/features/authenticate/services/auth_service.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginStateModel>(
        (ref) => LoginController(ref.read));

class LoginController extends StateNotifier<LoginStateModel> {
  LoginController(this._read) : super(LoginStateModel.emailAddress);

  final Reader _read;

  void startLoginFlow() {
    state = LoginStateModel.emailAddress;
  }

  Future<void> verifyEmail(String email) async {
    var result = await _read(authRepositoryProvider).verifyEmail(email);
    if (result == true) {
      state = LoginStateModel.password;
    } else {
      state = LoginStateModel.register;
    }
  }

  void cancelRegistration() {
    state = LoginStateModel.emailAddress;
  }
}
