class Registration {
  final int id;
  final int promationId;
  final String haveAForm;

  Registration({
    required this.id,
    required this.promationId,
    required this.haveAForm,
  });

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'],
      promationId: json['promation_id'],
      haveAForm: json['have_a_form'],
    );
  }
}
