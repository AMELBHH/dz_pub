class Movement {
  final int id;
  final String location;
  final int promationId;

  Movement({
    required this.id,
    required this.location,
    required this.promationId,
  });

  factory Movement.fromJson(Map<String, dynamic> json) {
    return Movement(
      id: json['id'],
      location: json['location'],
      promationId: json['promation_id'],
    );
  }
}
