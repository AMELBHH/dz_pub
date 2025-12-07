import 'package:dz_pub/api/promations_models/recommendation.dart';
import 'package:dz_pub/api/promations_models/registration.dart';
import 'package:dz_pub/api/promations_models/social_media_type.dart';
import 'package:dz_pub/api/promations_models/topic_already_ready.dart';
import 'package:dz_pub/api/promations_models/topic_from_influencer.dart';
import 'package:dz_pub/api/promations_models/type_of_promotion.dart';

import 'movement.dart';

class PromotionResponse {
  final bool status;
  final Promotion promotion;

  PromotionResponse({
    required this.status,
    required this.promotion,
  });

  factory PromotionResponse.fromJson(Map<String, dynamic> json) {
    return PromotionResponse(
      status: json['status'],
      promotion: Promotion.fromJson(json['promotion']),
    );
  }
}

class Promotion {
  final int? id;
  final int? clientId;
  final int? influencerId;
  final String? requirements;
  final int ?statusId;
  final double?price;
  final String?timeLine;
  final String?shouldInfluencerMovement;
  final String?createdAt;
  final String?updatedAt;

  // LISTS
  final List<_SocialMedia>? socialMedia;
  final List<SocialMediaType> ?socialMediaTypes;
  final List<TypeOfPromotion> ?typeOfPromotions;

  // CONDITIONAL FIELDS
  final Movement? movement;
  final Registration? registration;

  final List<Recommendation>? recommendations;

  final List<TopicFromInfluencer>? topicFromInfluancers;
  final List<TopicAlreadyReady>? topicAlreadyReadies;

  Promotion({
     this.id,
     this.clientId,
     this.influencerId,
     this.requirements,
     this.statusId,
     this.price,
     this.timeLine,
     this.shouldInfluencerMovement,
     this.createdAt,
     this.updatedAt,
     this.socialMedia,
     this.socialMediaTypes,
     this.typeOfPromotions,
    this.movement,
    this.registration,
    this.recommendations,
    this.topicFromInfluancers,
    this.topicAlreadyReadies,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      clientId: json['client_id'],
      influencerId: json['influencer_id'],
      requirements: json['requirements'] ?? "",
      statusId: json['status_id'],
      price: double.tryParse(json['price'].toString()) ?? 0,
      timeLine: json['time_line'],
      shouldInfluencerMovement: json['should_influencer_movment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],

      socialMedia: (json['social_media'] as List)
          .map((e) => _SocialMedia.fromJson(e))
          .toList(),

      socialMediaTypes: (json['social_media_types'] as List)
          .map((e) => SocialMediaType.fromJson(e))
          .toList(),

      typeOfPromotions: (json['type_of_promations'] as List)
          .map((e) => TypeOfPromotion.fromJson(e))
          .toList(),

      // Conditional (null if not exists)
      movement: json['movement'] != null
          ? Movement.fromJson(json['movement'])
          : null,

      registration: json['regstration'] != null
          ? Registration.fromJson(json['regstration'])
          : null,

      recommendations: json['recommendations'] != null
          ? (json['recommendations'] as List)
          .map((e) => Recommendation.fromJson(e))
          .toList()
          : null,

      topicFromInfluancers: json['topic_from_influancers'] != null
          ? (json['topic_from_influancers'] as List)
          .map((e) => TopicFromInfluencer.fromJson(e))
          .toList()
          : null,

      topicAlreadyReadies: json['topic_already_readies'] != null
          ? (json['topic_already_readies'] as List)
          .map((e) => TopicAlreadyReady.fromJson(e))
          .toList()
          : null,
    );
  }
}
class _SocialMedia {
  final int id;
  final int promationId;
  final int socialMediaId;

  _SocialMedia({
    required this.id,
    required this.promationId,
    required this.socialMediaId,
  });

  factory _SocialMedia.fromJson(Map<String, dynamic> json) {
    return _SocialMedia(
      id: json['id'],
      promationId: json['promation_id'],
      socialMediaId: json['social_media_id'],
    );
  }
}