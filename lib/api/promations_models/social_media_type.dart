class SocialMediaType {
  final int id;
  final int promationId;
  final int typeId;

  SocialMediaType({
    required this.id,
    required this.promationId,
    required this.typeId,
  });

  factory SocialMediaType.fromJson(Map<String, dynamic> json) {
    return SocialMediaType(
      id: json['id'],
      promationId: json['promation_id'],
      typeId: json['type_id'],
    );
  }
}
