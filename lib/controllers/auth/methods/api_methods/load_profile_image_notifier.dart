import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

import '../../../../../constants/strings.dart';
import '../../../../../main.dart';
import '../../../../../session/new_session.dart';
import '../../statuses/auth_state.dart';

class LoadProfileImageNotifier extends StateNotifier<AuthState> {
/// a [LoadProfileImageNotifier] usage to fetch data of user even in profile 
/// or to get the image of user 'if-exists'.
  LoadProfileImageNotifier() : super(AuthState());
  Future<String> loadProfileImage( WidgetRef
  ref) async {
    state = state.copyWith(isLoading: true);
    final url = Uri.parse('ServerEm .loadProfileImage');
    var userId = (await sp).get(PrefKeys.id).toString();
    var response = await http.post(url, body: {"id": userId});
    if (response.statusCode == 200) {
      var responseBody = response.body;
      var jsonResponse = jsonDecode(responseBody);
      NewSession.save(PrefKeys.profile, await jsonResponse['data']['profile']);
      NewSession.save(
          "createdAt", await jsonResponse['data']['time_ago']);

      debugPrint("you created at -- ${await jsonResponse['data']['time_ago']}");
      debugPrint("the profile image in SP -- ${(await sp).get("profile")}");


      state = state.copyWith(isLoading: false);

      return response.body;
    } else {

      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load profile image${response.body}');
    }
  }


}

