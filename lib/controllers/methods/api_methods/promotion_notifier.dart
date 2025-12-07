//add, get, get according status ...
import 'dart:convert';
import 'dart:io';
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
  // ===============================
  Future<Promotion> _createPromotion(Map<String, dynamic> body, {
    File? fileOfRecommendation,
    File? fileOfTopic,
    File? mediaFile,
  }) async {
state = state.copyWith(
  isLoading: true,
  hasError: false,
  status: false,
  errorMessage: "",
);
    final url = Uri.parse(ServerLocalhostEm.createPromotion);

    final request = http.MultipartRequest('POST', url);

    // Authorization
    request.headers['Authorization'] =
    'Bearer ${NewSession.get(PrefKeys.token, '')}';

    // -----------------------
    // ADD TEXT FIELDS
    // -----------------------

    body.forEach((key, value) {
      if (value == null) return;

      if (value is List) {
        // special case: arrays
        for (var v in value) {
          request.fields["$key[]"] = v.toString();
        }
      } else {
        request.fields[key] = value.toString();
      }
    });

    // -----------------------
    // ADD FILES IF EXISTS
    // -----------------------
    Future<void> addFile(String field, File? file) async {
      if (file == null) return;
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipart = http.MultipartFile(
          field, stream, length,
          filename: file.path.split('/').last
      );
      request.files.add(multipart);
    }

    await addFile("file_of_recommendation", fileOfRecommendation);
    await addFile("file_of_topic", fileOfTopic);
    await addFile("file_path", mediaFile);

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode >= 400) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        status: false,
        errorMessage: "Failed: ${response.body}",
      );
      throw Exception("Failed: ${response.body}");

    }else if(response.statusCode >= 200 && response.statusCode < 300){
      state = state.copyWith(
        isLoading: false,
        status: true,
        hasError: false,
        errorMessage: "",
      );
    }

    final json = jsonDecode(response.body);
    debugPrint("json $json");

    return Promotion.fromJson(json["promotion"]);
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

    try {
      final body = {

        "client_id":216,
        //NewSession.get(PrefKeys.id, 0),
        //clientId,
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
  Future<List<Promotion>> _getPromotionsOfClient() async {
    final url = Uri.parse("${ServerLocalhostEm.getPromotionsOfClient}?client_id=${NewSession.get(PrefKeys.id, 0)}");
    final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${NewSession.get(PrefKeys.token, '')}',
        },
        );
    debugPrint("status code of get promotion of client is ${response.statusCode}");

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
  Future<void> getPromotionsOfClient() async {
    state = state.copyWith(isLoading: true, hasError: false,errorMessage: "");
    try {
      final promotions = await _getPromotionsOfClient();
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
}
