import 'package:dz_pub/client/questions/last_step.dart';

import 'package:dz_pub/client/questions/CustomDropdownQuestion.dart';
import 'package:dz_pub/client/screens/client/Custom_promotion.dart';

import 'package:dz_pub/client/screens/client/Influencer_profile_details.dart';
import 'package:dz_pub/client/screens/client/List_of_influencers.dart';
import 'package:dz_pub/client/screens/client/List_of_influencers_by_niche.dart';
import 'package:dz_pub/client/screens/client/Platform_services.dart';
import 'package:dz_pub/client/screens/client/client_home_screen.dart';
import 'package:dz_pub/client/screens/client/list_of_client_promotions.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterGenrator {
  static GoRouter mainRouttingInourApp = GoRouter(
    errorBuilder: (context, statc) => Scaffold(body: Text('NNNNNN ')),
    initialLocation: NewSession.get(PrefKeys.userType, '') != ''
        ? AppRoutes.homeScreen
        : AppRoutes.userTypeQuestionScreen,

    routes: [
      GoRoute(
        name: AppRoutes.userTypeQuestionScreen,
        path: AppRoutes.userTypeQuestionScreen,
        builder: (context, statc) => const UserTypeQuestionScreen(),
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
        builder: (context, state) => const PromotionDetailsScreen(),
      ),
      GoRoute(
        name: AppRoutes.listOfClientPromotions,
        path: AppRoutes.listOfClientPromotions,
        builder: (context, state) => const ListOfClientPromotions(),
      ),
      GoRoute(
        path: AppRoutes.platformServices,
        name: AppRoutes.platformServices,
        builder: (context, state) => PlatformServices(),
      ),
    ],
  );
}
