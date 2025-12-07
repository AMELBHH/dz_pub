class Recommendation {
  final int id;
  final String text;
  final int promationId;

  Recommendation({
    required this.id,
    required this.text,
    required this.promationId,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      id: json['id'],
      text: json['text'] ?? "",
      promationId: json['promation_id'],
    );
  }
}
