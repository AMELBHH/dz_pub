import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownQuestionWidget extends ConsumerStatefulWidget {
  const CustomDropdownQuestionWidget(
      this.onSelected, {
        super.key,
        this.controller,
        required this.questionText,
        required this.hintText,
        this.selectedValue,
        required this.items,
        this.forRegistration = false
      });

  final String questionText;
  final String hintText;
  final String? selectedValue;
  final TextEditingController? controller;
  final List<DropdownMenuEntry<String>> items;
  final ValueChanged<String?> onSelected;
  final bool forRegistration;

  @override
  ConsumerState createState() => _CustomDropdownQuestionWidgetState();
}

class _CustomDropdownQuestionWidgetState
    extends ConsumerState<CustomDropdownQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    final themeColor =
    ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref);
    final containerColor =
    ref.read(themeModeNotifier.notifier).containerTheme(ref: ref);
    final textColor =
    ref.read(themeModeNotifier.notifier).textTheme(ref: ref);

    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.forRegistration)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          const SizedBox(height: 16),
          Text(widget.questionText, style: AppTextStyle.black19),
          const SizedBox(height: 12),
        ],),


        /// ---- DropdownMenu Styling (Matching your DropdownButtonFormField) ----
        DropdownMenu<String>(

          controller: widget.controller,
          width: MediaQuery.of(context).size.width * 0.9,
          hintText: widget.hintText,
          initialSelection: widget.selectedValue,
          dropdownMenuEntries: widget.items,
          // menuStyle: MenuStyle(
          //   backgroundColor:
          //   MaterialStateProperty.all(containerColor),
          //   shape: MaterialStateProperty.all(
          //     RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(7),
          //     ),
          //   ),
          // ),
          textStyle: TextStyle(

            color: textColor,
            fontSize: isSmallScreen ? 14 : 16,
          ),

          /// This matches your InputDecoration of the first dropdown
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(
              vertical: isSmallScreen ? 20 / 2.3 : 10,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5,
                color: ref
                    .read(themeModeNotifier.notifier)
                    .primary300Theme(ref: ref),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: themeColor,
                width: 1,
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          onSelected: widget.onSelected,
        ),
      ],
    );
  }
}
