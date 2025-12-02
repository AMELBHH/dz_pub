import 'package:dz_pub/controllers/statuses/validate_text_form_field_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'validator.dart';


/// a [FormFieldsNotifier]  have two methods , [updateValue] , and [updateApiErrors].
///    a state of class is [TextFieldState].


class FormFieldsNotifier extends StateNotifier<Map<String, TextFieldState>> {
  FormFieldsNotifier() : super({});

///  [updateValue] is take the value of controller ,and check if have an error in the UI section
///   according the validate methods in [Validator] class.
///    a [error] that to return error text 'if-exist'.
    
  void updateValue(String fieldKey, String value,
      {BuildContext? context, WidgetRef? ref}) {
    String? error = Validator.validateField(fieldKey, value,context!);

    state = {
      ...state,
      fieldKey: TextFieldState(value: value, error: error),
    };
  }

   ///an [updateApiErrors] that work like [updateValue] but it for API Section
  void  updateApiErrors(Map<String, String?> errors) {
    state = {
      ...state,
      ...errors.map((key, value) => MapEntry(
          key, TextFieldState(value: state[key]?.value ?? '', error: value))),
    };
  }
}
