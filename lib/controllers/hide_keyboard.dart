import 'package:flutter/material.dart';

Future<void> hideKeyboard(BuildContext context)async {
  FocusScopeNode currentFocus =  FocusScope.of(context);
  if ( currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }

}
void hideKeyboardWhenClickOutside(BuildContext context){
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }

}
