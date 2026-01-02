import 'package:dz_pub/api/users.dart';

class AdminState {
  final bool isLoading;
  final String? errorMessage;
  final List<User> users;
  final User? selectedUser;

  AdminState({
    this.isLoading = false,
    this.errorMessage,
    this.users = const [],
    this.selectedUser,
  });

  AdminState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<User>? users,
    User? selectedUser,
    bool clearSelectedUser = false, // Flag to explicitly clear selectedUser
  }) {
    return AdminState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
          errorMessage, // We'll assume if passed, it overwrites (even if null? no usually ?? check)
      // Simpler: just overwrite if provided, or keep old?
      // Let's use standard:
      // errorMessage: errorMessage ?? this.errorMessage,
      // User can pass empty string to clear? Or just handle loading states correctly.
      users: users ?? this.users,
      selectedUser: clearSelectedUser
          ? null
          : (selectedUser ?? this.selectedUser),
    );
  }
}
