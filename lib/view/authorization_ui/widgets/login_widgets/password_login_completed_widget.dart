import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/view/authorization_ui/widgets/login_widgets/password_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PasswordLoginCompletedWidget extends ConsumerWidget {
  const PasswordLoginCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formLoginPasswordKey,
      child: PasswordContainerWidget(
        inputType: TextInputType.visiblePassword,
        validator: (value){
          return ref.watch(formFieldsNotifier)['password']?.error;
        },


        // isVisible: true,
        onObscureChanged: (newValue) {
          // setState(() {

          ref.read(isObscure.notifier).state = newValue;
          // });
        },
        isObscure: ref.watch(isObscure),

        hintInput: "أدخل كلمة المرور"
          ///SetLocalization.of(context)!.getTranslateValue("your_password")
          ,
        title:"المرور كلمة "
          //SetLocalization.of(context)!.getTranslateValue("password")
          ,

        controller: ref.read(passwordLoginController),
        errorText: ref.watch(formFieldsNotifier)['password']?.error,
      ),
    );
  }
}
