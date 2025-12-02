


import 'package:dz_pub/api/social_media.dart';

import 'categories.dart';
T? cast<T>(dynamic value) => value is T ? value : null;

String s(dynamic v) => v?.toString() ?? '';
int? i(dynamic v) => v is int ? v : int.tryParse(v?.toString() ?? '');
double? d(dynamic v) => v is double ? v : double.tryParse(v?.toString() ?? '');
bool b(dynamic v) => v == true || v == 1 || v == '1';

class UserRes {
  final bool status;
  final String msg;
  final User? data;

  UserRes({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory UserRes.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] ?? {};

    return UserRes(
      status: json['status'] == true,
      msg: s(json['msg']),
      data: dataJson['user'] != null
          ? User.fromJson(dataJson['user'], token: s(dataJson['token']))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data?.toJson(),
  };
}


class   User {
  int? id;
  String? name;
  String?    email;
  int? typeId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  String? token; // <--- token inside User

  UserInfo? userInfo;
  Client? client;

  Influencer? influencer;

  User({
    this.id,
    this.name,
    this.email,
    this.typeId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.userInfo,
    this.client,
    this.influencer,
    this.token,        // <--- add to constructor
  });

  User.fromJson(Map<String, dynamic> json, {String? token})
      : id = json['id'] ,
        name = json['name'] ,
        email = json['email'] ,
        typeId = json['type_id'] ,
        isActive = json['is_active'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        userInfo = json['user_info'] != null
            ? UserInfo?.fromJson(json['user_info'])
            : null,
        client = json['client'] != null
            ? Client?.fromJson(json['client'])
            : null,
        influencer = json['influencer']!= null ? Influencer?.fromJson
          (json['influencer']) : null,
        token = token;                // <--- store token

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type_id": typeId,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "token": token,                // <--- include token
    "user_info": userInfo?.toJson(),
    "client": client?.toJson(),
    "influencer": influencer?.toJson(),
  };
}


class   UserInfo {
  int ?id;
    String? phoneNumber;
  String? identityNumber;
  String? profileImage;
  String? isVerified;
  int ?userId;
  String? createdAt;
  String? updatedAt;

  UserInfo({
     this.id,
    this.phoneNumber,
    this.identityNumber,
    this.profileImage,
    this.isVerified,
     this.userId,
    this.createdAt,
    this.updatedAt,
  });

  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phoneNumber = json['phone_number'],
        identityNumber = json['identity_number'],
      //  profileImage = json['profile_image'],
        isVerified = json['is_verified'],
        userId = json['user_id'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "phone_number": phoneNumber,
    "identity_number": identityNumber,
   // "profile_image": profileImage,
    "is_verified": isVerified,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class Client {
  int ?id;
  String ?isHaveCr;
  String? createdAt;
  String? updatedAt;

  ClientWithCr? clientWithCr;
  ClientWithoutCr? clientWithoutCr;

  Client({
     this.id,
     this.isHaveCr,
    this.createdAt,
    this.updatedAt,
    this.clientWithCr,
    this.clientWithoutCr,
  });

  Client.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isHaveCr = json['is_have_cr'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        clientWithCr = json['client_with_cr'] != null
            ? ClientWithCr?.fromJson(json['client_with_cr'])
            : null,
        clientWithoutCr = json['client_without_cr'] != null
            ? ClientWithoutCr?.fromJson(json['client_without_cr'])
            : null;

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_have_cr": isHaveCr,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "client_with_cr": clientWithCr?.toJson(),
    "client_without_cr": clientWithoutCr?.toJson(),
  };
}
class ClientWithoutCr {
  int ?clientId;
  String ?nickname;
  String? identityImage;
  String? createdAt;
  String? updatedAt;

  ClientWithoutCr({
     this.clientId,
     this.nickname,
    this.identityImage,
    this.createdAt,
    this.updatedAt,
  });

  ClientWithoutCr.fromJson(Map<String, dynamic> json)
      : clientId = json['client_id'],
        nickname = json['nickname'],
        identityImage = json['identity_image'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "nickname": nickname,
    "identity_image": identityImage,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
class ClientWithCr {
  final int? clientId;
  final String? regOwnerName;
  final String? institutionName;
  final String? branchAddress;
  final String? institutionAddress;
  final String? rcNumber;
  final String? nisNumber;
  final String? nifNumber;
  final String? iban;
  final String? imageOfLicense;

  ClientWithCr({
    this.clientId,
    this.regOwnerName,
    this.institutionName,
    this.branchAddress,
    this.institutionAddress,
    this.rcNumber,
    this.nisNumber,
    this.nifNumber,
    this.iban,
    this.imageOfLicense,
  });

  factory ClientWithCr.fromJson(Map<String, dynamic> json) {
    return ClientWithCr(
      clientId: json['client_id'],
      regOwnerName: json['reg_owner_name'],
      institutionName: json['institution_name'],
      branchAddress: json['branch_address'],
      institutionAddress: json['institution_address'],
      rcNumber: json['rc_number'],
      nisNumber: json['nis_number'],
      nifNumber: json['nif_number'],
      iban: json['iban'],
      imageOfLicense: json['image_of_license'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'reg_owner_name': regOwnerName,
      'institution_name': institutionName,
      'branch_address': branchAddress,
      'institution_address': institutionAddress,
      'rc_number': rcNumber,
      'nis_number': nisNumber,
      'nif_number': nifNumber,
      'iban': iban,
      'image_of_license': imageOfLicense,
    };
  }
}
class Influencer {
  final double? rating;
  final String? bio;
  final String? gender;
  final String? dateOfBirth;
  final String? shakeNumber;
  final int? typeId;



  final List<SocialMediaLink>? socialMediaLinks;
  final List<Category>? categories;

  Influencer({
    this.rating,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.shakeNumber,
    this.typeId,
    this.socialMediaLinks = const [],
    this.categories = const [],
  });

  factory Influencer.fromJson(Map<String, dynamic> json) {
    return Influencer(
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      bio: json['bio'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      shakeNumber: json['shake_number'],
      typeId: json['type_id'],

      // NEW
      socialMediaLinks: json['social_media_links'] != null
          ? (json['social_media_links'] as List)
          .map((e) => SocialMediaLink?.fromJson(e))
          .toList()
          : [],

      categories: json['categories'] != null
          ? (json['categories'] as List)
          .map((e) => Category?.fromJson(e))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'bio': bio,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'shake_number': shakeNumber,
      'type_id': typeId,

      // NEW
      'social_media_links':
      socialMediaLinks?.map((e) => e.toJson()).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
    };
  }
}

