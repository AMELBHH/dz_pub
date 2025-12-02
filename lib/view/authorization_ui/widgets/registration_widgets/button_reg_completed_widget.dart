import 'package:dz_pub/controllers/auth/methods/hybrid_methods/auth_validator/login_and_reg_validators/validator_and_registratoin.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';
import '../../../../constants/strings.dart';
import '../../../../controllers/auth/providers/auth_provider.dart';
import '../../../../controllers/show_snack_bar_notifier.dart';
import '../../../../session/new_session.dart';

class ButtonRegCompletedWidget extends ConsumerWidget {
  const     ButtonRegCompletedWidget({super.key,this.categoryIds, this.socialMediaIds, this.socialMediaLinks});
final List<int> ?categoryIds;
final List<int> ?socialMediaIds;
final List<String> ?socialMediaLinks;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 25),
      child: SizedBox(
        width: double.infinity,
        height: getIt<AppDimension>().isSmallScreen(context) ? 55 / 1.2 : 55,
        child: ElevatedButtonWidget(
            onPressed: () async{
              // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
              ref.read(categoryIdsProvider.notifier).state = categoryIds??[];
              ref.read(socialMediaIdsProvider.notifier).state = socialMediaIds??[];
              ref.read(socialMediaLinksProvider.notifier).state = socialMediaLinks??[];
              debugPrint("category ids ${ref.read(categoryIdsProvider)}");
              debugPrint("social media ids ${ref.read(socialMediaIdsProvider)}");
              debugPrint("social media links ${ref.read(socialMediaLinksProvider)}");

                validateAndRegistration(ref, context);
                debugPrint("NewSession of logged is ${NewSession.get(PrefKeys
                    .logged,"")}");
              ref.watch(registerNotifier).hasError ==true ?
            ref.read(showSnackBarNotifier.notifier).showSnackBar(context:
            context, ref: ref,
                textColor: Colors.red,
                message: "يرجى ملئ الحقول المطلوبة")
                :
                  debugPrint("no error have ");

            },
            context: context,
            child: ref.watch(registerNotifier).isLoading == false
                ? Text("إنشاء حساب")
            // //   Text(SetLocalization.of(context)!.getTranslateValue("create_account"))
                : const CircularProgressIndicator(
              color: Colors.white,
            )),
      ),
    );
  }
}
