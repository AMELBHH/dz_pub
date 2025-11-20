import 'package:dz_pub/core/styling/App_colors.dart';

import 'package:dz_pub/core/styling/App_text_style.dart';

import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("DZ_PUB"),
          // backgroundColor: Colors.amber[600],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home, color: AppColors.witheColor)),
              Tab(icon: Icon(Icons.person, color: AppColors.witheColor)),
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBarView(
              children: [
                //home
                ClientHome(),
                //profile
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientHome extends StatelessWidget {
  const ClientHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            context.pushNamed(AppRoutes.listOfInfluencers);
          },
          textButton: 'قائمة المؤثرين',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            context.pushNamed(AppRoutes.listOfInfluencersByNiche);
          },
          textButton: 'قائمة المؤثرين حسب المجال',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            context.pushNamed(AppRoutes.customPromotion);
          },
          textButton: 'ترويج حسب الطلب',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {},
          textButton: 'اشهاراتي',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
        CustomButtonWidget(
          colorButton: AppColors.premrayColor,
          onPressd: () {
            context.pushNamed(AppRoutes.platformServices);
          },
          textButton: 'خدمات المنصة الاحترافية',
          textStyle: AppTextStyle.homebuttonStyle,
          heigth: height * 0.07,
          width: width * 0.9,
          radius: 180,
        ),
        SizedBox(height: height * 0.015),
      ],
    );
  }
}
