import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/promotion_widgets/promotion_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PromotionsManagementScreen extends ConsumerStatefulWidget {
  const PromotionsManagementScreen({super.key});

  @override
  ConsumerState<PromotionsManagementScreen> createState() =>
      _PromotionsManagementScreenState();
}

class _PromotionsManagementScreenState
    extends ConsumerState<PromotionsManagementScreen> {
  int? selectedStatusId;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(adminNotifierProvider.notifier).getAllPromotions();
    });
  }

  void filterPromotions(int? statusId) {
    setState(() {
      selectedStatusId = statusId;
    });
    if (statusId == null) {
      ref.read(adminNotifierProvider.notifier).getAllPromotions();
    } else if (statusId == -1) {
      ref.read(adminNotifierProvider.notifier).getAllCustomPromotions();
    } else {
      ref
          .read(adminNotifierProvider.notifier)
          .getPromotionsByStatusIdForAdmin(statusId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة الحملات الإعلانية', style: AppTextStyle.textStyle),
        centerTitle: true,
        backgroundColor: AppColors.premrayColor,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.errorMessage!, style: AppTextStyle.black19),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => filterPromotions(selectedStatusId),
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  )
                : (state.promotions.isEmpty && state.customPromotions.isEmpty)
                ? const Center(child: Text('لا توجد حملات إعلانية حالياً'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: selectedStatusId == -1
                        ? state.customPromotions.length
                        : state.promotions.length,
                    itemBuilder: (context, index) {
                      if (selectedStatusId == -1) {
                        final customPromotion = state.customPromotions[index];
                        return _buildCustomPromotionCard(customPromotion);
                      }
                      final promotion = state.promotions[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            context.push(
                              AppRoutes.promotionDetails,
                              extra: promotion,
                            );
                          },
                          child: PromotionCardWidget(
                            promotion: promotion,
                            isInDetailsScreen: false,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    final filters = {
      null: 'الكل',
      1: 'قيد المنصة',
      2: 'قيد العميل',
      3: 'قيد المؤثر',
      4: 'قيد التسليم',
      5: 'مرفوضة',
      6: 'مُعترض عليها',
      -1: 'إشهارات مخصصة',
    };

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: filters.entries.map((e) {
          final isSelected = selectedStatusId == e.key;
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ChoiceChip(
              label: Text(
                e.value,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 12,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.premrayColor,
              onSelected: (_) => filterPromotions(e.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCustomPromotionCard(CustomPromotion customPromotion) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'إشهار مخصص #${customPromotion.id ?? ""}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (customPromotion.createdAt != null)
                  Text(
                    customPromotion.createdAt!.split('T').first,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              customPromotion.text ?? "",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            if (customPromotion.client != null) ...[
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'العميل: ${customPromotion.client?.user?.name ?? "ID: ${customPromotion.clientId}"}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if (customPromotion.client?.user?.email != null)
                          Text(
                            customPromotion.client!.user!.email!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
