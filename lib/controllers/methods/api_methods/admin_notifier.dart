import 'dart:convert';
import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/statuses/admin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

class AdminNotifier extends StateNotifier<AdminState> {
  AdminNotifier() : super(AdminState());

  Future<void> getUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(Uri.parse(ServerLocalhostEm.getUsers));
      debugPrint("Get Users Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<User> users = data.map((e) => User.fromJson(e)).toList();
          state = state.copyWith(isLoading: false, users: users);
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching users',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Users Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getInactiveUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(
        Uri.parse(ServerLocalhostEm.getInactiveUsers),
      );
      debugPrint("Get Inactive Users Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<User> users = data.map((e) => User.fromJson(e)).toList();
          state = state.copyWith(isLoading: false, users: users);
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching inactive users',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Inactive Users Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getUnverifiedUsers(int typeId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final url = '${ServerLocalhostEm.getUnverifiedUsers}?type_id=$typeId';
      final response = await http.get(Uri.parse(url));
      debugPrint("Get Unverified Users Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<User> users = data.map((e) => User.fromJson(e)).toList();
          state = state.copyWith(isLoading: false, users: users);
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching unverified users',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Unverified Users Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getUserById(int id) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      clearSelectedUser: true,
    );
    try {
      final url = '${ServerLocalhostEm.getUserById}?id=$id';
      final response = await http.get(Uri.parse(url));
      debugPrint("Get User By ID Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final userData = res['data'];
          if (userData != null) {
            final user = User.fromJson(userData);
            state = state.copyWith(isLoading: false, selectedUser: user);
          } else {
            state = state.copyWith(
              isLoading: false,
              errorMessage: 'User data is null',
            );
          }
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching user',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get User By ID Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> updateUserStatus(int userId, int isActive) async {
    try {
      final url =
          '${ServerLocalhostEm.updateUserStatus}?id=$userId&is_active=$isActive';
      debugPrint("Update User Status URL: $url");
      final response = await http.post(Uri.parse(url));
      debugPrint("Update User Status Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          // Update selected user in state if it matches
          if (state.selectedUser != null && state.selectedUser!.id == userId) {
            final updatedUserJson = state.selectedUser!.toJson();
            updatedUserJson['is_active'] = isActive; // Update locally
            state = state.copyWith(
              selectedUser: User.fromJson(updatedUserJson),
            );
          }

          // Also update the user in the list if present
          final updatedUsers = state.users.map((u) {
            if (u.id == userId) {
              final json = u.toJson();
              json['is_active'] = isActive;
              return User.fromJson(json);
            }
            return u;
          }).toList();

          state = state.copyWith(users: updatedUsers);
          return true;
        }
      }
    } catch (e) {
      debugPrint("Update User Status Error: $e");
    }
    return false;
  }

  Future<bool> updateUserVerification(int userId, bool isVerified) async {
    try {
      final verifyVal = isVerified ? "yes" : "no";
      final url =
          '${ServerLocalhostEm.updateUserVerification}?user_id=$userId&is_verified=$verifyVal';
      debugPrint("Update Verification URL: $url");
      final response = await http.put(Uri.parse(url));
      debugPrint("Update Verification Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          // Update selected user in state
          if (state.selectedUser != null && state.selectedUser!.id == userId) {
            final updatedUserJson = state.selectedUser!.toJson();

            // UserInfo might be null, though logically if we verify, user info should exist?
            // Let's check safely.
            if (updatedUserJson['user_info'] != null) {
              updatedUserJson['user_info']['is_verified'] = verifyVal;
            } else {
              // Create partial user info if needed or just ignore?
              // Assuming user_info exists if we are verifying.
              // If not, we might need to handle it, but for now let's update if present.
            }
            state = state.copyWith(
              selectedUser: User.fromJson(updatedUserJson),
            );
          }
          return true;
        }
      }
    } catch (e) {
      debugPrint("Update Verification Error: $e");
    }
    return false;
  }
}
