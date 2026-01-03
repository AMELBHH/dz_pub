import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/api/advertisement.dart';

class PromotionState {
  final bool isLoading;
  final bool hasError;
  final bool status;
  final String? errorMessage;
  final Future<List<Promotion>>? promotions;
  final Future<Promotion>? promotion;
  final Future<List<CustomPromotion>>? customPromotion;
  final Future<List<Advertisement>>? advertisements;

  PromotionState({
    this.isLoading = false,
    this.hasError = false,
    this.status = false,
    this.errorMessage,
    this.promotion,
    this.promotions,
    this.customPromotion,
    this.advertisements,
  });

  PromotionState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    bool? status,
    Future<Promotion>? promotion,
    Future<List<Promotion>>? promotions,
    Future<List<CustomPromotion>>? customPromotion,
    Future<List<Advertisement>>? advertisements,
  }) {
    return PromotionState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      promotion: promotion ?? this.promotion,
      promotions: promotions ?? this.promotions,
      status: status ?? this.status,
      customPromotion: customPromotion ?? this.customPromotion,
      advertisements: advertisements ?? this.advertisements,
    );
  }
}

// class     PromotionState {
//   final bool isLoading;
//   final String? errorMessage;
//   final bool hasError;
//   final Future<List<Promotion>>? promotion;
//   final bool? isFetched;
//   final Future<Promotion>? promotionById;
//
//
//   PromotionState( {this.isLoading = false,this.hasError = false, this
//       .errorMessage,this.promotion, this.isFetched,
//     this.promotionById,
//   });
//
//   PromotionState copyWith({bool?  isLoading, String? errorMessage,bool ? hasError,
//     Future<List<Promotion>>? promotion,
//     Future<Promotion>? promotionById,
//     bool? isFetched,
//   }) {
//     return PromotionState(
//       isLoading: isLoading ?? this.isLoading,
//       hasError: hasError ?? this.hasError,
//       errorMessage: errorMessage ?? this.errorMessage,
//       promotion: promotion ?? this.promotion,
//       promotionById: promotionById ?? this.promotionById,
//       isFetched: isFetched ?? this.isFetched,
//     );
//   }
// }
