import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_font.dart';
import 'package:dz_pub/routing/App_routes.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstIntroInfluencers extends StatelessWidget {
  const FirstIntroInfluencers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 15),
          child: MyFirst(
            image: 'assets/image/images (1).png',
            title: "انضم كمؤثر",
            description:
                'أنشئ حسابك كمؤثر وابدأ في تلقي عروض حقيقية للإعلانات.',
            text: 'التالي',
            onPressed: () {
              context.pushReplacementNamed(AppRoutes.secondIntroInfluencers);
            },
          ),
        ),
      ),
    );
  }
}

class MyFirst extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String text;
  final Function()? onPressed;
  const MyFirst({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Image.asset(image)),

        Text(
          title,
          style: TextStyle(
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
            fontFamily: AppFont.mainFontName,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: height * 0.03),
        Text(
          description,
          style: TextStyle(
            fontSize: width * 0.036,
            fontWeight: FontWeight.w400,
            fontFamily: AppFont.mainFontName,
            color: AppColors.blackColor,
          ),
        ),
        SizedBox(height: height * 0.09),
        SizedBox(
          width: width * 0.7,

          height: height * 0.06,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.premrayColor,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
                fontFamily: AppFont.mainFontName,
                color: AppColors.witheColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
