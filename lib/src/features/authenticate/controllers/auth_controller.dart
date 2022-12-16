import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/domain/user_model.dart';
import 'package:streak/src/features/authenticate/services/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, UserModel>(
    (ref) => AuthController(ref.read));

class AuthController extends StateNotifier<UserModel> {
  AuthController(this._read) : super(const UserModel(uid: null, email: null)) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _read(authRepositoryProvider).authStateChanges.listen((user) {
      state = user;
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  final Reader _read;
  StreamSubscription<UserModel?>? _authStateChangesSubscription;

  Future<bool> verifyEmail(String email) async {
    var result = await _read(authRepositoryProvider).verifyEmail(email);
    return result;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _read(authRepositoryProvider)
        .signInWithEmailAndPassword(email, password);
  }

  Future<void> registerAccount(
    String email,
    String displayName,
    String password,
  ) async {
    await _read(authRepositoryProvider)
        .registerAccount(email, displayName, password);
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).signOut();
  }

  void setEmail(String email) {
    state = UserModel(uid: state.uid, email: email);
  }
}
