class FileOfRecommendation {
  final int id;
  final int recommendationId;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  FileOfRecommendation({
    required this.id,
    required this.recommendationId,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileOfRecommendation.fromJson(Map<String, dynamic> json) {
    return FileOfRecommendation(
      id: json['id'],
      recommendationId: json['recommendation_id'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
