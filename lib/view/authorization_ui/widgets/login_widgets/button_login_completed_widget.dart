import 'package:dz_pub/controllers/auth/methods/hybrid_methods/auth_validator/login_and_reg_validators/validator_and_login.dart';
import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ween_blaqe/testing_code/find_the_fastest_way_in_state_managment/riverpod/login_and_register_section/login_controller_test.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';

// import '../../../../constants/strings.dart';

class ButtonLoginCompletedWidget extends ConsumerStatefulWidget {
  const ButtonLoginCompletedWidget({super.key});

  @override
  ConsumerState createState() => _ButtonLoginCompletedWidgetState();
}

class _ButtonLoginCompletedWidgetState extends ConsumerState<ButtonLoginCompletedWidget> {
  @override

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20,
          getIt<AppDimension>().isSmallScreen(context) ? 50 / 1.5 : 50, 20, 10),
      child: SizedBox(
        width: double.infinity,
        height: getIt<AppDimension>().isSmallScreen(context) ? 55 / 1.2 : 55,
        child: ElevatedButtonWidget(
            onPressed: () {

              validateAndLogin(ref, context);



              setState(() {

});

            },
            context: context,
            child: ref.watch(loginNotifier).isLoading == false
                ?
            Text("تسجيل الدخول"
              // SetLocalization.of(context)!.getTranslateValue("login")
              ,style: TextStyle(color: Colors.white),
            )
                : const CircularProgressIndicator(
              color: Colors.white,
            )),
      ),
    );
  }
}


