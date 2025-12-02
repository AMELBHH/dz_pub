import 'package:dz_pub/constants/coordination.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/elevated_button_widget.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/outline_button_widget.dart';
import 'package:flutter/material.dart';
import '../../../constants/get_it_controller.dart';

class AlertWithTwoBtn {
  // var  visible = true;

  static show

      (

      {
        required  BuildContext context
        , required String title
        , required String message
        , required String textOfOkButton
        , required String textOfCancelButton
        , required Function onClicked
        ,  Color ? containerColor
        ,  Color ? borderColor
        ,  Color ? textColor
      }

      ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
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
                    onClicked();
                  },
                  context: context,
                  child: Text(
                    textOfOkButton,
                  )),

              OutlinedButtonWidget(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    textOfCancelButton,
                  )),
              // SizedBox(width: 1,),

            ],
          );
        });
  }
}
