import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/client/questions/last_step.dart';

import 'package:dz_pub/client/questions/custom_dropdown_question.dart';
import 'package:dz_pub/client/screens/client/custom_promotion_ui.dart';

import 'package:dz_pub/client/screens/client/influencer_profile_details_ui.dart';
import 'package:dz_pub/client/screens/client/list_of_influencers_ui.dart';
import 'package:dz_pub/client/screens/client/list_of_influencers_by_niche_ui.dart';
import 'package:dz_pub/client/screens/client/platform_services.dart';
import 'package:dz_pub/client/screens/client/client_home_ui.dart';
import 'package:dz_pub/client/screens/client/client_advertisements_ui.dart';
import 'package:dz_pub/client/screens/Influencers/influencer_advertisements_ui.dart';
import 'package:dz_pub/client/screens/client/list_of_custom_promotion_ui.dart';
import 'package:dz_pub/client/screens/client/list_of_promotions_ui.dart';
import 'package:dz_pub/client/screens/client/promotion_detials_ui.dart';
import 'package:dz_pub/client/screens/intro_screen/client/first_intro_client.dart';
import 'package:dz_pub/client/screens/intro_screen/client/second_intro_client.dart';
import 'package:dz_pub/client/screens/intro_screen/client/third_intro_client.dart';
import 'package:dz_pub/client/screens/intro_screen/influencers/first_intro_influencers.dart';
import 'package:dz_pub/client/screens/intro_screen/influencers/second_intro_influencers.dart';
import 'package:dz_pub/client/screens/intro_screen/influencers/third_intro_influencers.dart';
import 'package:dz_pub/client/screens/intro_screen/user_type_question.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/view/admin_ui/report_management_ui.dart';
import 'package:dz_pub/view/admin_ui/admin_home_ui.dart';
import 'package:dz_pub/view/admin_ui/account_management/account_list_ui.dart';
import 'package:dz_pub/view/admin_ui/account_management/user_details_ui.dart';
import 'package:dz_pub/view/admin_ui/promotions_management_ui.dart';
import 'package:dz_pub/view/admin_ui/advertisements_management_ui.dart';
import 'package:dz_pub/view/authorization_ui/update_profile_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenrator {
  static GoRouter mainRouttingInourApp = GoRouter(
    errorBuilder: (context, statc) => Scaffold(body: Text('NNNNNN ')),
    initialLocation: NewSession.get(PrefKeys.userType, '') == 'admin'
        ? AppRoutes.adminHomeScreen
        : NewSession.get(PrefKeys.userType, '') != ''
        ? AppRoutes.homeScreen
        : AppRoutes.userTypeQuestionScreen,

    routes: [
      GoRoute(
        name: AppRoutes.userTypeQuestionScreen,
        path: AppRoutes.userTypeQuestionScreen,
        builder: (context, statc) => const UserTypeQuestionScreen(),
      ),
      GoRoute(
        name: AppRoutes.listOfCustomPromotion,
        path: AppRoutes.listOfCustomPromotion,
        builder: (context, statc) => const ListOfCustomPromotion(),
      ),

      GoRoute(
        path: AppRoutes.firstIntroInfluencers,
        name: AppRoutes.firstIntroInfluencers,
        builder: (context, state) => FirstIntroInfluencers(),
      ),

      GoRoute(
        path: AppRoutes.secondIntroInfluencers,
        name: AppRoutes.secondIntroInfluencers,
        builder: (context, state) => SecondIntroInfluencers(),
      ),

      GoRoute(
        path: AppRoutes.thirdIntroInfluencers,
        name: AppRoutes.thirdIntroInfluencers,
        builder: (context, state) => ThirdIntroInfluencers(),
      ),

      GoRoute(
        name: AppRoutes.firstIntroClient,
        path: AppRoutes.firstIntroClient,
        builder: (context, statc) => const FirstIntroClient(),
      ),
      GoRoute(
        name: AppRoutes.secondIntroClient,
        path: AppRoutes.secondIntroClient,
        builder: (context, statc) => const SecondIntroClient(),
      ),
      GoRoute(
        name: AppRoutes.thirdIntroClient,
        path: AppRoutes.thirdIntroClient,
        builder: (context, statc) => const ThirdIntroClient(),
      ),

      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, statc) => const HomeScreen(),
      ),

      // GoRoute(
      //   name: AppRoutes.influencersHomeScreen,
      //   path: AppRoutes.influencersHomeScreen,
      //   builder: (context, statc) => const InfluencersHome(),
      // ),
      GoRoute(
        path: AppRoutes.listOfInfluencers,
        name: AppRoutes.listOfInfluencers,
        builder: (context, state) => const ListOfInfluencers(),
      ),
      GoRoute(
        name: AppRoutes.influencerProfileDetails,
        path: AppRoutes.influencerProfileDetails,
        builder: (context, state) => const InfluencerProfileDetails(),
      ),
      GoRoute(
        name: AppRoutes.dynamicQuestionScreen,
        path: AppRoutes.dynamicQuestionScreen,
        builder: (context, state) => DynamicQuestionScreen(),
      ),

      GoRoute(
        name: AppRoutes.lastStep,
        path: AppRoutes.lastStep,
        builder: (context, state) => LastStep(),
      ),
      GoRoute(
        path: AppRoutes.listOfInfluencersByNiche,
        name: AppRoutes.listOfInfluencersByNiche,
        builder: (context, state) => ListOfInfluencersByNiche(),
      ),
      GoRoute(
        path: AppRoutes.customPromotion,
        name: AppRoutes.customPromotion,
        builder: (context, state) => CustomPromotion(),
      ),
      GoRoute(
        name: AppRoutes.promotionDetails,
        path: AppRoutes.promotionDetails,
        builder: (context, state) {
          final promotion = state.extra as Promotion?;
          final hideInfluencerDetails =
              state.uri.queryParameters['hideInfluencerDetails'] == 'true';
          return PromotionDetailsScreen(
            promotion: promotion,
            hideInfluencerDetails: hideInfluencerDetails,
          );
        },
      ),
      GoRoute(
        name: AppRoutes.listOfPromotions,
        path: AppRoutes.listOfPromotions,
        builder: (context, state) => const ListOfPromotions(),
      ),
      GoRoute(
        path: AppRoutes.platformServices,
        name: AppRoutes.platformServices,
        builder: (context, state) => PlatformServices(),
      ),
      GoRoute(
        path: AppRoutes.adminHomeScreen,
        name: AppRoutes.adminHomeScreen,
        builder: (context, state) => const AdminHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.reportManagement,
        name: AppRoutes.reportManagement,
        builder: (context, state) => const ReportManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.accountManagement,
        name: AppRoutes.accountManagement,
        builder: (context, state) => const AccountListScreen(),
      ),
      GoRoute(
        path: AppRoutes.userDetails,
        name: AppRoutes.userDetails,
        builder: (context, state) {
          return UserDetailsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.promotionsManagement,
        name: AppRoutes.promotionsManagement,
        builder: (context, state) => const PromotionsManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.updateProfile,
        name: AppRoutes.updateProfile,
        builder: (context, state) => const UpdateProfileUi(),
      ),
      GoRoute(
        path: AppRoutes.advertisementsManagement,
        name: AppRoutes.advertisementsManagement,
        builder: (context, state) => const AdvertisementsManagementUi(),
      ),
      GoRoute(
        path: AppRoutes.clientAdvertisements,
        name: AppRoutes.clientAdvertisements,
        builder: (context, state) => const ClientAdvertisementsScreen(),
      ),
      GoRoute(
        path: AppRoutes.influencerAdvertisements,
        name: AppRoutes.influencerAdvertisements,
        builder: (context, state) => const InfluencerAdvertisementsScreen(),
      ),
    ],
  );
}
