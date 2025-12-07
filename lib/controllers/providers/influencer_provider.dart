import 'package:dz_pub/controllers/methods/api_methods/get_category.dart';
import 'package:dz_pub/controllers/methods/api_methods/influencer_notifier.dart';
import 'package:dz_pub/controllers/statuses/categry_state.dart';
import 'package:dz_pub/controllers/statuses/influencer_state.dart';
import 'package:flutter_riverpod/legacy.dart';

final getCategoryNotifier = StateNotifierProvider<GetCategoryNotifier,
    CategoryState>(
        (ref) {
  return GetCategoryNotifier();
});

final influencerNotifier = StateNotifierProvider<InfluencerNotifier,
    InfluencerState>(
        (ref) {
  return  InfluencerNotifier();
});
final categorySelectableName = StateProvider<String>((ref) => '');
final categorySelectedId = StateProvider<int>((ref) => 0);