class TopicAlreadyReady {
  final int id;
  final int promationId;
  final String filePath;
  final String createdAt;

  TopicAlreadyReady({
    required this.id,
    required this.promationId,
    required this.filePath,
    required this.createdAt,
  });

  factory TopicAlreadyReady.fromJson(Map<String, dynamic> json) {
    return TopicAlreadyReady(
      id: json['id'],
      promationId: json['promation_id'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
    );
  }
}
