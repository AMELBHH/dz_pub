import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserTypeQuestionScreen extends ConsumerWidget {
  const UserTypeQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      debugPrint(
                        "type of user ${NewSession.get(PrefKeys.userType, "no user type selected")}",
                      );
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
                      context.pushReplacementNamed(AppRoutes.firstIntroClient);
                    },
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    onPressed: () => _showAdminLoginDialog(context, ref),
                    icon: Icon(
                      Icons.admin_panel_settings,
                      color: AppColors.premrayColor,
                    ),
                    label: Text(
                      'الدخول بإسم المنصة',
                      style: AppTextStyle.black19.copyWith(
                        color: AppColors.premrayColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
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

  void _showAdminLoginDialog(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(loginNotifier);

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'دخول المنصة',
              textAlign: TextAlign.center,
              style: AppTextStyle.black19,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  style: AppTextStyle.black19.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    labelStyle: AppTextStyle.titel.copyWith(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColors.premrayColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.premrayColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: !authState.isLoading,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  style: AppTextStyle.black19.copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    labelStyle: AppTextStyle.titel.copyWith(color: Colors.grey),
                    prefixIcon: Icon(Icons.lock, color: AppColors.premrayColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.premrayColor),
                    ),
                  ),
                  obscureText: true,
                  enabled: !authState.isLoading,
                ),
                if (authState.isLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CircularProgressIndicator(
                      color: AppColors.premrayColor,
                    ),
                  ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: authState.isLoading
                            ? null
                            : () => Navigator.pop(context),
                        child: Text(
                          'إلغاء',
                          style: AppTextStyle.titel.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: authState.isLoading
                            ? null
                            : () async {
                                try {
                                  final user = await ref
                                      .read(loginNotifier.notifier)
                                      .login(
                                        emailController.text,
                                        passwordController.text,
                                        ref,
                                        context,
                                      );

                                  if (user.typeId == 3) {
                                    NewSession.save(PrefKeys.userType, 'admin');
                                    Navigator.pop(context);
                                    context.pushReplacementNamed(
                                      AppRoutes.adminHomeScreen,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'عذراً، هذا الحساب ليس حساب مسؤول',
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'خطأ في الدخول: ${e.toString().replaceAll('Exception: ', '')}',
                                      ),
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.premrayColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          'دخول',
                          style: AppTextStyle.homebuttonStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
