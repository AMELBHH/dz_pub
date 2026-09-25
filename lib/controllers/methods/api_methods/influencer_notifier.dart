import 'dart:convert';

import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/influencer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class InfluencerNotifier extends StateNotifier<InfluencerState> {
  InfluencerNotifier() : super(InfluencerState());

  // ==========================================================================
  // بيانات ثابتة (Demo) - مشهور واحد بلا باك اند
  // ==========================================================================
  static final List<Map<String, dynamic>> _demoInfluencersJson = [
    {
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
  ];
  // ==========================================================================
  // نهاية جزء البيانات الثابتة
  // ==========================================================================

  Future<User> _getUserById(int id) async {
    // إذا الـ id تبع المشهور الديمو، نرجعوه مباشرة بلا سيرفر
    if (id == 9002) {
      final user = User.fromJson(_demoInfluencersJson.first);
      state = state.copyWith(userInfluencerModel: user);
      return user;
    }

    final response = await http.get(
      Uri.parse("${ServerLocalhostEm.getInfluencerById}?id=$id"),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to load user");
    }
    final body = jsonDecode(response.body);
    state = state.copyWith(userInfluencerModel: User.fromJson(body['data']));
    return User.fromJson(body['data']);
  }

  Future<User> getUserById(int id) async {
    final user = await _getUserById(id);
    state = state.copyWith(influencerById: _getUserById(id));
    return user;
  }

  Future<List<User>> _getInfluencers({int? categoryId}) async {
    // ========================================================================
    // وضع الديمو: نرجعو القائمة الثابتة مباشرة بلا اتصال بالسيرفر
    // ========================================================================
    state = state.copyWith(isFetched: categoryId != null);
    final influencers = _demoInfluencersJson
        .map((json) => User.fromJson(json))
        .toList();
    debugPrint("[DEMO] influencers: $influencers");
    return influencers;
    // ========================================================================
    // نهاية وضع الديمو - الكود الأصلي تحت (معطّل حالياً)
    // ========================================================================

    // late Uri uri;
    // if (categoryId == null) {
    //   state = state.copyWith(isFetched: false);
    //   uri = Uri.parse(ServerLocalhostEm.getAllInfluencers);
    // } else {
    //   state = state.copyWith(isFetched: true);
    //   uri = Uri.parse(
    //     "${ServerLocalhostEm.getInfluencersByCategory}?category_id=$categoryId",
    //   );
    // }
    //
    // final response = await http.get(uri);
    //
    // debugPrint("res $categoryId");
    // debugPrint("STATUS: ${response.statusCode}");
    // debugPrint("HEADERS: ${response.headers}");
    // debugPrint("BODY: ${response.body.substring(0, 300)}");
    //
    // if (response.statusCode != 200) {
    //   throw Exception("Failed to load influencers");
    // }
    //
    // final body = jsonDecode(response.body);
    //
    // final List influencersJson = body['data'] ?? [];
    //
    // final influencers = influencersJson
    //     .map((json) => User.fromJson(json))
    //     .toList();
    // debugPrint("influencers json $influencers");
    //
    // return influencers;
  }

  Future<void> getInfluencers({int? categoryId}) async {
    state = state.copyWith(isLoading: true);
    await _getInfluencers(categoryId: categoryId);
    state = state.copyWith(
      influencer: _getInfluencers(categoryId: categoryId),
      isLoading: false,
    );
  }
}