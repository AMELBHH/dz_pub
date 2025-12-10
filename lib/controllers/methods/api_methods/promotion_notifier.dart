//add, get, get according status ...
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/promotion_state.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class PromotionNotifier extends StateNotifier<PromotionState> {
  PromotionNotifier() : super(PromotionState());

  // ===============================
  // INTERNAL REQUEST (PRIVATE)
  // ==============================
  Future<Promotion> _createPromotion(
      Map<String, dynamic> body, {
        File? fileOfRecommendation,
        File? fileOfTopic,
        File? mediaFile,
      }) async {

    final dio = Dio();

    dio.options.headers['Authorization'] =
    'Bearer ${NewSession.get(PrefKeys.token, '')}';

    // 1) أنشئ FormData فاضي
    final formData = FormData();

    // 2) أضف العناصر العادية (بدون الليست)
    body.forEach((key, value) {
      if (value != null &&
          key != "social_media" &&
          key != "social_media_types") {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    // ============================
    // 3) FIX: social_media list
    // ============================
    if (body["social_media"] != null) {
      List<int> sm = body["social_media"];
      for (int i = 0; i < sm.length; i++) {
        formData.fields.add(
          MapEntry("social_media[$i]", sm[i].toString()),
        );
      }
    }

    // ============================
    // 4) FIX: social_media_types list
    // ============================
    if (body["social_media_types"] != null) {
      List<int> smt = body["social_media_types"];
      for (int i = 0; i < smt.length; i++) {
        formData.fields.add(
          MapEntry("social_media_types[$i]", smt[i].toString()),
        );
      }
    }

    // 5) الملفات
    if (fileOfRecommendation != null) {
      formData.files.add(MapEntry(
        'file_of_recommendation',
        await MultipartFile.fromFile(
          fileOfRecommendation.path,
          filename: fileOfRecommendation.path.split('/').last,
        ),
      ));
    }

    if (fileOfTopic != null) {
      formData.files.add(MapEntry(
        'file_of_topic',
        await MultipartFile.fromFile(
          fileOfTopic.path,
          filename: fileOfTopic.path.split('/').last,
        ),
      ));
    }

    if (mediaFile != null) {
      formData.files.add(MapEntry(
        'file_path',
        await MultipartFile.fromFile(
          mediaFile.path,
          filename: mediaFile.path.split('/').last,
        ),
      ));
    }

    // 6) إرسال الريكويست
    try {
      final response = await dio.post(
        ServerLocalhostEm.createPromotion,
        data: formData,
      );

      return Promotion.fromJson(response.data["promotion"]);

    } on DioException catch (e) {
     // print("STATUS: ${e.response?.statusCode}");
      //print("DATA: ${e.response?.data}");
      //print("HEADERS: ${e.response?.headers}");

      throw Exception(e.response?.data);
    }
  }

  // ===============================
  // PUBLIC METHOD
  // ===============================
  Future<void> createPromotion({
    // main promotion
    required int clientId,
    required int influencerId,
    required String requirements,
    required double price,
    required String timeLine,
    required String shouldInfluencerMovement,
   // required int statusId,

    // social media arrays
    required List<int> socialMediaIds,
    required List<int> socialMediaTypes,

    // movement
    String? location,
    File? fileOfTopic,

    // registration
    String? haveAForm,
    int? promationTypeId,

    // script promotion
    String? text,
    File? fileOfRecommendation,

    // topic ready
    String? detials,
    String? haveSmaple,
    String? topicIsReady,
    File? mediaFile,
  }) async {
debugPrint("promation Type is $promationTypeId");
    state = state.copyWith(isLoading: true, hasError: false,errorMessage: "");
debugPrint("tipick is Ready ???? ------>$topicIsReady");
    try {
      final body = {

        "client_id": clientId,
        "influencer_id": influencerId,
        "requirements": requirements,
        "price": price,
        "time_line": timeLine,
        "should_influencer_movment": shouldInfluencerMovement,
        //"status_id": statusId,

        "social_media": socialMediaIds,
        "social_media_types": socialMediaTypes,

        // movement
        "location": location,

        // registration
        "have_a_form": haveAForm,
        "promation_type_id": promationTypeId,

        // script
        "text": text,

        // topic ready / from influencer
        "detials": detials,
        "have_smaple": haveSmaple,
        "topic_is_ready": topicIsReady,
      };

      final promotion = await _createPromotion(
        body,
        fileOfRecommendation: fileOfRecommendation,
        fileOfTopic: fileOfTopic,
        mediaFile: mediaFile,
      );

      state = state.copyWith(
        isLoading: false,
        promotion: Future.value(promotion),
      );

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }



  Future<List<Promotion>> _getPromotionsOfClient({int ? statusId }) async {
     late Uri url;
     if(statusId!=null)
     {
       url = Uri.parse(
           "${ServerLocalhostEm
               .getPromotionsByStatus}?influencer_id=${NewSession
           .get(PrefKeys.id, 0)}&status_id=$statusId");
     }else {
       url = Uri.parse(
           "${ServerLocalhostEm.getPromotionsOfClient}?client_id=${NewSession
               .get(PrefKeys.id, 0)}");
     }
     final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${NewSession.get(PrefKeys.token, "")}',
        },
        );

    if (response.statusCode >= 400) {
      debugPrint("Failed: ${response.body}");
      throw Exception("Failed: ${response.body}");
    }
    final json = jsonDecode(response.body);
      debugPrint("json $json");
    return (json["promotions"] as List)
        .map((e) => Promotion.fromJson(e))
        .toList();
  }
  Future<void> getPromotionsOfClient({int ? statusId }) async {
    state = state.copyWith(isLoading: true, hasError: false,errorMessage: "");
    try {
      final promotions = await _getPromotionsOfClient(statusId:statusId);
      debugPrint("promations is status of the promations nototigfier is "
          "${state.promotions}");
      state = state.copyWith(
        isLoading: false,
        promotions: Future.value(promotions),
      );

    } catch (e) {
      // state = state.copyWith(
      //   isLoading: false,
      //   hasError: true,
      //   errorMessage: e.toString(),
      // );
      //throw Exception(e.toString());
    }
  }


  Future<List<CustomPromotion>> _getCustomPromotionByClientId() async {
    final url =
        "${ServerLocalhostEm.getCustomPromotion}?client_id=${NewSession.get(PrefKeys.id, 0)}";

    final response = await http.get(Uri.parse(url));

    debugPrint("response : ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to load custom promotion");
    }

    final body = jsonDecode(response.body);

    debugPrint("success to load custom promotion : ${body['data']}");

    // body['data'] is LIST now
    return (body['data'] as List)
        .map((json) => CustomPromotion.fromJson(json))
        .toList();
  }

  Future<void> getCustomPromotionByClientId() async {
    state = state.copyWith(isLoading: true,);
    final promotion = await _getCustomPromotionByClientId();


    state = state.copyWith(
        isLoading: false,
        customPromotion: Future.value(promotion)
    );
  }
  Future<void> _createCustomPromotion({required String text}) async {
    final clientId = NewSession.get(PrefKeys.id, 0);

    final url = Uri.parse(
      "${ServerLocalhostEm.createCustomPromotion}"
          "?client_id=$clientId"
          "&text=${Uri.encodeComponent(text)}",
    );

    final response = await http.get(url);

    debugPrint("STATUS: ${response.statusCode}");
    debugPrint("BODY: ${response.body}");

    // لو بدك، ممكن تتجاهل التحقق، بس هذا الأفضل
    if (response.statusCode != 200) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: "Failed to create custom promotion",
      );
      throw Exception("Failed to create custom promotion");
    }

    // لا return… لأنها void
  }

  Future<void> createCustomPromotion({required String text}) async {
    state = state.copyWith(isLoading: true, hasError: false,errorMessage: "");
    try {
    await _createCustomPromotion(text: text);
      state = state.copyWith(
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }
}
