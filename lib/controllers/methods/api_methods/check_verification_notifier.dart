import 'dart:convert';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../../statuses/auth_state.dart';

class CheckVerificationNotifier extends StateNotifier<AuthState> {
  CheckVerificationNotifier() : super(AuthState());

  /// Check user verification status from backend
  Future<bool> checkVerificationStatus() async {
    state = AuthState(isLoading: true);

    try {
      final userId = NewSession.get(PrefKeys.id, 0);
      final url = Uri.parse(
        '${ServerLocalhostEm.getUserVerificationStatus}?user_id=$userId',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == true && jsonData['data'] != null) {
          final isVerified = jsonData['data']['is_verified'] ?? 'no';

          // Update session with latest verification status
          await NewSession.save(PrefKeys.isVerified, isVerified);

          state = AuthState(isLoading: false);
          return isVerified == 'yes';
        } else {
          state = AuthState(
            isLoading: false,
            hasError: true,
            errorMessage:
                jsonData['message'] ?? 'فشل في الحصول على حالة التحقق',
          );
          return false;
        }
      } else {
        state = AuthState(
          isLoading: false,
          hasError: true,
          errorMessage: 'حدث خطأ في الحصول على حالة التحقق',
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error checking verification status: $e');
      state = AuthState(
        isLoading: false,
        hasError: true,
        errorMessage: 'حدث خطأ في الاتصال بالخادم',
      );
      return false;
    }
  }
}
