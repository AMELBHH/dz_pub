// import 'package:flutter/material.dart';


import 'dart:convert';

import 'package:dz_pub/api/categories.dart';
import 'package:dz_pub/api/social_media.dart';
import 'package:dz_pub/api/users.dart';
import 'package:flutter/cupertino.dart';

import '../constants/strings.dart';
import 'new_session.dart';
/// Save all user info from a full response or a User object
  Future<void> saveUserInfo(dynamic data) async {

    User user;


    // Determine if 'data' is already a User or JSON
    // if (data is User) {
    //   user = data;
    // } else
      if (data is Map<String, dynamic>) {
      // Handle full response or nested 'user'
      final userJson = data['data']?['user'] ?? data['user'];
      final token = data['data']?['token'] ?? data['token'];
      if (userJson == null) return;
      user = User.fromJson(userJson, token: token);
    } else {
      return; // invalid input
    }
debugPrint("user on the seesion of user file : ${user.toJson()} ");
      debugPrint("client on the session of user file : ${user.client?.toJson
        ()}");
      debugPrint("user info on teh seesion of user file : ${
          user.userInfo?.toJson()}");
    // -----------------------
    // Base user info
    // -----------------------
    NewSession.save(PrefKeys.id, user.id);
    NewSession.save(PrefKeys.name, user.name);
    NewSession.save(PrefKeys.email, user.email);
    NewSession.save(PrefKeys.createdAt, user.createdAt);
    NewSession.save(PrefKeys.updatedAt, user.updatedAt);
    NewSession.save(PrefKeys.token, user.token);
    NewSession.save(PrefKeys.userTypeId, user.typeId);

    // -----------------------
    // UserInfo
    // -----------------------
    final info = user.userInfo;
    if (info != null) {
      NewSession.save(PrefKeys.phone, info.phoneNumber);
      NewSession.save(PrefKeys.identityNumber, info.identityNumber);
      //NewSession.save(PrefKeys.profileImage, info.profileImage);
      NewSession.save(PrefKeys.isVerified, info.isVerified);
    }

    // -----------------------
    // Influencer
    // -----------------------
    final infl = user.influencer;
    if (infl != null) {
      NewSession.save(PrefKeys.inflRating, infl.rating);
      NewSession.save(PrefKeys.inflBio, infl.bio);
      NewSession.save(PrefKeys.inflGender, infl.gender);
      NewSession.save(PrefKeys.inflShake, infl.shakeNumber);
      NewSession.save(PrefKeys.inflTypeId, infl.typeId);
      NewSession.save(PrefKeys.inflDob, infl.dateOfBirth);

      // Save social media links as JSON string
      if (infl.socialMediaLinks?.isNotEmpty??false) {
        final socialJson =
        jsonEncode(infl.socialMediaLinks?.map((e) => e.toJson()).toList());
        NewSession.save(PrefKeys.inflSocialLinks, socialJson);
      }

      // Save categories as JSON string
      if (infl.categories?.isNotEmpty??false) {
        final catJson = jsonEncode(infl.categories?.map((e) => e.toJson())
        .toList());
        NewSession.save(PrefKeys.inflCategories, catJson);
      }
    }

    // -----------------------
    // Client
    // -----------------------
    final client = user.client;
    if (client != null) {
      NewSession.save(PrefKeys.isHaveCr, client.isHaveCr);

      final cr = client.clientWithCr;
      if (cr != null) {
        NewSession.save(PrefKeys.regOwnerName, cr.regOwnerName);
        NewSession.save(PrefKeys.institutionName, cr.institutionName);
        NewSession.save(PrefKeys.branchAddress, cr.branchAddress);
        NewSession.save(PrefKeys.institutionAddress, cr.institutionAddress);
        NewSession.save(PrefKeys.rcNumber, cr.rcNumber);
        NewSession.save(PrefKeys.nisNumber, cr.nisNumber);
        NewSession.save(PrefKeys.nifNumber, cr.nifNumber);
        NewSession.save(PrefKeys.iban, cr.iban);
        NewSession.save(PrefKeys.imageOfLicense, cr.imageOfLicense);
      }

      final crWithout = client.clientWithoutCr;
      if (crWithout != null) {
        NewSession.save(PrefKeys.nickName, crWithout.nickname);
        NewSession.save(PrefKeys.identityImage, crWithout.identityImage);
      }
    }
  }

// Future<void> saveUserInfo(User data) async {
//   // Base
//   NewSession.save(PrefKeys. logged, "OK");
//   NewSession.save(PrefKeys.id, data.id);
//   NewSession.save(PrefKeys.name, data.name);
//   NewSession.save(PrefKeys.email, data.email);
//   NewSession.save(PrefKeys.createdAt, data.createdAt);
//   NewSession.save(PrefKeys.updatedAt,data.updatedAt);
//
//   //user info
//   NewSession.save(PrefKeys.phone, data.userInfo?.phoneNumber);
//   NewSession.save(PrefKeys.identityNumber, data.userInfo?.identityNumber);
//   NewSession.save(PrefKeys.profileImage, data.userInfo?.profileImage);
//   NewSession.save(PrefKeys.isVerified, data.userInfo?.isVerified);
//
//
//   // Save user type
// //  NewSession.save(PrefKeys.isHaveCr, data.client?.isHaveCr);
//
//   // If user is influencer
//   if (data.influencer != null) {
//     NewSession.save(PrefKeys.inflRating, data.influencer?.rating);
//     NewSession.save(PrefKeys.inflBio, data.influencer?.bio);
//     NewSession.save(PrefKeys.inflGender, data.influencer?.gender);
//     NewSession.save(PrefKeys.inflShake, data.influencer?.shakeNumber);
//     NewSession.save(PrefKeys.inflTypeId, data.influencer?.typeId);
//     NewSession.save(PrefKeys.inflDob, data.influencer?.dateOfBirth);
//     // Save Social links as JSON string
//
//
//     // Save categories as JSON string
//
//
//     // If user is client with CR
//     if (data.client?.clientWithCr != null) {
//       var cr = data.client?.clientWithCr;
//       NewSession.save(PrefKeys.regOwnerName, cr?.regOwnerName);
//       NewSession.save(PrefKeys.institutionName, cr?.institutionName);
//       NewSession.save(PrefKeys.branchAddress, cr?.branchAddress);
//       NewSession.save(PrefKeys.institutionAddress, cr?.institutionAddress);
//       NewSession.save(PrefKeys.rcNumber, cr?.rcNumber);
//       NewSession.save(PrefKeys.nisNumber, cr?.nisNumber);
//       NewSession.save(PrefKeys.nifNumber, cr?.nifNumber);
//       NewSession.save(PrefKeys.iban, cr?.iban);
//       NewSession.save(PrefKeys.imageOfLicense, cr?.imageOfLicense);
//     }
//   }
// }
//

void removeUserInfo() {
  final keys = [
  //  PrefKeys.userType,
    PrefKeys. logged,
    PrefKeys.id,
    PrefKeys.name,
    PrefKeys.nickName,
    PrefKeys.email,
    PrefKeys.phone,
    PrefKeys.isHaveCr,
    PrefKeys.identityNumber,
    PrefKeys.userTypeId,

    // influencer
    PrefKeys.inflRating,
    PrefKeys.inflBio,
    PrefKeys.inflGender,
    PrefKeys.inflShake,
    PrefKeys.inflTypeId,
    PrefKeys.inflDob,

    // client with CR
    PrefKeys.regOwnerName,
    PrefKeys.institutionName,
    PrefKeys.branchAddress,
    PrefKeys.institutionAddress,
    PrefKeys.rcNumber,
    PrefKeys.nisNumber,
    PrefKeys.rcNumber,
    PrefKeys.iban,
    PrefKeys.imageOfLicense,
    PrefKeys.inflSocialLinks,
    PrefKeys.inflCategories,
    PrefKeys.inflDob,

  ];

  for (var key in keys) {
    NewSession.remove(key);
  }
}

// saveUserInfoOfTeach(User data) {
//   NewSession.save(PrefKeys.logged", "OK");
//   // NewSession.save("token", data.token);
//   NewSession.save<int>("id", data.id);
//   // Session.save("profile", data.profile);
//   NewSession.save("name", data.name);
// }
//
// removeUserInfoOfTeach() {
//   NewSession.remove("logged");
//   NewSession.remove("token");
//   NewSession.remove("id");
//   // Session.remove("profile");
//   NewSession.remove("name");
// }
//
