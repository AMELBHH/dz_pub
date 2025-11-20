import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListOfInfluencersByNiche extends StatelessWidget {
  const ListOfInfluencersByNiche({super.key});

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    //final width = size.width;
    final height = size.height;
    return Scaffold(

      body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          CustomButtonWidget(onPressd: (){ context.pushNamed(AppRoutes.listOfInfluencers);}, textStyle: AppTextStyle.homebuttonStyle, textButton: 'الرياضة', colorButton: AppColors.premrayColor), SizedBox(height: height * 0.015),
            CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.homebuttonStyle, textButton: 'الرياضة', colorButton: AppColors.premrayColor), SizedBox(height: height * 0.015),
              CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.homebuttonStyle, textButton: 'الرياضة', colorButton: AppColors.premrayColor), SizedBox(height: height * 0.015),
                CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.homebuttonStyle, textButton: 'الرياضة', colorButton: AppColors.premrayColor), SizedBox(height: height * 0.015),
                  CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.homebuttonStyle, textButton: 'الرياضة', colorButton: AppColors.premrayColor), SizedBox(height: height * 0.015),
          ],
        ),
      ),
    );
  }
}