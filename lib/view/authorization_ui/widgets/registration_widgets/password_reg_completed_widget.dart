import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/text_form_field_widgets/text_form_filed_password_widget.dart';

class PasswordRegCompletedWidget extends ConsumerWidget {
  const PasswordRegCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: formRegPasswordKey,
          child: TextFormFiledPasswordWidget(

            validator: (value) {
              return ref
                  .watch(formFieldsNotifier)['passwordRegistration']
                  ?.error;
            },
            isObscure: ref.watch(isObscure),

            onObscureChanged: (newValue) {
              ref.read(isObscure.notifier).state = newValue;
            },
            controller: ref.read(passwordRegController),
            inputType: TextInputType.visiblePassword,
            labelInput:"كلمة المرور"
            //   SetLocalization.of(context)!.getTranslateValue("password")
            ,
            errorText:
                ref.watch(formFieldsNotifier)['passwordRegistration']?.error,
          ),
        ),
      ],
    );
  }
}
