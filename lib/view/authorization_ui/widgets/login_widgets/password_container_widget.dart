import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:dz_pub/view/common_widgets/containers_widgets/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';




class PasswordContainerWidget extends ConsumerWidget {
  final String title;
  final String hintInput;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final bool? isVisible;
  final bool isObscure;
  final bool? autoFocus;
  final Function? onFieldSubmitted;
  final Function(bool)? setPassword;
  final TextEditingController? controller;
  final void Function(bool) onObscureChanged;
  final String? Function(String?)? validator;
  final Function(String value)? onChanged;
  final String ? errorText;

  const PasswordContainerWidget(
      {super.key,
        required this.title,
        required this.isObscure,
        required this.hintInput,
        required this.inputType,
        this.focusNode,
        this.onFieldSubmitted,
        this.isVisible,
        this.autoFocus,
        this.controller,
        this.setPassword,
        required this.onObscureChanged,
        this.validator,
        this.onChanged,
        this.errorText});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // var focusNode = FocusNode();
    return ContainerWidget(child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                title,
                style: TextStyle(
                  color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                  fontSize:
                  getIt<AppDimension>().isSmallScreen(context) ? 16 : 18,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: TextFormField(
            obscureText: isObscure,
            keyboardType: inputType,
            enableSuggestions: false,
            autocorrect: false,
            autofocus: autoFocus ?? false,
            textInputAction: TextInputAction.next,
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
                errorBorder: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.red), // Set error border color
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0), // Set focused error border
                ),
                errorStyle: const TextStyle(color: Colors.red),
                // Customize error text style

                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 12,
                ),
                hintText: hintInput,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                  icon: isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () {
                    onObscureChanged(!isObscure);
                  },
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: ref.read(themeModeNotifier.notifier)
                          .primaryTheme(ref: ref,withOpacity: .3),
                    ),
                    borderRadius: BorderRadius.circular(7)),
                errorText: errorText),
            style: TextStyle(
                fontSize:
                getIt<AppDimension>().isSmallScreen(context) ? 15 : 16,
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref)),
          ),
        ),
      ],
    ));
  }
}
