import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak/src/features/authenticate/domain/user_model.dart';
import 'package:streak/src/features/authenticate/services/auth_service.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, UserModel>(
        (ref) => AuthController(ref));

class AuthController extends StateNotifier<UserModel> {
  AuthController(this._ref)
      : super(const UserModel(uid: null, email: null, isVerified: false)) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription =
        _ref.read(authRepositoryProvider).authStateChanges.listen((user) {
      state = user;
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  final Ref _ref;
  StreamSubscription<UserModel?>? _authStateChangesSubscription;

  Future<void> signOut() async {
    await _ref.read(authRepositoryProvider).signOut();
  }
}
