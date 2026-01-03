import 'package:dz_pub/api/advertisement.dart';
import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/view/admin_ui/widgets/media_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AdvertisementsManagementUi extends ConsumerStatefulWidget {
  const AdvertisementsManagementUi({super.key});

  @override
  ConsumerState<AdvertisementsManagementUi> createState() =>
      _AdvertisementsManagementUiState();
}

class _AdvertisementsManagementUiState
    extends ConsumerState<AdvertisementsManagementUi> {
  String? _isVerified;
  int? _typeId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAdvertisements();
    });
  }

  void _fetchAdvertisements() {
    if (_isVerified == null && _typeId == null) {
      ref.read(adminNotifierProvider.notifier).getAdvertisements();
    } else {
      ref
          .read(adminNotifierProvider.notifier)
          .getAdvertisementsByVerification(
            isVerified: _isVerified,
            typeId: _typeId,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة الإعلانات', style: AppTextStyle.textStyle),
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
              setState(() {
                if (value == 'all') {
                  _isVerified = null;
                  _typeId = null;
                } else if (value == 'client_verified') {
                  _isVerified = 'yes';
                  _typeId = 1;
                } else if (value == 'client_unverified') {
                  _isVerified = 'no';
                  _typeId = 1;
                } else if (value == 'influencer_verified') {
                  _isVerified = 'yes';
                  _typeId = 2;
                } else if (value == 'influencer_unverified') {
                  _isVerified = 'no';
                  _typeId = 2;
                }
                _fetchAdvertisements();
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'all',
                child: Text(
                  'الكل',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'client_verified',
                child: Text(
                  'عملاء موثقون',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'client_unverified',
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
                value: 'influencer_verified',
                child: Text(
                  'مؤثرون موثقون',
                  style: TextStyle(
                    color: ref
                        .read(themeModeNotifier.notifier)
                        .textTheme(ref: ref),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'influencer_unverified',
                child: Text(
                  'مؤثرون غير موثقين',
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
          : state.advertisements.isEmpty
          ? const Center(child: Text('لا توجد إعلانات تطابق البحث'))
          : RefreshIndicator(
              onRefresh: () async => _fetchAdvertisements(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.advertisements.length,
                itemBuilder: (context, index) {
                  final ad = state.advertisements[index];
                  return _buildAdCard(ad);
                },
              ),
            ),
    );
  }

  Widget _buildAdCard(Advertisement ad) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          if (ad.promotion != null) {
            context.pushNamed(AppRoutes.promotionDetails, extra: ad.promotion);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('لا توجد بيانات تفصيلية لهذا الإعلان'),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ad.filePath != null && ad.filePath!.isNotEmpty)
              MediaPreviewWidget(ad: ad),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.ads_click, color: AppColors.premrayColor),
                      const SizedBox(width: 10),
                      Text(
                        'إعلان رقم: ${ad.id}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () => _showDeleteConfirmation(ad),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(ad.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    ad.description ?? 'بدون وصف',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.campaign,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'حملة رقم: ${ad.promotionId}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'عرض التفاصيل >',
                        style: TextStyle(
                          color: AppColors.premrayColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(Advertisement ad) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تأكيد الحذف',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل أنت متأكد من حذف الإعلان رقم ${ad.id} نهائياً؟',
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Cairo')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'حذف',
              style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      final success = await ref
          .read(adminNotifierProvider.notifier)
          .deleteAdvertisement(ad.id!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'تم حذف الإعلان بنجاح' : 'فشل حذف الإعلان',
              style: const TextStyle(fontFamily: 'Cairo'),
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
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
