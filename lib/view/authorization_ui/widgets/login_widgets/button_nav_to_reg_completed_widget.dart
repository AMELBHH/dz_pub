import 'package:dz_pub/controllers/hide_keyboard.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/outline_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';
import '../../registration_ui.dart';

class ButtonNavToRegCompletedWidget extends ConsumerWidget {
  const ButtonNavToRegCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(
        width: double.infinity,
        height: getIt<AppDimension>().isSmallScreen(context) ? 55 / 1.2 : 55,
        child: OutlinedButtonWidget(
            onPressed: () {
              hideKeyboard(context);

              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const RegistrationUi();
                }),
              );
            },
            child: Text("تسجيل جديد"),
            //  Text(SetLocalization.of(context)!
            //     .getTranslateValue("register_new_account"))
       ),
      ),
    );
  }
}
