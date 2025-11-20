import 'package:flutter/material.dart';

class TextFieldwidget extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffixIcon;

  const TextFieldwidget({
    super.key,
    required this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.maxLines,
    this.suffixIcon,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: maxLines,

      decoration: InputDecoration(
        // labelText: 'عنوان الحضور',
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      ),
    );
  }
}


