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

      throw Exception("Server error ${response.statusCode}");
    }
  }
}
