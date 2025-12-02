// import 'dart:html';

import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:dz_pub/view/common_widgets/containers_widgets/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';
import '../text_form_field_widgets/text_form_filed_widget.dart';

//container input text class widget
class ContainerFieldWidget extends ConsumerWidget {
  final String title;
  final String hintInput;
  final TextInputType inputType;
  final String? errorText;
  final int? hintMaxLines;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;
  final String? helperText;
  final bool? autoFocus;
  final TextEditingController? controller;
  final String? originalValue;

  const ContainerFieldWidget(
      {super.key,
      required this.title,
      required this.hintInput,
      required this.inputType,
      this.maxLines,
      this.hintMaxLines,
      this.maxLength,
      this.autoFocus,
      this.controller,
      this.errorText,
      this.validator,
      this.helperText,
      this.originalValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContainerWidget(
        child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                title,
                style: TextStyle(
                  color:
                      ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                  fontSize:
                      getIt<AppDimension>().isSmallScreen(context) ? 16 : 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: TextFormFieldWidget(

            onChanged: (value) {
              bool hasChange = originalValue != controller?.text;
              if (value.isNotEmpty) {
                if (hasChange) {
                  ref.read(hasChanged.notifier).state = true;
                } else {
                  ref.read(hasChanged.notifier).state = false;
                }
              } else {
                ///should show the validate message when the field is empty
              }
            },
            validator: validator,
            cursorColor:
                ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
            textInputAction: TextInputAction.next,
            controller: controller,
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: inputType,

            autofocus: autoFocus ?? false,
            decoration: containerInputDecoration(hintInput, context,
                helperText: helperText,
                textColor:
                    ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                foucsBorderColor:
                    ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
                unFoucsBorderColor: ref
                    .read(themeModeNotifier.notifier)
                    .primary300Theme(ref: ref)),
            style: TextStyle(
              fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
              color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
            ),
          ),
        ),
      ],
    ));
  }

  InputDecoration containerInputDecoration(
      String hintInput, BuildContext context,
      {String? helperText,
      required Color textColor,
      required Color foucsBorderColor,
      required Color unFoucsBorderColor}) {
    return InputDecoration(
        helperStyle: TextStyle(color: textColor, fontFamily: "Cairo"),
        helperText: helperText,

        contentPadding: EdgeInsets.symmetric(
            vertical:
               15,
            horizontal: 12),
        errorText: errorText,
        hintText: hintInput,
        border: InputBorder.none,
        hintMaxLines: hintMaxLines,

        hintStyle: const TextStyle(

          color: Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: foucsBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: unFoucsBorderColor,
            ),
            borderRadius: BorderRadius.circular(7)),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Set error border color
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red, width: 2.0), // Set focused error border
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        helperMaxLines: 2);
  }
}
final hasChanged = StateProvider<bool>((ref) => false);
