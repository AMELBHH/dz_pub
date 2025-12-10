import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ween_blaqe/constants/strings.dart';
// import 'package:ween_blaqe/core/utils/funcations/route_pages/push_routes.dart';
// import 'package:ween_blaqe/features/statuses/validate_text_form_field_state.dart';

import '../../../../providers/auth_provider.dart';
/// a [validateAndLogin] method is only usage in [LoginUi] screen.
void    validateAndLogin(WidgetRef ref, BuildContext context) async {
  // bool isValid = ref.read(formFieldsProvider.notifier).validateAllFields();
  // final phone = ref.read(formFieldsProvider)['phone']?.value ?? "";

  ref.refresh(formFieldsNotifier)['email']?.error ??
      "no error"; // this check phone
  // value then make refresh , that to check have error

  ref.refresh(formFieldsNotifier)['password']?.error ??
      "no error"; //// this check
// password
  // value then make refresh , that to check have error
///a value for both phone and password Controllers
  String emailControllerValue = ref.read(emailLoginController).text;
  String passwordControllerValue = ref.read(passwordLoginController).text;
/// a form state for both email and password validates
  bool? formPhoneState = formLoginEmailKey.currentState?.validate();
  bool? formPasswordState = formLoginPasswordKey.currentState?.validate();
  ///an [updateValue] method
  ref
      .read(formFieldsNotifier.notifier)
      .updateValue("email", emailControllerValue,context: context);
  ref
      .read(formFieldsNotifier.notifier)
      .updateValue("password", passwordControllerValue,context: context);

  ///   both [errorEmail] and [errorPassword]created to return error
  /// text 'if-exists'
  String errorEmail =
      ref.read(formFieldsNotifier)["email"]?.error ?? "no error have";
  String errorPassword = ref.read(formFieldsNotifier)["password"]?.error ??
     "no error have";

  /// that when [updateValue] method work that should to check that if
  /// [textFieldState] return an error value that if any of [errorEmail] or
  /// [errorPassword] then run the formKey of TextFormField widget.
  if (errorEmail != "no error have") {
    debugPrint("formPhoneState is $formPhoneState");
    formLoginEmailKey.currentState?.validate();
    return;
  }
  if (errorPassword != "no error have") {
    debugPrint("formPasswordState is $formPasswordState");
    formLoginPasswordKey.currentState?.validate();
    return;
  }
  debugPrint("no error validate from local you have ");
  /// here will [login] method run if no error have.
  await ref
      .read(loginNotifier.notifier)
      .login(emailControllerValue, passwordControllerValue, ref,context);



  if (errorEmail != "no error have" || errorPassword != "no error have") {
    return;
  }

  // Navigator.pushReplacementNamed(context, MyPagesRoutes.main);
  }
