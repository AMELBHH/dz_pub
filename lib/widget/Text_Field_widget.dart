import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.maxLength,
    this.prefixIcon,
    this.maxLines,
    this.suffixIcon,
    required this.textInputType,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black87),
      keyboardType: textInputType,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
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


