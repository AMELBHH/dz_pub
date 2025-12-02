// dynamic_field.dart
class DynamicFieldOption {
  final String id; // server id (string)
  final String label;
  DynamicFieldOption({required this.id, required this.label});
}

class DynamicField {
  final String id; // server field name, eg "category_ids" or "iban"
  final String type; // "text", "number", "email", "dropdown", "multiselect", "file", "array"
  final String label;
  final bool required;
  final List<DynamicFieldOption>? options;
  final bool arrayItemIsObject; // if array of objects (complex), else array of single values

  DynamicField({
    required this.id,
    required this.type,
    required this.label,
    this.required = false,
    this.options,
    this.arrayItemIsObject = false,
  });
}
