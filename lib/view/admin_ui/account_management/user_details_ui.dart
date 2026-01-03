import 'package:dz_pub/api/report.dart';
import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final User? user;
  const UserDetailsScreen({super.key, this.user});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);

    // Find the user in the provider state instead of relying solely on the passed widget.user
    final user = state.users.firstWhere(
      (u) => u.id == widget.user?.id,
      orElse: () => state.selectedUser?.id == widget.user?.id
          ? state.selectedUser!
          : widget.user ?? User(),
    );

    // If the found user is basically empty and we have no valid passed user, we might be loading or failed
    final isLoading = state.isLoading && user.id == null;

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المستخدم', style: AppTextStyle.textStyle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () => _showDeleteConfirmation(context, user),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage!))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfoSection(user),
                  const SizedBox(height: 20),
                  if (user.typeId == 1)
                    _buildClientSection(user.client ?? Client()),
                  if (user.typeId == 2)
                    _buildInfluencerSection(user.influencer ?? Influencer()),
                  const SizedBox(height: 20),
                  _buildReportsSection(
                    "البلاغات المقدمة (منه)",
                    user.reportsMade,
                  ),
                  const SizedBox(height: 20),
                  _buildReportsSection(
                    "البلاغات المستلمة (عليه)",
                    user.reportsReceived,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.premrayColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
            ),
          ),
          Text(
            value ?? "غير متوفر",
            style: TextStyle(
              color: value == null
                  ? Colors.grey
                  : ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(User? user) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user?.typeId == 1 && user?.client != null) ...[
              Center(
                child: Text(
                  user?.client?.isHaveCr == "yes"
                      ? (user?.client?.clientWithCr?.institutionName ??
                            "بدون اسم مؤسسة")
                      : (user?.client?.clientWithoutCr?.nickname ?? "بدون لقب"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.premrayColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
            ],
            _buildSectionTitle("معلومات أساسية"),
            _buildInfoRow("الاسم", user?.name),
            _buildInfoRow("البريد الإلكتروني", user?.email),
            _buildInfoRow("رقم الهاتف", user?.userInfo?.phoneNumber),
            _buildInfoRow("رقم الهوية", user?.userInfo?.identityNumber),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text(
                    "الحالة: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user?.isActive == 1 ? "نَشِط" : "محظور",
                    style: TextStyle(
                      color: user?.isActive == 1 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeThumbColor: AppColors.premrayColor,
                      value: user?.isActive == 1,
                      onChanged: (val) async {
                        if (user?.id != null) {
                          await ref
                              .read(adminNotifierProvider.notifier)
                              .updateUserStatus(user?.id ?? 0, val ? 1 : -1);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Text("موثق: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    user?.userInfo?.isVerified == "yes" ? "نعم" : "لا",
                    style: TextStyle(
                      color: user?.userInfo?.isVerified == "yes"
                          ? Colors.blue
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeThumbColor: Colors.blue,
                      value: user?.userInfo?.isVerified == "yes",
                      onChanged: (val) async {
                        setState(() {});
                        if (user?.id != null) {
                          await ref
                              .read(adminNotifierProvider.notifier)
                              .updateUserVerification(user?.id ?? 0, val);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            _buildInfoRow("تاريخ الانضمام", _formatDate(user?.createdAt)),
            _buildInfoRow("آخر تحديث", _formatDate(user?.updatedAt)),
            _buildInfoRow(
              "نوع المستخدم",
              user?.typeOfUser?.name ??
                  (user?.typeId == 1
                      ? "عميل"
                      : (user?.typeId == 2 ? "مؤثر" : "--")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClientSection(Client client) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("معلومات العميل"),
            _buildInfoRow("سجل تجاري", client.isHaveCr == "yes" ? "نعم" : "لا"),
            if (client.isHaveCr == "yes" && client.clientWithCr != null) ...[
              const Divider(),
              Text(
                "تفاصيل السجل التجاري:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.premrayColor,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                "اسم المؤسسة",
                client.clientWithCr?.institutionName,
              ),
              _buildInfoRow("اسم المالك", client.clientWithCr?.regOwnerName),
              _buildInfoRow("رقم السجل", client.clientWithCr?.rcNumber),
              _buildInfoRow(
                "الرقم التعريفي الجبائي (NIF)",
                client.clientWithCr?.nifNumber,
              ),
              _buildInfoRow(
                "رقم التعريف الإحصائي (NIS)",
                client.clientWithCr?.nisNumber,
              ),
              _buildInfoRow("رقم IBAN", client.clientWithCr?.iban),
              _buildInfoRow(
                "عنوان المؤسسة",
                client.clientWithCr?.institutionAddress,
              ),
              _buildInfoRow("عنوان الفرع", client.clientWithCr?.branchAddress),
            ],
            if (client.isHaveCr == "no" && client.clientWithoutCr != null) ...[
              const Divider(),
              Text(
                "تفاصيل العميل (فردي):",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.premrayColor,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                "اللقب المُستعار",
                client.clientWithoutCr?.nickname,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfluencerSection(Influencer influencer) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("معلومات المؤثر"),
            _buildInfoRow("التقييم", "${influencer.rating ?? 0} ⭐"),
            _buildInfoRow(
              "نوع المؤثر",
              influencer.typeOfInfluencer?.name ??
                  (influencer.typeId == 1 ? "معنوي" : "طبيعي"),
            ),
            _buildInfoRow(
              "الجنس",
              influencer.gender == "male"
                  ? "ذكر"
                  : (influencer.gender == "female"
                        ? "أنثى"
                        : influencer.gender),
            ),
            _buildInfoRow("تاريخ الميلاد", influencer.dateOfBirth),
            _buildInfoRow("النبذة التعريفية", influencer.bio),

            const Divider(),
            _buildSectionTitle("التصنيفات"),
            if (influencer.categories != null &&
                influencer.categories!.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: influencer.categories!
                    .map(
                      (cat) => Chip(
                        label: Text(cat.name ?? ""),
                        backgroundColor: AppColors.premrayColor.withOpacity(
                          0.1,
                        ),
                        labelStyle: TextStyle(
                          color: AppColors.premrayColor,
                          fontSize: 12,
                        ),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              )
            else
              const Text("لا توجد تصنيفات"),

            const Divider(),
            _buildSectionTitle("روابط التواصل الاجتماعي"),
            if (influencer.socialMediaLinks != null &&
                influencer.socialMediaLinks!.isNotEmpty)
              Column(
                children: influencer.socialMediaLinks!
                    .map(
                      (link) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.link, color: Colors.blue),
                        title: Text(link.socialMedia?.name ?? "رابط"),
                        subtitle: Text(
                          link.urlOfSoical ?? "لا يوجد رابط",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                          ),
                        ),
                        dense: true,
                      ),
                    )
                    .toList(),
              )
            else
              const Text("لا توجد روابط مسجلة"),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsSection(String title, List<Report>? reports) {
    if (reports == null || reports.isEmpty) {
      return Card(
        color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(title),
              const Text("لا يوجد بلاغات."),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(title),
            ListView.separated(
              itemCount: reports.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (ctx, index) => const Divider(),
              itemBuilder: (context, index) {
                final report = reports[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    report.content ?? "لا يوجد محتوى",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "الحالة: ${_getReportStatusLabel(report.reportStatusId)}\nالتاريخ: ${_formatDate(report.createdAt)}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  isThreeLine: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: ui.TextDirection.rtl,
        child: AlertDialog(
          title: const Text(
            'حذف المستخدم نهائياً',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          content: Text(
            'هل أنت متأكد أنك تريد حذف المستخدم "${user.name}" نهائياً؟ لا يمكن التراجع عن هذا الإجراء.',
            style: const TextStyle(fontFamily: 'Cairo'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
            ),
            TextButton(
              onPressed: () async {
                final success = await ref
                    .read(adminNotifierProvider.notifier)
                    .deleteUser(user.id ?? 0);
                if (!context.mounted) return;
                Navigator.pop(ctx);
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم حذف المستخدم بنجاح')),
                  );
                  context.pop(); // Go back to the list
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('حدث خطأ أثناء حذف المستخدم')),
                  );
                }
              },
              child: const Text(
                'حذف',
                style: TextStyle(color: Colors.red, fontFamily: 'Cairo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getReportStatusLabel(int? id) {
    switch (id) {
      case 1:
        return 'قيد الانتظار';
      case 2:
        return 'تمت المراجعة';
      case 3:
        return 'تم الحل';
      case 4:
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "--";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
