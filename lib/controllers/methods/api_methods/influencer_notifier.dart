import 'dart:convert';

import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/influencer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class GetInfluencerNotifier extends StateNotifier<InfluencerState> {
  GetInfluencerNotifier() : super(InfluencerState());

  Future<List<Influencer>> _getInfluencersByCategory(int categoryId) async {
    final uri = Uri.parse(
        "${ServerLocalhostEm.getInfluencersByCategory}?category_id=$categoryId");

    final response = await http.get(uri);

    debugPrint("res $categoryId");

    if (response.statusCode != 200) {
      throw Exception("Failed to load influencers");
    }

    final body = jsonDecode(response.body);

    // Extract list from JSON
    final List influencersJson = body['influencers'] ?? [];

    // Convert JSON list → List<Influencer>
    final influencers = influencersJson
        .map((json) => Influencer.fromJson(json))
        .toList();

    return influencers;
  }

  Future<void> getInfluencer(int id) async {
    state = state.copyWith(isLoading: true);
    await _getInfluencersByCategory(id);
    state = state.copyWith(influencer: _getInfluencersByCategory(id),
        isLoading: false,isFetched: true);

  }


}