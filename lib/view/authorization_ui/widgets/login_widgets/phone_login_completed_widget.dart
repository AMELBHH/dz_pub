import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/containers_widgets/container_field_widget.dart';

class EmailLoginCompletedWidget extends ConsumerWidget {
  const EmailLoginCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formLoginEmailKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: ContainerFieldWidget(
          autoFocus: true,
          // errorText: ref.watch(formFieldsProvider)['phone']?.error,
          validator: (value) {
            return ref.read(formFieldsNotifier)['email']?.error;
          },
          // onChanged: (value){
          //
          //   ref.watch(formFieldsProvider)['phone']?.error;
          //   ref.watch(formFieldsProvider)['password']?.error;
          //
          // },
          hintMaxLines: 1,
          title:"الإيميل"
          //   SetLocalization.of(context)!.getTranslateValue("phone_number")
            ,
          controller: ref.read(emailLoginController),
          hintInput:"أدخل الإيميل الخاص بك"
          //     SetLocalization.of(context)!.getTranslateValue("enter_number_with_country_code")
          ,
          inputType: TextInputType.emailAddress,
        ),
      ),
    );
  }
}
