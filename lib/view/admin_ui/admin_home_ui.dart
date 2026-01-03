import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة تحكم المنصة', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(logoutNotifier.notifier).logout();
              // Also clear user type to ensure they see the selection screen on restart
              NewSession.remove(PrefKeys.userType);
              if (context.mounted) {
                context.goNamed(AppRoutes.userTypeQuestionScreen);
              }
            },
            icon: const Icon(Icons.logout),
            tooltip: 'تسجيل الخروج',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.reportManagement),
              icon: const Icon(Icons.report_problem, color: Colors.white),
              label: const Text(
                'إدارة البلاغات',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.premrayColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.accountManagement),
              icon: const Icon(Icons.people, color: Colors.white),
              label: const Text(
                'إدارة الحسابات',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.premrayColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.promotionsManagement),
              icon: const Icon(Icons.campaign, color: Colors.white),
              label: const Text(
                'إدارة الحملات الإعلانية',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.premrayColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
