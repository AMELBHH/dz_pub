import 'package:flutter/material.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';
import '../button_widgets/elevated_button_widget.dart';
class NormalAlert {
  static show(
      {required BuildContext context,
        required String title,
        required  String message,
        required  String textOfOkButton,
        Color? containerColor,
        Color? borderColor,
        Color? textColor}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            backgroundColor: containerColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(
                    color: borderColor ?? Colors.orange,
                    strokeAlign: 0,
                    width: 0.5)),
            title: Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontSize:
                  getIt<AppDimension>().isSmallScreen(context) ? 18 : 20,
                  fontWeight: FontWeight.w800),
            ),
            content: Text(
              message,
              style: TextStyle(
                  color: textColor,
                  fontSize:
                  getIt<AppDimension>().isSmallScreen(context) ? 15 : 17,
                  fontWeight: FontWeight.w400),
            ),
            actions: [
              ElevatedButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  context: context,
                  child: Text(
                    textOfOkButton,
                  )),
            ],
          );
        });
  }
}
