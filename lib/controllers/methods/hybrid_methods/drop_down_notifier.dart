import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';

// StateNotifier to manage the selected dropdown item
class DropdownNotifier extends  StateNotifier<int> {
  DropdownNotifier() : super(int.parse('0'));

  void setSelectedItem(
      {
      required List<String> stringValues,
      required String currentValue}) {
    for (int i = 0; i < stringValues.length; i++) {
      if (stringValues[i] == currentValue) {
        state = i;
        debugPrint("sate is $state");
      }
    }
  }
}
