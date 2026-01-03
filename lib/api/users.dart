import 'package:dz_pub/api/social_media.dart';
import 'package:dz_pub/api/report.dart';

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

  UserRes({required this.status, required this.msg, required this.data});

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

class User {
  int? id;
  String? name;
  String? email;
  int? typeId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  String? token; // <--- token inside User

  UserInfo? userInfo;
  Client? client;

  Influencer? influencer;

  List<Report>? reportsMade;
  List<Report>? reportsReceived;
  TypeOfUser? typeOfUser;

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
    this.token, // <--- add to constructor
    this.reportsMade,
    this.reportsReceived,
    this.typeOfUser,
  });

  User.fromJson(Map<String, dynamic> json, {this.token})
    : id = i(json['id']),
      name = s(json['name']),
      email = s(json['email']),
      typeId = i(json['type_id']),
      isActive = i(json['is_active']),
      createdAt = s(json['created_at']),
      updatedAt = s(json['updated_at']),
      userInfo = json['user_info'] != null
          ? UserInfo.fromJson(json['user_info'])
          : null,
      client = json['client'] != null ? Client.fromJson(json['client']) : null,
      influencer = json['influencer'] != null
          ? Influencer.fromJson(json['influencer'])
          : null,
      reportsMade = json['reports_made'] != null
          ? (json['reports_made'] as List)
                .map((e) => Report.fromJson(e))
                .toList()
          : [],
      reportsReceived = json['reports_received'] != null
          ? (json['reports_received'] as List)
                .map((e) => Report.fromJson(e))
                .toList()
          : [],
      typeOfUser = json['type_of_user'] != null
          ? TypeOfUser.fromJson(json['type_of_user'])
          : null;

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type_id": typeId,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "token": token, // <--- include token
    "user_info": userInfo?.toJson(),
    "client": client?.toJson(),
    "influencer": influencer?.toJson(),
    "reports_made": reportsMade?.map((e) => e.toJson()).toList(),
    "reports_received": reportsReceived?.map((e) => e.toJson()).toList(),
    "type_of_user": typeOfUser?.toJson(),
  };
}

class TypeOfUser {
  int? id;
  String? name;

  TypeOfUser({this.id, this.name});

  factory TypeOfUser.fromJson(Map<String, dynamic> json) {
    return TypeOfUser(id: i(json['id']), name: s(json['name']));
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class UserInfo {
  int? id;
  String? phoneNumber;
  String? identityNumber;
  String? profileImage;
  String? isVerified;
  int? userId;
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
    : id = i(json['id']),
      phoneNumber = s(json['phone_number']),
      identityNumber = s(json['identity_number']),
      //  profileImage = s(json['profile_image']),
      isVerified = s(json['is_verified']),
      userId = i(json['user_id']),
      createdAt = s(json['created_at']),
      updatedAt = s(json['updated_at']);

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
  int? id;
  String? isHaveCr;
  String? createdAt;
  String? updatedAt;

  UserMini? user;
  ClientWithCr? clientWithCr;
  ClientWithoutCr? clientWithoutCr;

  Client({
    this.id,
    this.isHaveCr,
    this.createdAt,
    this.updatedAt,
    this.clientWithCr,
    this.clientWithoutCr,
    this.user,
  });

  Client.fromJson(Map<String, dynamic> json)
    : id = i(json['id']),
      isHaveCr = s(json['is_have_cr']),
      createdAt = s(json['created_at']),
      updatedAt = s(json['updated_at']),
      clientWithCr = json['client_with_c_r'] != null
          ? ClientWithCr.fromJson(json['client_with_c_r'])
          : null,
      clientWithoutCr = json['client_without_c_r'] != null
          ? ClientWithoutCr.fromJson(json['client_without_c_r'])
          : null,
      user = json['user'] != null ? UserMini.fromJson(json['user']) : null;

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_have_cr": isHaveCr,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "client_with_c_r": clientWithCr?.toJson(),
    "client_without_c_r": clientWithoutCr?.toJson(),
    "user": user?.toJson(),
  };
}

class ClientWithoutCr {
  int? id;
  int? clientId;
  String? nickname;
  String? identityImage;
  String? createdAt;
  String? updatedAt;

  ClientWithoutCr({
    this.id,
    this.clientId,
    this.nickname,
    this.identityImage,
    this.createdAt,
    this.updatedAt,
  });

  ClientWithoutCr.fromJson(Map<String, dynamic> json)
    : id = i(json['id']),
      clientId = i(json['client_id']),
      nickname = s(json['nickname']),
      identityImage = s(json['identity_image']),
      createdAt = s(json['created_at']),
      updatedAt = s(json['updated_at']);

  Map<String, dynamic> toJson() => {
    "id": id,
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
  final String? createdAt;
  final String? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  factory ClientWithCr.fromJson(Map<String, dynamic> json) {
    return ClientWithCr(
      clientId: i(json['client_id']),
      regOwnerName: s(json['reg_owner_name']),
      institutionName: s(json['institution_name']),
      branchAddress: s(json['branch_address']),
      institutionAddress: s(json['institution_address']),
      rcNumber: s(json['rc_number']),
      nisNumber: s(json['nis_number']),
      nifNumber: s(json['nif_number']),
      iban: s(json['iban']),
      imageOfLicense: s(json['image_of_license']),
      createdAt: s(json['created_at']),
      updatedAt: s(json['updated_at']),
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
      'created_at': createdAt,
      'updated_at': updatedAt,
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

  UserMini? user;
  final List<SocialMediaLink>? socialMediaLinks;
  final List<Category>? categories;
  final TypeOfInfluencer? typeOfInfluencer;

  Influencer({
    this.rating,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.shakeNumber,
    this.typeId,
    this.user,
    this.socialMediaLinks = const [],
    this.categories = const [],
    this.typeOfInfluencer,
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
      user: json['user'] != null ? UserMini.fromJson(json['user']) : null,
      socialMediaLinks: json['social_media_links'] != null
          ? (json['social_media_links'] as List)
                .map((e) => SocialMediaLink.fromJson(e))
                .toList()
          : [],
      categories: json['categories'] != null
          ? (json['categories'] as List)
                .map((e) => Category.fromJson(e))
                .toList()
          : [],
      typeOfInfluencer: json['type_of_influencer'] != null
          ? TypeOfInfluencer.fromJson(json['type_of_influencer'])
          : null,
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
      'user': user?.toJson(),
      'social_media_links': socialMediaLinks?.map((e) => e.toJson()).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
      'type_of_influencer': typeOfInfluencer?.toJson(),
    };
  }
}

class TypeOfInfluencer {
  final int? id;
  final String? name;

  TypeOfInfluencer({this.id, this.name});

  factory TypeOfInfluencer.fromJson(Map<String, dynamic> json) {
    return TypeOfInfluencer(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class UserMini {
  int? id;
  String? name;
  String? email;
  int? typeId;
  int? isActive;

  UserMini({this.id, this.name, this.email, this.typeId, this.isActive});

  factory UserMini.fromJson(Map<String, dynamic> json) {
    return UserMini(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      typeId: json['type_id'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type_id": typeId,
    "is_active": isActive,
  };
}
