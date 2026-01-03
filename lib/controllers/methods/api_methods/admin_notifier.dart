import 'package:dz_pub/api/advertisement.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/api/promations_models/promotions.dart';
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
          final List<User> users = data.map((e) {
            if (e is Map<String, dynamic> && e.containsKey('user')) {
              return User.fromJson(e['user']);
            }
            return User.fromJson(e);
          }).toList();
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
          final List<User> users = data.map((e) {
            if (e is Map<String, dynamic> && e.containsKey('user')) {
              return User.fromJson(e['user']);
            }
            return User.fromJson(e);
          }).toList();
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
          final List<User> users = data.map((e) {
            if (e is Map<String, dynamic> && e.containsKey('user')) {
              return User.fromJson(e['user']);
            }
            return User.fromJson(e);
          }).toList();
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

  Future<void> getUsersByType(int typeId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(Uri.parse(ServerLocalhostEm.getUsers));
      debugPrint("Get Users By Type Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<User> allUsers = data.map((e) {
            if (e is Map<String, dynamic> && e.containsKey('user')) {
              return User.fromJson(e['user']);
            }
            return User.fromJson(e);
          }).toList();

          // Filter users by type_id
          final List<User> filteredUsers = allUsers
              .where((user) => user.typeId == typeId)
              .toList();

          state = state.copyWith(isLoading: false, users: filteredUsers);
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching users by type',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Users By Type Error: $e");
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
          dynamic userData = res['data'];
          if (userData != null) {
            // If the API returns a list (as seen in get users), take the first user
            if (userData is List && userData.isNotEmpty) {
              userData = userData.first;
            }

            if (userData is Map<String, dynamic>) {
              final user = userData.containsKey('user')
                  ? User.fromJson(userData['user'])
                  : User.fromJson(userData);
              state = state.copyWith(isLoading: false, selectedUser: user);
            } else {
              state = state.copyWith(
                isLoading: false,
                errorMessage: 'Unexpected data format',
              );
            }
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

            if (updatedUserJson['user_info'] != null) {
              updatedUserJson['user_info']['is_verified'] = verifyVal;
            }
            state = state.copyWith(
              selectedUser: User.fromJson(updatedUserJson),
            );
          }

          // Also update the user in the list if present
          final updatedUsers = state.users.map((u) {
            if (u.id == userId) {
              final json = u.toJson();
              if (json['user_info'] != null) {
                json['user_info']['is_verified'] = verifyVal;
              }
              return User.fromJson(json);
            }
            return u;
          }).toList();

          state = state.copyWith(users: updatedUsers);
          return true;
        }
      }
    } catch (e) {
      debugPrint("Update Verification Error: $e");
    }
    return false;
  }

  Future<void> getAllPromotions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(
        Uri.parse(ServerLocalhostEm.getPromotions),
      );
      debugPrint("Get All Promotions Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<Promotion> promotions = data
              .map((e) => Promotion.fromJson(e))
              .toList();
          state = state.copyWith(
            isLoading: false,
            promotions: promotions,
            customPromotions: [],
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching promotions',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get All Promotions Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getPromotionsByStatusIdForAdmin(int statusId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final url =
          '${ServerLocalhostEm.getPromotionsByStatusIdForAdmin}?status_id=$statusId';
      debugPrint("Get Promotions By Status URL: URL Ok ??");
      final response = await http.get(Uri.parse(url));

      debugPrint("Get Promotions By Status Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<Promotion> promotions = data
              .map((e) => Promotion.fromJson(e))
              .toList();
          state = state.copyWith(
            isLoading: false,
            promotions: promotions,
            customPromotions: [],
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching promotions',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Promotions By Status Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> updatePromotionStatus(int promotionId, int statusId) async {
    try {
      final url =
          '${ServerLocalhostEm.updatePromotionStatus}?promation_id=$promotionId&status_id=$statusId';
      debugPrint("Update Promotion Status URL: $url");
      final response = await http.post(Uri.parse(url));
      debugPrint("Update Promotion Status Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          // Update the promotion in the local list
          final updatedPromotions = state.promotions.map((p) {
            if (p.id == promotionId) {
              return Promotion(
                id: p.id,
                clientId: p.clientId,
                influencerId: p.influencerId,
                requirements: p.requirements,
                statusId: statusId,
                price: p.price,
                timeLine: p.timeLine,
                shouldInfluencerMovement: p.shouldInfluencerMovement,
                createdAt: p.createdAt,
                updatedAt: DateTime.now().toIso8601String(),
                socialMedia: p.socialMedia,
                socialMediaTypes: p.socialMediaTypes,
                typeOfPromotions: p.typeOfPromotions,
                movement: p.movement,
                registration: p.registration,
                recommendations: p.recommendations,
                topicFromInfluancers: p.topicFromInfluancers,
                topicAlreadyReadies: p.topicAlreadyReadies,
                influencer: p.influencer,
              );
            }
            return p;
          }).toList();

          state = state.copyWith(promotions: updatedPromotions);
          return true;
        }
      }
    } catch (e) {
      debugPrint("Update Promotion Status Error: $e");
    }
    return false;
  }

  Future<void> getAllCustomPromotions() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(
        Uri.parse(ServerLocalhostEm.getAllCustomPromotions),
      );
      debugPrint("Get All Custom Promotions Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<CustomPromotion> customPromotions = data
              .map((e) => CustomPromotion.fromJson(e))
              .toList();
          state = state.copyWith(
            isLoading: false,
            customPromotions: customPromotions,
            promotions: [],
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching custom promotions',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get All Custom Promotions Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      final url = '${ServerLocalhostEm.deleteUser}?user_id=$userId';
      debugPrint("Delete User URL: $url");
      final response = await http.get(Uri.parse(url));
      debugPrint("Delete User Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          // Remove from local list
          final updatedUsers = state.users
              .where((u) => u.id != userId)
              .toList();

          // Clear selected user if it's the one deleted
          final selectedUser = (state.selectedUser?.id == userId)
              ? null
              : state.selectedUser;

          state = state.copyWith(
            users: updatedUsers,
            selectedUser: selectedUser,
            clearSelectedUser: selectedUser == null,
          );
          return true;
        }
      }
    } catch (e) {
      debugPrint("Delete User Error: $e");
    }
    return false;
  }

  Future<void> getAdvertisements() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await http.get(
        Uri.parse(ServerLocalhostEm.getAdvertisements),
      );
      debugPrint("Get Advertisements Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<Advertisement> advertisements = data
              .map((e) => Advertisement.fromJson(e))
              .toList();
          state = state.copyWith(
            isLoading: false,
            advertisements: advertisements,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching advertisements',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Advertisements Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> getAdvertisementsByVerification({
    String? isVerified,
    int? typeId,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final Map<String, String> queryParams = {};
    if (isVerified != null) queryParams['is_verified'] = isVerified;
    if (typeId != null) queryParams['type_id'] = typeId.toString();

    final uri = Uri.parse(
      ServerLocalhostEm.getAdvertisementsByVerification,
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);
      debugPrint(
        "Get Advertisements By Verification Response: ${response.body}",
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final List<dynamic> data = res['data'];
          final List<Advertisement> advertisements = data
              .map((e) => Advertisement.fromJson(e))
              .toList();
          state = state.copyWith(
            isLoading: false,
            advertisements: advertisements,
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: res['message'] ?? 'Error fetching advertisements',
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Server Error: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint("Get Advertisements By Verification Error: $e");
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> deleteAdvertisement(int advertisementId) async {
    try {
      final uri = Uri.parse(ServerLocalhostEm.deleteAdvertisement).replace(
        queryParameters: {'advertisement_id': advertisementId.toString()},
      );

      final response = await http.delete(uri);
      debugPrint("Delete Advertisement Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true) {
          final updatedAds = state.advertisements
              .where((ad) => ad.id != advertisementId)
              .toList();
          state = state.copyWith(advertisements: updatedAds);
          return true;
        }
      }
    } catch (e) {
      debugPrint("Delete Advertisement Error: $e");
    }
    return false;
  }

  Future<bool> addAdvertisement({
    required int promotionId,
    required String description,
    File? file,
  }) async {
    try {
      final uri = Uri.parse(ServerLocalhostEm.addAdvertisement);
      final request = http.MultipartRequest('POST', uri);

      request.fields['promation_id'] = promotionId.toString();
      request.fields['description'] = description;

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath('file_path', file.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint("Add Advertisement Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        return res['status'] == true;
      }
    } catch (e) {
      debugPrint("Add Advertisement Error: $e");
    }
    return false;
  }

  Future<bool> updateAdvertisement({
    required int advertisementId,
    String? description,
    File? file,
  }) async {
    try {
      final uri = Uri.parse(ServerLocalhostEm.updateAdvertisement);
      // If it's a PUT request with files, some servers require using POST with _method=PUT
      // but the user explicitly said PUT method.
      final request = http.MultipartRequest('POST', uri);
      request.fields['_method'] =
          'PUT'; // Common pattern for Laravel/multipart PUT

      request.fields['advertisement_id'] = advertisementId.toString();
      if (description != null) request.fields['description'] = description;

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath('file_path', file.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint("Update Advertisement Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        return res['status'] == true;
      }
    } catch (e) {
      debugPrint("Update Advertisement Error: $e");
    }
    return false;
  }

  Future<List<Advertisement>> getAdvertisementsByPromotion(
    int promotionId,
  ) async {
    try {
      final uri = Uri.parse(
        ServerLocalhostEm.getAdvertisementsByPromotion,
      ).replace(queryParameters: {'promation_id': promotionId.toString()});

      final response = await http.get(uri);
      debugPrint("Get Ads By Promotion Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> res = jsonDecode(response.body);
        if (res['status'] == true && res['data'] != null) {
          final List<dynamic> data = res['data'];
          return data.map((e) => Advertisement.fromJson(e)).toList();
        }
      } else if (response.statusCode == 404) {
        return [];
      }
    } catch (e) {
      debugPrint("Get Ads By Promotion Error: $e");
    }
    return [];
  }
}
