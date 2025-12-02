import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/view/common_widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';
import '../../../common_widgets/text_form_field_widgets/text_form_filed_widget.dart';

class EmailCompletedWidget extends ConsumerWidget {
  const EmailCompletedWidget({
    super.key,
    this.validateValue,
    this.isEmailRegTextField,
    this.controller,
    this.hasContainer,
  });

  final String? validateValue;
  final bool? isEmailRegTextField;
  final TextEditingController? controller;
  final bool? hasContainer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hasContainer ?? false
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "الإيميل",
                      //   SetLocalization.of(context)!.getTranslateValue("phone_number"),
                      style: TextStyle(
                        color: ref
                            .read(themeModeNotifier.notifier)
                            .textTheme(ref: ref),
                        fontSize: getIt<AppDimension>().isSmallScreen(context)
                            ? 16
                            : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: EmailFormWidget(
                hasContainer: hasContainer,
                validateTextValue: validateValue,
                controller: controller,
                isEmailRegTextField: isEmailRegTextField,
              ),
            ),

          ],
        ),
        // const Spacer(),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [CustomErrorText(validateValue ?? "")],
          ),
        ),
      //  const ButtonCheckerPhoneNumberCompletedWidget(),
        SizedBox(
          height: getIt<AppDimension>().isSmallScreen(context) ? 10 : 20,
        ),
      ],
    );
  }
}

//custom error text widget
class CustomErrorText extends ConsumerWidget {
  const CustomErrorText(this.validateErrorValue, {super.key});

  final String validateErrorValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return validateErrorValue != "" && validateErrorValue != "no error have"
        ? Text(
            validateErrorValue,
            softWrap: true,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12.0,
            ),
          )
        : const SizedBox();
  }
}

//dropdown menu widget
class DropDownMenuWidget extends ConsumerWidget {
  const DropDownMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownFieldWidget(

      horizantalPadding: 0,
        isStringOnly: true,
        onChanged: (newValue) {
          ref.read(selectedCountryCode.notifier).state = newValue!;
        },
        items: ref.watch(countriesCodes));
  }
}

//phone number widget
class EmailFormWidget extends ConsumerWidget {
  const EmailFormWidget(
      {super.key,
      this.controller,
      this.isEmailRegTextField,
      this.validateTextValue,
      this.hasContainer});

  final TextEditingController? controller;
  final bool? hasContainer;
  final bool? isEmailRegTextField;
  final String? validateTextValue;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return TextFormFieldWidget(

      validateTextValue: validateTextValue,
      isEmailRegTextField: isEmailRegTextField ?? true,
      fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
      controller: controller,
      labelName: hasContainer ?? false
          ? null
          :
      "الإيميل",
      // SetLocalization.of(context)!.getTranslateValue("phone_number"),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
