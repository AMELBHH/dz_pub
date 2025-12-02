import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/providers/color_provider.dart';

class TextFormFieldWidget extends ConsumerWidget {
  final String? labelName;
  final double? fontSize;
  final TextInputType? keyboardType;
  final Function? onFieldSubmitted;
  final bool? autoFocus;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String value)? onChanged;
  final String? errorText;
  final bool? isEmailRegTextField;
  final String? validateTextValue;
  final String? hintInput;
  final TextInputType? inputType;
  final int? hintMaxLines;
  final int? maxLines;
  final int? maxLength;
  final String? helperText;
  final String? originalValue;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final bool? autofocus;
  final InputDecoration? decoration;
  final TextStyle? style;
  final String? hintText;

  const TextFormFieldWidget(
      {super.key,
      this.labelName,
      this.keyboardType,
      this.fontSize,
      this.onFieldSubmitted,
      this.controller,
      this.autoFocus,
      this.validator,
      this.onChanged,
      this.errorText,
      this.isEmailRegTextField,
      this.validateTextValue,
      this.hintInput,
      this. inputType,
      this.hintMaxLines,
      this.maxLines,
      this.maxLength,
      this.helperText,
      this.originalValue,
      this.style,
      this.autofocus,
      this.cursorColor,
      this.decoration,
      this.textInputAction,
      this.hintText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: decoration != null ? 0 : 5,
      ),
      child: TextFormField(
          maxLines: maxLines,
          validator: validator,
          maxLength: maxLength    ,
          textInputAction: textInputAction,
          // textDirection:
          // isPhoneRegTextField ?? false
          //     ? TextDirection.ltr
          //     : TextDirection.rtl,
          controller: controller,
          autofocus: autoFocus ?? false,
          keyboardType: keyboardType,
          cursorColor: cursorColor,
          style: style ??
              defultTextStyle(
                ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
          decoration:

          decoration ??
              defultInputDecoration(
                hintMaxLines: hintMaxLines,
                ref: ref,
                hintText: hintText,
                context: context,
                enabledBorderColor: ref
                    .read(themeModeNotifier.notifier)
                    .primary300Theme(ref: ref),
                focusedBorderColor:
                    ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
              ),
          onChanged: onChanged),
    );
  }

  TextStyle defultTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 16,
    );
  }

  InputDecoration defultInputDecoration(
      {required BuildContext context,
      required Color enabledBorderColor,
      required Color focusedBorderColor,
        int? hintMaxLines,
      String? hintText,
    //ref widget
         required WidgetRef ref,
      }) {
    return InputDecoration(
      hintText: hintText,

      isDense: true,
      hintStyle: TextStyle(color: Colors.grey),
      // contentPadding: EdgeInsets. fromLTRB(12, 24, 12, 16),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      labelText: labelName,
      hintMaxLines: hintMaxLines,

      alignLabelWithHint: true,
      labelStyle: TextStyle(
        color: Colors.grey,
        fontSize: fontSize??14  ,
      ),
      border: OutlineInputBorder(borderSide:  BorderSide(
        color: ref.read(themeModeNotifier.notifier)
            .primary300Theme(ref: ref),
        width: 0.5,
      ),
        borderRadius: BorderRadius.circular(7),
      ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabledBorderColor,
            width: 0.5,
          ),
        ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: 1,
        ),
      ),
      // errorText: errorText,
      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 12.0,
      ),
      error: isEmailRegTextField ?? false
          ? (validateTextValue != null &&
                  validateTextValue !=
                      "no "
                          "error have"
              ? const SizedBox()
              : null)
          : (errorText != null
              ? Text(
                  errorText!,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12.0,
                  ),
                )
              : null),
    );
  }
}
