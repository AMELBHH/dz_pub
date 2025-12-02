import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../../constants/localization.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../statuses/auth_state.dart';

class ValidatorAndUpdateDataOfUserNotifier extends StateNotifier<AuthState> {
  ValidatorAndUpdateDataOfUserNotifier() : super(AuthState());

  void validateAndUpdateUserData(WidgetRef ref, BuildContext context) async {
    ref.watch(streamUpdateUserDataController.notifier).state.add(
          SetLocalization.of(context)!.getTranslateValue("verifying"),
        );

    if (oldPasswordFormKey.currentState?.validate != null ||
        newPasswordFormKey.currentState?.validate != null ||
        sureNewPasswordFormKey.currentState?.validate != null ||
        updatePhoneNumberFormKey.currentState?.validate != null ||
        updateUsernameFormKey.currentState?.validate != null) {
      ref.watch(streamUpdateUserDataController.notifier).state.add("");
    }
    if (ref.watch(oldPasswordValidate.notifier).state != null ||
        ref.watch(sureNewPasswordValidate.notifier).state != null ||
        ref.watch(newPasswordValidate.notifier).state != null ||
        ref.watch(updatePhoneValidate.notifier).state != null ||
        ref.watch(updateUserNameValidate.notifier).state != null) {
      debugPrint("one of validation text is not null");
      ref.watch(streamUpdateUserDataController.notifier).state.add("");
    }

    //for updateUsernameController
    if (ref.watch(updateUsernameController.notifier).state.text == "") {
      updateUsernameFormKey.currentState?.validate();

      ref.watch(updateUserNameValidate.notifier).state =
          SetLocalization.of(context)?.getTranslateValue("fill_field");
      return;
    } else {
      updateUsernameFormKey.currentState?.reset();
    }
    if (ref
        .watch(updateUsernameController.notifier)
        .state
        .text
        .contains(RegExp(r'[^a-zA-Z0-9]'))) {
      updateUsernameFormKey.currentState?.validate();
      ref.watch(updateUserNameValidate.notifier).state =
          SetLocalization.of(context)?.getTranslateValue(
              "username_must_not_contain_special_characters");

      return;
    } else {
      {
        updateUsernameFormKey.currentState?.reset();
      }
    }
    //for updatePhoneNumberController
    if (ref.watch(updatePhoneNumberController.notifier).state.text.length < 9 ||
        ref.watch(updatePhoneNumberController.notifier).state.text.length > 9) {
      updatePhoneNumberFormKey.currentState?.validate();
      ref.watch(updatePhoneValidate.notifier).state =
          SetLocalization.of(context)
              ?.getTranslateValue("the_phone_number_is_not_suitable");
      return;
    } else {
      ref.watch(updatePhoneValidate.notifier).state = null;

      updatePhoneNumberFormKey.currentState?.reset();
    }

    if (ref
        .watch(updatePhoneNumberController.notifier)
        .state
        .text
        .contains(RegExp(r'[^0-9]'))) {
      updatePhoneNumberFormKey.currentState?.validate();
      ref.watch(updatePhoneValidate.notifier).state =
          SetLocalization.of(context)?.getTranslateValue(
              "phone_number_must_not_contain_special_characters");
      return;
    } else {
      ref.watch(updatePhoneValidate.notifier).state = null;

      updatePhoneNumberFormKey.currentState?.reset();
    }

    // await ref
    //     .watch(updaterDataUserNotifier.notifier)
    //     .updateUserData(ref, context);
    state = state.copyWith(isLoading: false);
  }
}
