import 'package:dz_pub/api/advertisement.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/view/admin_ui/widgets/media_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ClientAdvertisementsScreen extends ConsumerStatefulWidget {
  const ClientAdvertisementsScreen({super.key});

  @override
  ConsumerState<ClientAdvertisementsScreen> createState() =>
      _ClientAdvertisementsScreenState();
}

class _ClientAdvertisementsScreenState
    extends ConsumerState<ClientAdvertisementsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(promotionProvider.notifier).getAdvertisementsByClient();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(promotionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('إعلاناتي', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Advertisement>>(
              future: state.advertisements,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('خطأ: ${snapshot.error}'));
                }
                final advertisements = snapshot.data ?? [];
                if (advertisements.isEmpty) {
                  return const Center(child: Text('لا توجد إعلانات لديك'));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(promotionProvider.notifier)
                        .getAdvertisementsByClient();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: advertisements.length,
                    itemBuilder: (context, index) {
                      final ad = advertisements[index];
                      return _buildAdCard(ad);
                    },
                  ),
                );
              },
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
