import 'package:dz_pub/controllers/auth/statuses/auth_state.dart';
import 'package:dz_pub/session/sesstion_of_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

class LogoutNotifier extends StateNotifier<AuthState> {
  LogoutNotifier() : super(AuthState());
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    removeUserInfo();
    state = state.copyWith(isLoading: false);
    debugPrint("was logged");
  }

//
}
