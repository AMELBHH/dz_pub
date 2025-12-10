import 'package:dz_pub/api/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// import '../../../features/statuses/validate_text_form_field_state.dart';
import '../../../../providers/auth_provider.dart';

Future<void> validateAndRegistration(
    WidgetRef ref, BuildContext context) async {

  ref.refresh(formFieldsNotifier)['emailRegistration']?.error ??
      "no error"; // this check phone
  // value then make refresh , that to check have error
  ref.refresh(formFieldsNotifier)['passwordRegistration']?.error ??
      "no error"; //// this check
// password
  // value then make refresh , that to check have error
  ref.refresh(formFieldsNotifier)['username']?.error ?? "no error";
  String emailControllerValue = ref.read(emailController).text;
  String passwordControllerValue = ref.read(passwordRegController).text;
  String userNameControllerValue = ref.read(userNameController).text;
  ref.read(dropdownProvider);
  ref.read(selectedCountryCode);
  bool? formPhoneState = formPhoneKey.currentState?.validate();
  bool? formPasswordState = formRegPasswordKey.currentState?.validate();
  bool? formUsernameState = formUsernameKey.currentState?.validate();

  // emailControllerValue = await newRemovePlusSymbol(
  //     ref: ref,
  //     codeCountry: selectedCountryCodeValue,
  //     phoneNumber: emailControllerValue);
  ref.read(formFieldsNotifier.notifier).updateValue(
      "emailRegistration", emailControllerValue,
      context: context);
  ref.read(formFieldsNotifier.notifier).updateValue(
      "passwordRegistration", passwordControllerValue,
      context: context);
  ref
      .read(formFieldsNotifier.notifier)
      .updateValue("username", userNameControllerValue, context: context);
  String errorPhone =
      ref.read(formFieldsNotifier)["emailRegistration"]?.error ??
          "no error have";
  String errorPassword =
      ref.read(formFieldsNotifier)["passwordRegistration"]?.error ??
          "no error have";
  String errorUsername = ref.read(formFieldsNotifier)["username"]?.error ??
      "no"
          " error have";
  if (errorUsername != "no error have") {
    formUsernameState;
    return;
  }
  if (errorPhone != "no error have") {
    // debugPrint("formPhoneState is $formPhoneState");
    if (errorPassword == "fill_field") {
      // debugPrint("phone number error is aaa : $errorPhone");
    }
    debugPrint(errorPhone);
    formPhoneState;
    return;
  }

  if (errorPassword != "no error have") {
    formPasswordState;
    return;
  }
  // debugPrint("no error validate from local you have ");
  await ref.read(registerNotifier.notifier).register(
   ref,
  context,
    name: userNameControllerValue,
    email: emailControllerValue,
    password: passwordControllerValue,

   // typeId: typeOfUserValue,


     );
  await ref.read(getUserTypeNotifier.notifier).getUserType();
    await ref.read(registerNotifier.notifier).completeProfile(
    phone:ref.read(phoneController.notifier).state.text,
    identityNumber: ref.read(identityNumberController.notifier).state.text,
    nickname: ref.read(nicknameController.notifier).state.text,
    regOwnerName : ref.read(regOwnerNameController.notifier).state.text,
    institutionName : ref.read(institutionNameController.notifier).state.text,
    branchAddress   : ref.read(branchAddressController.notifier).state.text,
    institutionAddress : ref.read(institutionAddressController.notifier).state.text,
    rcNumber : ref.read(rcNumberController.notifier).state.text,
    nisNumber : ref.read(nisNumberController.notifier).state.text,
    iban : ref.read(ibanController.notifier).state.text,
    typeOfInfluencer : ref.read(typeOfInfluencerProvider),
   categoryIds: ref.read(categoryIdsProvider.notifier).state,
    socialMediaIds: ref.read(socialMediaIdsProvider.notifier).state,
    socialMediaLinks: ref.read(socialMediaLinksProvider.notifier).state,
    nifNumber : ref.read(nifNumberController.notifier).state.text,
    bio: ref.read(bioController.notifier).state.text,
    );
    User aUser = User();
    debugPrint("aUser email value is ${aUser.email}");
ref.read(userObjectProvider.notifier).state  = User();
debugPrint("ref.read(userObjectProvider).email  = ${
ref.read(userObjectProvider)?.email
}");
  context.pop();





}
