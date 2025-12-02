class SocialMediaResponse {
  final String ?message;
  final List<SocialMediaLink>? links;

  SocialMediaResponse({
     this.message,
     this.links,
  });

  factory SocialMediaResponse.fromJson(Map<String, dynamic> json) {
    return SocialMediaResponse(
      message: json['message'],
      links: (json['social_media_links'] as List)
          .map((item) => SocialMediaLink.fromJson(item))
          .toList(),
    );
  }
}
class SocialMediaLink {
  final int ?id;
  final int ?influencerId;
  final int ?socialMediaId;
  final String? url;
  final DateTime ?createdAt;
  final DateTime ?updatedAt;

  SocialMediaLink({
     this.id,
     this.influencerId,
     this.socialMediaId,
     this.url,
     this.createdAt,
     this.updatedAt,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: json['id'],
      influencerId: json['influencer_id'],
      socialMediaId: json['social_media_id'],
      url: json['url_of_soical'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
extension SocialMediaLinkJson on SocialMediaLink {
  Map<String, dynamic> toJson() => {
    'id': id,
    'influencer_id': influencerId,
    'social_media_id': socialMediaId,
    'url_of_soical': url,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
