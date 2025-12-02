import 'dart:convert';

import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../../../../../api/users.dart';
import '../../statuses/auth_state.dart';


class RefreshUserDataNotifier extends StateNotifier<AuthState> {
  RefreshUserDataNotifier() : super(AuthState());
/// a [refreshUserData] method usage to get a lastest data of user from database.
  Future<User?> refreshUserData({required int userId, required WidgetRef ref})
  async {
    final url =
        Uri.parse('ServerLocalhostEm.refreshData'); // Replace with your API
    final response = await http.post(url, body: {'id': userId.toString()});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final user = User.fromJson(jsonData['data']);

      ref.read(userData.notifier).state = user;

      return user;
    } else if (response.statusCode == 404) {
      // Handle user not found error
      debugPrint('User not found');
      return null;
    } else {
      // Handle other errors
      debugPrint('Error refreshing user data: ${response.statusCode}');
      return null;
    }
  }
}
