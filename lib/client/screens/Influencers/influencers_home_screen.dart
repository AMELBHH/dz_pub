import 'package:dz_pub/client/screens/client/list_of_promotions_ui.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/sesstion_of_user.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/strings.dart';
import '../../../session/new_session.dart';

class InfluencersHome  extends StatelessWidget {
  const InfluencersHome({super.key});

  @override
  Widget build(BuildContext context) {
    return InfluencerHomeButtons();
  }
}

class InfluencerHomeButtons extends ConsumerWidget {
  const InfluencerHomeButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SingleChildScrollView(

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * .15),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {
              if(NewSession.get(PrefKeys.logged, "") == ""){
                ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(context:context,message: "يرجى تسحيل الدخول أولا");
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                          ListOfPromotions(statusId:4,title:"إشهارات قيد التسليم"),
                ),
              );
            },
            textButton: 'إشهارات قيد التسليم',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),
          SizedBox(height: height * 0.015),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {
              if(NewSession.get(PrefKeys.logged, "") == ""){
                ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(context:context,message: "يرجى تسحيل الدخول أولا");
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ListOfPromotions(statusId:3,title:"إشهارات قيد المناقشة"),
                ),
              );
            },
            textButton: 'إشهارات قيد المناقشة',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),
          SizedBox(height: height * 0.015),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {
              if(NewSession.get(PrefKeys.logged, "") == ""){
                ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(context:context,message: "يرجى تسحيل الدخول أولا");
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ListOfPromotions(statusId:6,title:"إشهارات مُعترض عيها"),
                ),
              );
            },
            textButton: 'إشهارات مُعترض عيها',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),
          SizedBox(height: height * 0.015),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {
              if(NewSession.get(PrefKeys.logged, "") == ""){
                ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(context:context,message: "يرجى تسحيل الدخول أولا");
                return;
              }
              //push to list of Promotion with status id

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ListOfPromotions(statusId:5,title:"إشهارات مرفوضة"  ),
                ),
              );
            },
            textButton: 'إشهارات مرفوضة',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),

          SizedBox(height: height * 0.015),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {
              GoRouter.of(context).go(AppRoutes.userTypeQuestionScreen);
              removeUserInfo();
            },
            textButton: 'تبديل الحساب',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),
          SizedBox(height: height * 0.015),

        ],
      ),
    );
  }

}