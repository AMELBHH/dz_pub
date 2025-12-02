import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';
import '../../../controllers/auth/providers/color_provider.dart';

class TextFormFiledPasswordWidget extends ConsumerStatefulWidget {
  const TextFormFiledPasswordWidget(
      {super.key,
      this.inputType,
      this.labelInput,
      this.onFieldSubmitted,
      this.focusNode,
      this.autoFocus,
      this.checkPass,
      this.controller,
      required this.isObscure,
      required this.onObscureChanged,
      this.validator,
      this.helperText,
      this.errorText});

  final TextInputType? inputType;
  final Function? onFieldSubmitted;
  final String? labelInput;
  final FocusNode? focusNode;
  final bool? autoFocus;

  //late  String? displayText;
  final Function(String)? checkPass;

  // late  double? strength;
  final bool isObscure;
  final String? Function(String?)? validator;

  final void Function(bool) onObscureChanged;
  final TextEditingController? controller;
  final String? helperText;
  final String? errorText;

  @override
  ConsumerState createState() => _TextFormFiledPasswordWidgetState();
}

class _TextFormFiledPasswordWidgetState
    extends ConsumerState<TextFormFiledPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.isObscure,
          style: TextStyle(
            fontSize: 16,
              color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref)),
          keyboardType: widget.inputType,
          decoration: InputDecoration(
            errorText: widget.errorText,
            contentPadding: EdgeInsets.symmetric(
                vertical:15,
                    // getIt<AppDimension>().isSmallScreen(context) ? 20 / 1.5 :
                    // 20,
                horizontal: 10),
            labelText: widget.labelInput,
            labelStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
            ),
            suffixIcon: IconButton(
              iconSize: getIt<AppDimension>().isSmallScreen(context) ? 20 : 24,
              icon: widget.isObscure
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              onPressed: () {
                setState(() {
                  widget.onObscureChanged(!widget.isObscure);
                });
              },
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color:
                    ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
              ),
            ),

            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0.5,
                  color: ref
                      .read(themeModeNotifier.notifier)
                      .primary300Theme(ref: ref),
                ),
                borderRadius: BorderRadius.circular(7)),
            helperText: widget.helperText,
            errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.red), // Set error border color
            ),

            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, width: 2.0), // Set focused error border
            ),
            errorStyle: const TextStyle(
                color: Colors.red), // Customize error text style
          ),
        ));
  }
}
