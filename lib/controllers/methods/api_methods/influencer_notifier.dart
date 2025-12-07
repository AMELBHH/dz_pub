import 'dart:convert';

import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/influencer_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class InfluencerNotifier extends StateNotifier<InfluencerState> {
  InfluencerNotifier() : super(InfluencerState());


  Future<User> _getUserById(int id) async {
    final response = await http.get(Uri.parse("${ServerLocalhostEm
        .getInfluencerById}?id=$id"));
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

    late Uri uri;
    if(categoryId == null){state = state.copyWith(isFetched: false);

    uri=  Uri.parse(

          ServerLocalhostEm.getAllInfluencers);
    }else{
      state = state.copyWith(isFetched: true);
      uri  = Uri.parse(
          "${ServerLocalhostEm.getInfluencersByCategory}?category_id=$categoryId");
    }



    final response = await http.get(uri);

    debugPrint("res $categoryId");

    if (response.statusCode != 200) {
      throw Exception("Failed to load influencers");
    }

    final body = jsonDecode(response.body);

    // Extract list from JSON
    final List influencersJson = body['data'] ?? [];

    // Convert JSON list → List<Influencer>
    final influencers = influencersJson
        .map((json) => User.fromJson(json))
        .toList();
    debugPrint("influencers json $influencers");

    return influencers;
  }

  Future<void> getInfluencers({int ? categoryId}) async {
    state = state.copyWith(isLoading: true);
    await _getInfluencers(categoryId: categoryId);
    state = state.copyWith(influencer: _getInfluencers(categoryId: categoryId),
        isLoading: false);

  }


}