import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/api/users.dart';

class AdminState {
  final bool isLoading;
  final String? errorMessage;
  final List<User> users;
  final List<Promotion> promotions;
  final List<CustomPromotion> customPromotions;
  final User? selectedUser;

  AdminState({
    this.isLoading = false,
    this.errorMessage,
    this.users = const [],
    this.promotions = const [],
    this.customPromotions = const [],
    this.selectedUser,
  });

  AdminState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<User>? users,
    List<Promotion>? promotions,
    List<CustomPromotion>? customPromotions,
    User? selectedUser,
    bool clearSelectedUser = false, // Flag to explicitly clear selectedUser
  }) {
    return AdminState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      users: users ?? this.users,
      promotions: promotions ?? this.promotions,
      customPromotions: customPromotions ?? this.customPromotions,
      selectedUser: clearSelectedUser
          ? null
          : (selectedUser ?? this.selectedUser),
    );
  }
}
