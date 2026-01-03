import 'package:dz_pub/api/users.dart';

class CustomPromotion {
  final int? id;
  final int? clientId;
  final String? text;
  final String? createdAt;
  final String? updatedAt;
  final Client? client;

  CustomPromotion({
    this.id,
    this.clientId,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.client,
  });

  factory CustomPromotion.fromJson(Map<String, dynamic> json) {
    return CustomPromotion(
      id: json['id'],
      clientId: json['client_id'],
      text: json['text'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
    );
  }
}
