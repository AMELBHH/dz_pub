import 'dart:convert';

import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/auth_state.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;



class GetUserTypeNotifier extends StateNotifier<AuthState> {
  GetUserTypeNotifier() : super(AuthState());

  Future<void> getUserType({int ?id}) async {
    state = state.copyWith(isLoading: true);
final    userId = id??NewSession.get(PrefKeys.id, 0);
debugPrint("the new session id is on the get user type notiifer :: ${NewSession
    .get
      (PrefKeys.id, 0)}");
    final url = Uri.parse(
        "${ServerLocalhostEm.getUserType}?user_id=$userId");
    debugPrint("here we have the get user type notifier method !!!!!!!!!!");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      state = state.copyWith(
        isLoading: false,
        userType: body['data']['type'],

      );
   await NewSession.save(PrefKeys.userTypeId, body['data']['type']);
      debugPrint("user type: ${body['data']['type']}");
    } else {
      debugPrint("Failed to load user type: ${response.statusCode}");

      throw Exception("Failed to load user type: ${response.statusCode}");
    }
  }
}