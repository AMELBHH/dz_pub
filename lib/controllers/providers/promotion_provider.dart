import 'dart:io';

import 'package:dz_pub/controllers/methods/api_methods/promotion_notifier.dart';
import 'package:dz_pub/controllers/statuses/promotion_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

final promotionProvider =
    StateNotifierProvider<PromotionNotifier, PromotionState>((ref) {
      return PromotionNotifier();
    });
//strings values :
final shouldInfluencerMovementProvider = StateProvider<String>((ref) => "no");

final haveAFormProvider = StateProvider<String>((ref) => "no");

  final isTopicReadyProvider = StateProvider<String>((ref) => "no");
final haveSampleProvider = StateProvider<String>((ref) => "no");
  //location
//recommendations
final requirementsController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final detailsController  = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
          () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final fileOfTopicProvider = StateProvider<File?>((ref) => null);

//locationCotroller

final locationController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

//timeline
final timeLineController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final priceController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});final customPromotionController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
  //socialMedia
final socialMediaIdsProvider = StateProvider<List<int>>((ref) => []);
  final   postTypeIdsProvider = StateProvider<List<int>>((ref) => []);
//typeOfPromotion
//statusId
final statusIdProvider = StateProvider<int>((ref) => 0);
//clientId
final clientIdProvider = StateProvider<int>((ref) => 0);
//influencerId
final influencerIdProvider = StateProvider<int>((ref) => 0);
final promotionTypeProvider = StateProvider<int?>((ref) => null);

