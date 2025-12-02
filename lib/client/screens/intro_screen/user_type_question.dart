import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTypeQuestionScreen extends StatelessWidget {
  const UserTypeQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F7FA), Color(0xFFE4EBF5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 150,
              child: Opacity(
                opacity: 0.07,
                child: Image.asset(
                  'assets/image/Screenshot 2025-06-21 175622 (1).png',
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Container(
              width: 330,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('من أنت؟', style: AppTextStyle.black19),
                  const SizedBox(height: 8),
                  Text(
                    'اختر نوع الحساب الذي يناسبك للمتابعة',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.descriptionText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),

                  _OptionButton(
                    title: 'أنا مؤثر',
                    description: 'أنشئ محتوى وتعاون مع العلامات التجارية',
                    color: Colors.deepPurpleAccent,
                    onTap: () async {
                    NewSession.save(PrefKeys.userType, 'influencer');
                    debugPrint("type of user ${NewSession.get(PrefKeys
                        .userType, "no user type selected")}");
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs.setString('user_type', 'influencer');
                      context.pushReplacementNamed(
                        AppRoutes.firstIntroInfluencers,
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  _OptionButton(
                    title: 'أنا معلن',
                    description: 'ابحث عن مؤثرين لحملاتك بسهولة',
                    color: Colors.blueAccent,
                    onTap: () async {
                      NewSession.save(PrefKeys.userType, 'client');


                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs.setString('user_type', 'client');
                      context.pushReplacementNamed(AppRoutes.firstIntroClient);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _OptionButton({
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.9),
              radius: 20,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.black19),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: AppTextStyle.descriptionText.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
