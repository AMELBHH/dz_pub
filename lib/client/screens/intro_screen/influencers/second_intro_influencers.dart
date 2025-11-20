import 'package:dz_pub/client/screens/intro_screen/client/first_intro_client.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecondIntroInfluencers extends StatelessWidget {
  const SecondIntroInfluencers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
          child: MyFirst(
            image: 'assets/image/Screenshot 2025-06-21 175622 (1).png',
            title: 'اختر اعلانك',
            description: 'اختر الإعلانات التي تناسبك، وحدد سعرك وشروطك بكل سهولة.',
            text: 'التالي',
            onPressed: () {
              context.pushReplacementNamed(AppRoutes.thirdIntroInfluencers);
            },
          ),
        ),
      ),
    );
  }
}
