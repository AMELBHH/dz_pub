import 'dart:convert';

import 'package:dz_pub/api/categories.dart';
import 'package:dz_pub/api/social_media.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../api/users.dart';
import '../../../../../constants/strings.dart';
import 'package:http/http.dart' as http;

import '../../../../../session/sesstion_of_user.dart';
import '../../statuses/auth_state.dart';

class LoginNotifier extends StateNotifier<AuthState> {
  LoginNotifier() : super(AuthState());

  static const Map<String, Map<String, String>> _demoAccounts = {
    "client@demo.com": {"password": "123456", "type": "client"},
    "influencer@demo.com": {"password": "123456", "type": "influencer"},
  };

  Map<String, dynamic> _buildDemoResponse(String type) {
    if (type == "client") {
      return {
        "status": true,
        "msg": "تم تسجيل الدخول بنجاح",
        "data": {
          "token": "demo-token-client-000",
          "user": {
            "id": 9001,
            "name": "شركة الإعلانات الجزائرية",
            "email": "client@demo.com",
            "type_id": 1,
            "is_active": 1,
            "created_at": "2025-01-01T00:00:00.000000Z",
            "updated_at": "2025-01-01T00:00:00.000000Z",
            "user_info": {
              "id": 1,
              "phone_number": "0555123456",
              "identity_number": "123456789",
              "is_verified": "yes",
              "user_id": 9001,
              "created_at": "2025-01-01T00:00:00.000000Z",
              "updated_at": "2025-01-01T00:00:00.000000Z",
            },
            "client": {
              "id": 1,
              "is_have_cr": "yes",
              "created_at": "2025-01-01T00:00:00.000000Z",
              "updated_at": "2025-01-01T00:00:00.000000Z",
              "client_with_c_r": {
                "client_id": 1,
                "reg_owner_name": "أحمد بن علي",
                "institution_name": "شركة الإعلانات الجزائرية",
                "branch_address": "مغنية، تلمسان",
                "institution_address": "الجزائر العاصمة",
                "rc_number": "16/00-1234567B21",
                "nis_number": "123456789012345",
                "nif_number": "001234567891234",
                "iban": "DZ5800100000000000000000",
                "image_of_license": null,
                "created_at": "2025-01-01T00:00:00.000000Z",
                "updated_at": "2025-01-01T00:00:00.000000Z",
              },
              "client_without_c_r": null,
              "user": {
                "id": 9001,
                "name": "شركة الإعلانات الجزائرية",
                "email": "client@demo.com",
                "type_id": 1,
                "is_active": 1,
              },
            },
            "influencer": null,
          },
        },
      };
    } else {
      return {
        "status": true,
        "msg": "تم تسجيل الدخول بنجاح",
        "data": {
          "token": "demo-token-influencer-000",
          "user": {
            "id": 9002,
            "name": "ياسمين مشهورة",
            "email": "influencer@demo.com",
            "type_id": 2,
            "is_active": 1,
            "created_at": "2025-01-01T00:00:00.000000Z",
            "updated_at": "2025-01-01T00:00:00.000000Z",
            "user_info": {
              "id": 2,
              "phone_number": "0666987654",
              "identity_number": "987654321",
              "is_verified": "yes",
              "user_id": 9002,
              "created_at": "2025-01-01T00:00:00.000000Z",
              "updated_at": "2025-01-01T00:00:00.000000Z",
            },
            "client": null,
            "influencer": {
              "rating": 4.8,
              "bio": "صانعة محتوى فمجال الموضة والجمال، +200 ألف متابع",
              "gender": "female",
              "date_of_birth": "1998-05-12",
              "shake_number": "0666987654",
              "type_id": 1,
              "user": {
                "id": 9002,
                "name": "ياسمين مشهورة",
                "email": "influencer@demo.com",
                "type_id": 2,
                "is_active": 1,
              },
              "social_media_links": [
                {"id": 1, "platform": "Instagram", "url": "https://instagram.com/demo"},
                {"id": 2, "platform": "TikTok", "url": "https://tiktok.com/demo"},
              ],
              "categories": [
                {
                  "id": 1,
                  "name": "موضة",
                  "created_at": "2025-01-01T00:00:00.000000Z",
                  "updated_at": "2025-01-01T00:00:00.000000Z",
                },
                {
                  "id": 2,
                  "name": "جمال",
                  "created_at": "2025-01-01T00:00:00.000000Z",
                  "updated_at": "2025-01-01T00:00:00.000000Z",
                },
              ],
              "type_of_influencer": {"id": 1, "name": "مشهور"},
            },
          },
        },
      };
    }
  }

  Future<List<SocialMediaLink>> _getSocialMediaLinksOfInfluencer(
    int influencerId, {
    WidgetRef? ref,
  }) async {
    final url = Uri.parse(
      "${ServerLocalhostEm.socialMediaOfIn}?influencer_id=$influencerId",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      debugPrint("social media links of user ${body}");

      return SocialMediaResponse.fromJson(body).links ?? [];
    } else {
      throw Exception(
        "Failed to load social media links: ${response.statusCode}",
      );
    }
  }

  Future<List<Category>> _getCategoriesOfInfluencer(
    int influencerId, {
    WidgetRef? ref,
  }) async {
    state = state.copyWith(isLoading: true);
    final url = Uri.parse(
      "${ServerLocalhostEm.categoriesOfInf}?influencer_id=$influencerId",
    );
    debugPrint(" url of caegories is :$url");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      debugPrint("categories of user ${body}");
      state = state.copyWith(isLoading: false);

      return CategoryResponse.fromJson(body).categories ?? [];
    } else {
      throw Exception("Failed to load categories: ${response.statusCode}");
    }
  }

  Future<void> getCategoriesAndSocialMediaLinksOfInfluencer(
    int influencerId,
  ) async {
    state = state.copyWith(isLoading: true);
    await _getCategoriesOfInfluencer(influencerId);
    await _getSocialMediaLinksOfInfluencer(influencerId);
    state = state.copyWith(
      isLoading: false,
      categories: _getCategoriesOfInfluencer(influencerId),
      socialMediaLinks: _getSocialMediaLinksOfInfluencer(influencerId),
    );
  }

  Future<User> login(
    String email,
    String password,
    WidgetRef ref,
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // ========================================================================
    // فحص الحسابات الثابتة (Demo) أولاً - بدون أي اتصال بالسيرفر
    // ========================================================================
    if (_demoAccounts.containsKey(email) &&
        _demoAccounts[email]!['password'] == password) {
      final type = _demoAccounts[email]!['type']!;
      final res = _buildDemoResponse(type);

      final data = res["data"];
      final userJson = data["user"];
      final token = data["token"];
      final user = User.fromJson(userJson, token: token);

      debugPrint("[DEMO] user :$user");
      debugPrint("[DEMO] User id: ${user.id}");
      debugPrint("[DEMO] Token: ${user.token}");
      debugPrint("[DEMO] Type ID: ${user.typeId}");

      saveUserInfo(res);
      NewSession.save(PrefKeys.logged, "OK");

      state = state.copyWith(
        isLoading: false,
        userType: user.typeId == 1 ? "client" : "influencer",
      );

      return user; // يوقف هنا - ما يكملش للكود الأصلي تحت
    }
    // ========================================================================
    // نهاية فحص الحسابات الثابتة
    // ========================================================================

    var url = Uri.parse(ServerLocalhostEm.userLogin);
    var response = await http.post(
      url,
      body: {"email": email, "password": password},
    );

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      if (res["status"] == true) {
        final data = res["data"];
        final userJson = data["user"];
        final token = data["token"];
        debugPrint("userJson = $userJson");
        debugPrint("token = $token");
        // 🔥 Create User object WITH token
        final user = User.fromJson(userJson, token: token);

        debugPrint("user :$user");
        debugPrint("User id: ${user.id}");
        debugPrint("User email: ${user.email}");
        debugPrint("Token: ${user.token}");
        debugPrint("Type ID: ${user.typeId}");
        saveUserInfo(res);

        state = state.copyWith(isLoading: false);
        NewSession.save(PrefKeys.logged, "OK");
        debugPrint(
          "NewSession of is have cr ${NewSession.get(PrefKeys.isHaveCr, "")}",
        );
        if (user.influencer != null) {
          await _getCategoriesOfInfluencer(
            NewSession.get(PrefKeys.id, 0),
            ref: ref,
          );
          // await getSocialMediaLinksOfInfluencer(NewSession.get
          //   (PrefKeys.id, 0),ref:  ref);
          await _getSocialMediaLinksOfInfluencer(
            NewSession.get(PrefKeys.id, 0),
            ref: ref,
          );

          state = state.copyWith(
            categories: _getCategoriesOfInfluencer(
              NewSession.get(PrefKeys.id, 0),
              ref: ref,
            ),
            socialMediaLinks: _getSocialMediaLinksOfInfluencer(
              NewSession.get(PrefKeys.id, 0),
              ref: ref,
            ),
          );
          debugPrint("state of categories ${state.categories}");
          debugPrint("here get Categories influencer method done !!!!!");
        }
        state = state.copyWith(
          userType: user.typeId == 1 ? "client" : "influencer",
        );
        debugPrint(
          "client is status ${user.typeId == 1 ? "client" : "influence"
                    "r"}",
        );
        return user;
      } else {
        state = state.copyWith(isLoading: false);
        final String errorMsg = res["msg"] ?? res["message"] ?? "بيانات خاطئة";
        ref.read(formFieldsNotifier.notifier).updateApiErrors({
          'email': errorMsg,
          'password': errorMsg,
        });

        throw Exception("Login failed: $errorMsg");
      }
    } else if (response.statusCode == 404) {
      state = state.copyWith(isLoading: false);
      const String errorMsg = "بيانات الدخول غير صحيحة";
      ref.read(formFieldsNotifier.notifier).updateApiErrors({
        'email': errorMsg,
        'password': errorMsg,
      });

      throw Exception("Login failed: $errorMsg");
    } else {
      state = state.copyWith(isLoading: false);
      //debugPrint("response message ${response.body}");
      throw Exception("response body ${response.body}");
    }
  }
}