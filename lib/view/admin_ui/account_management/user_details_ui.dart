import 'package:dz_pub/api/report.dart';
import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends ConsumerStatefulWidget {
  final int userId;
  const UserDetailsScreen({super.key, required this.userId});

  @override
  ConsumerState<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends ConsumerState<UserDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminNotifierProvider.notifier).getUserById(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);
    final user = state.selectedUser;

    // Check if we are loading or if the user loaded matches the requested ID
    // (Though usually we trust the notifier to clear/load correct one)
    final isLoading =
        state.isLoading ||
        (user?.id != widget.userId && state.errorMessage == null);

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المستخدم', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage!))
          : user == null
          ? const Center(child: Text('لم يتم العثور على بيانات المستخدم'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfoSection(user),
                  const SizedBox(height: 20),
                  if (user.typeId == 1 && user.client != null)
                    _buildClientSection(user.client!),
                  if (user.typeId == 2 && user.influencer != null)
                    _buildInfluencerSection(user.influencer!),
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
          SizedBox(
            width: 120,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? "غير متوفر",
              style: TextStyle(
                color: value == null
                    ? Colors.grey
                    : ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection(User user) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("معلومات أساسية"),
            _buildInfoRow("الاسم", user.name),
            _buildInfoRow("البريد الإلكتروني", user.email),
            _buildInfoRow("رقم الهاتف", user.userInfo?.phoneNumber),
            _buildInfoRow("رقم الهوية", user.userInfo?.identityNumber),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text(
                      "الحالة:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    user.isActive == 1 ? "نَشِط" : "محظور",
                    style: TextStyle(
                      color: user.isActive == 1 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeThumbColor: AppColors.premrayColor,
                      value: user.isActive == 1,
                      onChanged: (val) async {
                        if (user.id != null) {
                          await ref
                              .read(adminNotifierProvider.notifier)
                              .updateUserStatus(user.id!, val ? 1 : -1);
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
                  const SizedBox(
                    width: 120,
                    child: Text(
                      "موثق:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    user.userInfo?.isVerified == "yes" ? "نعم" : "لا",
                    style: TextStyle(
                      color: user.userInfo?.isVerified == "yes"
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
                      value: user.userInfo?.isVerified == "yes",
                      onChanged: (val) async {
                        if (user.id != null) {
                          await ref
                              .read(adminNotifierProvider.notifier)
                              .updateUserVerification(user.id!, val);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            _buildInfoRow("تاريخ الانضمام", _formatDate(user.createdAt)),
            _buildInfoRow(
              "نوع المستخدم",
              user.typeOfUser?.name ??
                  (user.typeId == 1
                      ? "عميل"
                      : (user.typeId == 2 ? "مؤثر" : "--")),
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
            if (client.clientWithCr != null) ...[
              const Divider(),
              Text(
                "تفاصيل السجل التجاري:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow(
                "اسم المؤسسة",
                client.clientWithCr?.institutionName,
              ),
              _buildInfoRow("اسم المالك", client.clientWithCr?.regOwnerName),
              _buildInfoRow("رقم السجل", client.clientWithCr?.rcNumber),
              _buildInfoRow("العنوان", client.clientWithCr?.institutionAddress),
            ],
            if (client.clientWithoutCr != null) ...[
              const Divider(),
              Text(
                "تفاصيل العميل (بدون سجل):",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _buildInfoRow("اللقب", client.clientWithoutCr?.nickname),
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
              "نوع التأثير",
              influencer.typeId == 1
                  ? "معنوي"
                  : (influencer.typeId == 2 ? "طبيعي" : "--"),
            ),
            _buildInfoRow("نبذة", influencer.bio),
            _buildInfoRow(
              "المجالات",
              influencer.categories?.map((e) => e.name).join(", "),
            ),
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
