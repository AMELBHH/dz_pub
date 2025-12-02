import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/login_widgets/button_login_completed_widget.dart';
import 'widgets/login_widgets/button_nav_to_reg_completed_widget.dart';
import 'widgets/login_widgets/password_login_completed_widget.dart';
import 'widgets/login_widgets/phone_login_completed_widget.dart';
import 'widgets/login_widgets/title_login_completed_widget.dart';

class LoginUi extends ConsumerWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
            //   child: BackButtonWidget(),
            // ),
            TitleLoginCompletedWidget(),
            EmailLoginCompletedWidget(),
            PasswordLoginCompletedWidget(),
            ButtonLoginCompletedWidget(),
            ButtonNavToRegCompletedWidget(),
          ],
        ),
      ),
    );
  }
}
