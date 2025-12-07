class TopicFromInfluencer {
  final int id;
  final String haveSample;
  final String detials;
  final int promationId;

  TopicFromInfluencer({
    required this.id,
    required this.haveSample,
    required this.detials,
    required this.promationId,
  });

  factory TopicFromInfluencer.fromJson(Map<String, dynamic> json) {
    return TopicFromInfluencer(
      id: json['id'],
      haveSample: json['have_smaple'],
      detials: json['detials'] ?? "",
      promationId: json['promation_id'],
    );
  }
}
