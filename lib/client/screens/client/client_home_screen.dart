import 'package:dz_pub/client/screens/Influencers/influencers_home_screen.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';

import 'package:dz_pub/core/styling/App_text_style.dart';

import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/session/sesstion_of_user.dart';
import 'package:dz_pub/view/authorization_ui/login_ui.dart';
import 'package:dz_pub/view/authorization_ui/profile_ui.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:Colors.grey.shade200,
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
        body: TabBarView(
          children: [
            //home
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
              NewSession.get(PrefKeys.userType, 'client') == 'client' ?
              ClientHome(): InfluencersHome(),
            ),
            //profile



              HandelProfileAndLoginUI()

          ],
        ),
      ),
    );
  }
}

class HandelProfileAndLoginUI extends ConsumerStatefulWidget {
  const HandelProfileAndLoginUI({super.key});

  @override
  ConsumerState createState() => _HandelProfileAndLoginUIState();
}

class _HandelProfileAndLoginUIState
    extends ConsumerState<HandelProfileAndLoginUI> {
  @override
  Widget build(BuildContext context) {
    return
      ref.watch(loginNotifier).isLoading ||
      ref.watch(logoutNotifier).isLoading ?
      Center(child: CircularProgressIndicator(),)
          :
      (NewSession.get(PrefKeys.logged, "") == "OK" ?
    ProfileUi()
        :
    LoginUi());
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
    );
  }
}
