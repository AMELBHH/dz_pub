import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/api/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountListScreen extends ConsumerStatefulWidget {
  const AccountListScreen({super.key});

  @override
  ConsumerState<AccountListScreen> createState() => _AccountListScreenState();
}

class _AccountListScreenState extends ConsumerState<AccountListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminNotifierProvider.notifier).getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة الحسابات', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onSelected: (value) {
              if (value == 'all') {
                ref.read(adminNotifierProvider.notifier).getUsers();
              } else if (value == 'inactive') {
                ref.read(adminNotifierProvider.notifier).getInactiveUsers();
              } else if (value == 'unverified_client') {
                ref.read(adminNotifierProvider.notifier).getUnverifiedUsers(1);
              } else if (value == 'unverified_influencer') {
                ref.read(adminNotifierProvider.notifier).getUnverifiedUsers(2);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'all',
                child: Text(
                  'جميع المستخدمين',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'inactive',
                child: Text(
                  'المستخدمين المحظورين',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'unverified_client',
                child: Text(
                  'عملاء غير موثقين',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'unverified_influencer',
                child: Text(
                  'مؤثرين غير موثقين',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage!))
          : state.users.isEmpty
          ? const Center(child: Text('لا يوجد مستخدمين'))
          : ListView.builder(
              itemCount: state.users.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final user = state.users[index];
                return _buildUserCard(user);
              },
            ),
    );
  }

  Widget _buildUserCard(User user) {
    String userType = "غير محدد";
    if (user.typeId == 1) userType = "عميل";
    if (user.typeId == 2) userType = "مؤثر";
    if (user.typeId == 3) userType = "مسؤول";

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.premrayColor.withValues(alpha: 0.1),
          child: Text(
            user.name?.isNotEmpty == true ? user.name![0].toUpperCase() : '?',
            style: TextStyle(color: AppColors.premrayColor),
          ),
        ),
        title: Text(
          user.name ?? 'بدون اسم',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              user.email ?? 'بدون بريد إلكتروني',
              style: TextStyle(
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: user.isActive == 1
                        ? Colors.green[100]
                        : Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    user.isActive == 1 ? 'نَشِط' : 'محظور',
                    style: TextStyle(
                      fontSize: 12,
                      color: user.isActive == 1
                          ? Colors.green[800]
                          : Colors.red[800],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    userType,
                    style: TextStyle(fontSize: 12, color: Colors.blue[800]),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: user.userInfo?.isVerified == "yes"
                        ? Colors.cyan[100]
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    user.userInfo?.isVerified == "yes" ? "موثق" : "غير موثق",
                    style: TextStyle(
                      fontSize: 12,
                      color: user.userInfo?.isVerified == "yes"
                          ? Colors.cyan[800]
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          if (user.id != null) {
            context.pushNamed(AppRoutes.userDetails, extra: user.id);
          }
        },
      ),
    );
  }
}
