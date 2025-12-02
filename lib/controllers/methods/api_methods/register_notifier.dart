
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// import '../../../../controller/get_controllers.dart';
// import '../../../../core/utils/funcations/route_pages/push_routes.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../../../../api/users.dart';
import '../../../../../constants/strings.dart';

import '../../../../../session/sesstion_of_user.dart';
import '../../../../session/new_session.dart';
import '../../statuses/auth_state.dart';

class RegisterNotifier extends StateNotifier<AuthState> {

  RegisterNotifier() : super(AuthState());

  Future<void> register(
      WidgetRef ref, BuildContext context, {
        String? name,
        String? email,
        String? password,
        String? typeId,
      }) async {
    removeUserInfo();
    state = state.copyWith(isLoading: true, errorMessage: null, hasError: false);
    var url = Uri.parse(ServerLocalhostEm.register);

    var response = await http.post(
      url,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "type": NewSession.get(PrefKeys.userType, 'client') == 'client'
            ? "1"
            : "2",
        "is_have_cr": NewSession.get(PrefKeys.isHaveCr, 'no'),

      },
    );

    debugPrint("response: ${response.body}");
    final responseData = jsonDecode(response.body);

    if (response.statusCode <= 400 && responseData["status"] == true) {
      // ✅ FIX: parse the whole response JSON
      final userRes = UserRes.fromJson(responseData);

      // Save token to session
      NewSession.save(PrefKeys.token, userRes.data!.token ?? "");

      // Save user info
      await saveUserInfo(responseData);

      // Clear controllers
      ref.read(emailLoginController).clear();
      ref.read(passwordLoginController).clear();

      // Stop loading
      state = state.copyWith(isLoading: false, hasError: false);

      // Return actual user
    //  return userRes.data;
    }

    //  Handle email already exists
    if (response.statusCode == 404 ||
        responseData["msg"]?.contains("email") == true) {
      ref.read(formFieldsNotifier.notifier).updateApiErrors({
        "emailRegistration": "الإيميل موجود بالفعل",
      });

      state = state.copyWith(isLoading: false);
      throw Exception("Email already exists");
    }

    //  Handle invalid data
    if (response.statusCode == 422) {
      state = state.copyWith(hasError: true, isLoading: false);
      throw Exception("Invalid registration data");
    }

    //  General error
    state = state.copyWith(
      isLoading: false,
      errorMessage: "حدث خطأ أثناء التسجيل. حاول مرة أخرى.",
    );

   // throw Exception("Registration failed");
  }
  Future<void> completeProfile({
    String? phone,
    String? identityNumber,
    String? nickname,
    String? regOwnerName,
    String? institutionName,
    String? branchAddress,
    String? institutionAddress,
    String? rcNumber,
    String? nisNumber,
    String? nifNumber,
    String? iban,
    String? typeOfInfluencer,
    List<int>? categoryIds,
    List<int>? socialMediaIds,
    List<String>? socialMediaLinks,
    String? bio,
  }) async {

    state = state.copyWith(isLoading: true, hasError: false);

    final url = Uri.parse(ServerLocalhostEm.completeProfile);

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${NewSession.get(PrefKeys.token, '')}',
      },
      body: {
        "phone_number": phone,
        "identity_number": identityNumber,
        "nickname": nickname,
        "reg_owner_name": regOwnerName,
        "institution_name": institutionName,
        "branch_address": branchAddress,
        "institution_address": institutionAddress,
        "rc_number": rcNumber,
        "nis_number": nisNumber,
        "nif_number": nifNumber,
        "iban": iban,
        "type_id": typeOfInfluencer,
        "bio": bio,
      },
    );

    debugPrint("Complete profile: ${response.body}");

    // -------------------------------
    //  ERROR HANDLING
    // -------------------------------
    if (response.statusCode >= 400) {
      state = state.copyWith(isLoading: false, hasError: true);
   //   return Future.error("Profile completion failed");
    }

    final responseJson = jsonDecode(response.body);

    // -------------------------------
    // Parse User
    // -------------------------------
    // final user = User.fromJson(
    //   responseJson["data"]["user"],
    //   token: responseJson["data"]["token"],
    // );



    // Save user
    await saveUserInfo(responseJson);

    // -------------------------------
    //  IF USER IS INFLUENCER
    // -------------------------------
    if (typeOfInfluencer != null && typeOfInfluencer.isNotEmpty) {
      // ----- Add Categories -----
      final categoryUrl = Uri.parse(ServerLocalhostEm.addCategories);
      final categoryResponse = await http.post(
        categoryUrl,
        headers: {
          'Authorization': 'Bearer ${NewSession.get(PrefKeys.token, '')}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "category_ids": categoryIds,
        }),
      );

      if (categoryResponse.statusCode >= 400) {
        state = state.copyWith(isLoading: false, hasError: true);
        return Future.error("Category assignment failed");
      }

      NewSession.save(PrefKeys.inflCategories, jsonEncode(categoryIds));

      // ----- Add Social Media -----
      final socialUrl = Uri.parse(ServerLocalhostEm.addSocialMedia);
      final socialResponse = await http.post(
        socialUrl,
        headers: {
          'Authorization': 'Bearer ${NewSession.get(PrefKeys.token, '')}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "social_media_ids": socialMediaIds,
          "social_media_urls": socialMediaLinks,
        }),
      );

      if (socialResponse.statusCode >= 400) {
        state = state.copyWith(isLoading: false, hasError: true);
        return Future.error("Social media saving failed");
      }

      NewSession.save(
        PrefKeys.inflSocialLinks,
        jsonEncode(socialMediaLinks),
      );
    }

    // -------------------------------
    // SUCCESS
    // -------------------------------
    state = state.copyWith(isLoading: false, hasError: false);

   // return user;
  }

//   Future<bool> registerThenComplete({
//     required Map<String, dynamic> baseRegistration, // name,email,password,type
//     required Map<String, dynamic> profileValues, // values from DynamicForm.onChanged
//     required Map<String, File> profileFiles,     // files from DynamicForm.onChanged
//   }) async {
//     // 1) Register (simple post)
//     final regUrl = Uri.parse(ServerLocalhostEm.register);
//     final regResp = await http.post(regUrl, body: {
//       'name': baseRegistration['name'] ?? '',
//       'email': baseRegistration['email'] ?? '',
//       'password': baseRegistration['password'] ?? '',
//          "type": (NewSession.get(PrefKeys.userType, '')) == 'client'? 1 : 2,
//
//     });
//
//     if (regResp.statusCode >= 400) {
//       // parse and surface error
//       return false;
//     }
//
//     final regJson = jsonDecode(regResp.body);
//     // if your register response returns token:
//     final token = regJson['token'] ?? regJson['data']?['token'] ?? (regJson['token'] as String?);
//
//     // 2) Call complete profile using Multipart
//     final completeUrl = Uri.parse(ServerLocalhostEm.completeProfile);
//     final request = http.MultipartRequest('POST', completeUrl);
//     if (token != null) request.headers['Authorization'] = 'Bearer $token';
//
//     // attach profile values
//     profileValues.forEach((k, v) {
//       if (v == null) return;
//       if (v is List) {
//         // arrays: for API expecting category_ids[] or social_media_ids[] (common pattern)
//         for (var item in v) {
//           // if item is map/object you must flatten keys. Here we support simple arrays.
//           request.fields['$k[]'] = item.toString();
//         }
//       } else {
//         request.fields[k] = v.toString();
//       }
//     });
//
//     // attach files
//     for (final entry in profileFiles.entries) {
//       final file = entry.value;
//       final stream = http.ByteStream(file.openRead());
//       final length = await file.length();
//       final multipartFile = http.MultipartFile(entry.key, stream, length, filename: file.path.split('/').last);
//       request.files.add(multipartFile);
//     }
//
//     final streamed = await request.send();
//     final resp = await http.Response.fromStream(streamed);
//     if (resp.statusCode >= 400) {
//       // failure: parse body, show errors
//       return false;
//     }
//
//     // success
//     return true;
//   }





}
