class TypeOfPromotion {
  final int id;
  final int promationId;
  final int typeId;

  TypeOfPromotion({
    required this.id,
    required this.promationId,
    required this.typeId,
  });

  factory TypeOfPromotion.fromJson(Map<String, dynamic> json) {
    return TypeOfPromotion(
      id: json['id'],
      promationId: json['promation_id'],
      typeId: json['type_id'],
    );
  }
}
