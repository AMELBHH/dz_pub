class CustomPromotion {
  final int clientId;
  final String text;

  CustomPromotion({
    required this.clientId,
    required this.text,
  });

  factory CustomPromotion.fromJson(Map<String, dynamic> json) {
    return CustomPromotion(
      clientId: json['client_id'],
      text: json['text'],
    );
  }
}
