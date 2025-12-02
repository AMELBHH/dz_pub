import 'dart:convert';

import 'package:dz_pub/api/categories.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/categry_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

  class GetCategoryNotifier extends StateNotifier<CategoryState> {
    GetCategoryNotifier() : super(CategoryState());

    Future<List<Category>> _getCategory() async {
        final uri = Uri.parse(ServerLocalhostEm.getCategories);
        final response = await http.get(uri);

          final categories = jsonDecode(response.body);
          debugPrint(categories.toString());

          return CategoryResponse.fromJson(categories).categories??[];

    }

    Future<void> getCategory() async {
      state = state.copyWith(isLoading: true);
       await _getCategory();
      state = state.copyWith(categories: _getCategory(), isLoading: false);

    }


  }