import 'package:dz_pub/client/screens/Influencers/influencers_home_screen.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/controllers/providers/influencer_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(categorySelectableName.notifier).state = '';
      ref.read(categorySelectedId.notifier).state = 0;


    });
  }

  @override
  Widget build(BuildContext context) {
    final logged = NewSession.get(PrefKeys.logged, "");
    final userTypeStored = NewSession.get(PrefKeys.userType, "client");
    final userTypeJson = ref.watch(loginNotifier).userType;
    final userTypeToCheck = (logged == "") ? userTypeStored : userTypeJson;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:Colors.grey.shade200,
        appBar: AppBar(
          title: Text("DZ_PUB"),
          // backgroundColor: Colors.amber[600],
          bottom: TabBar(
            tabs: [
              const Tab(icon: Icon(Icons.home)),
              const Tab(icon: Icon(Icons.person)),
            ],
            onTap: (index) async {
              if(index == 0){
                debugPrint("NewSession logged $logged)}");
                debugPrint("NewSession userTypeStored $userTypeStored");
                debugPrint("NewSession userTypeJson $userTypeJson");
                debugPrint("NewSession userTypeToCheck $userTypeToCheck");
              }
              if (index == 1) {
                if(NewSession.get(PrefKeys.userTypeId, 1) == 2){
                if (ref.read(loginNotifier).categories == null ||
                    ref.read(loginNotifier).socialMediaLinks == null) {
                  await ref.read(loginNotifier.notifier).getCategoriesAndSocialMediaLinksOfInfluencer(
                    NewSession.get(PrefKeys.id, 0),
                  );
                }
              }
              }
            },
          )
          ,
        ),
        body: TabBarView(
          children: [
            //home

     Padding(


              padding: const  EdgeInsets.symmetric(horizontal: 20),
              child:


       userTypeToCheck == "client"?
       ClientHome():
     InfluencersHome()

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

class ClientHome extends ConsumerWidget {
  const ClientHome({super.key});

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


             // debugPrint("categorySelectedId ")
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
            onPressd: () {
if(NewSession.get(PrefKeys.logged, "") == ""){
  ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(context:
  context,message: "يرجى تسحيل الدخول أولا");
  return;
}
context.pushNamed(AppRoutes.listOfPromotions);
                debugPrint("here is life of promation of cliet!!!");

                debugPrint("listOfClientPromotions");
            },
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
              //ListOfCustomPromotion
              context.pushNamed(AppRoutes.listOfCustomPromotion);
            },
            textButton: 'اشهاراتي حسب الطلب',
            textStyle: AppTextStyle.homebuttonStyle,
            heigth: height * 0.07,
            width: width * 0.9,
            radius: 180,
          ),
          SizedBox(height: height * 0.015),
          CustomButtonWidget(
            colorButton: AppColors.premrayColor,
            onPressd: () {

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
      ),
    );
  }


}