class SocialMediaResponse {
  final String? message;
  final List<SocialMediaLink>? links;

  SocialMediaResponse({this.message, this.links});

  factory SocialMediaResponse.fromJson(Map<String, dynamic> json) {
    return SocialMediaResponse(
      message: json['message'],
      links: (json['social_media_links'] as List)
          .map((item) => SocialMediaLink.fromJson(item))
          .toList(),
    );
  }
}

class SocialMedia {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  SocialMedia({this.id, this.name, this.createdAt, this.updatedAt});

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class SocialMediaLink {
  final int? id;
  final int? influencerId;
  final int? socialMediaId;
  final String? urlOfSoical;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SocialMedia? socialMedia;

  SocialMediaLink({
    this.id,
    this.influencerId,
    this.socialMediaId,
    this.urlOfSoical,
    this.createdAt,
    this.updatedAt,
    this.socialMedia,
  });

  String? get url => urlOfSoical;

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: json['id'],
      influencerId: json['influencer_id'],
      socialMediaId: json['social_media_id'],
      urlOfSoical: json['url_of_soical'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      socialMedia: json['social_media'] != null
          ? SocialMedia.fromJson(json['social_media'])
          : null,
    );
  }
}

extension SocialMediaLinkJson on SocialMediaLink {
  Map<String, dynamic> toJson() => {
    'id': id,
    'influencer_id': influencerId,
    'social_media_id': socialMediaId,
    'url_of_soical': urlOfSoical,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'social_media': socialMedia?.toJson(),
  };
}
