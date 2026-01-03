import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/controllers/providers/influencer_provider.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/influencer_card_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/promotion_card_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/recomandtion_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/secript_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/topic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widget/promotion_widgets/file_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/movement_section_widget.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/admin_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';

class PromotionDetailsScreen extends ConsumerStatefulWidget {
  final Promotion? promotion;
  final String? typeName;

  const PromotionDetailsScreen({super.key, this.promotion, this.typeName});

  @override
  ConsumerState createState() => _PromotionDetailsScreenState();
}

class _PromotionDetailsScreenState
    extends ConsumerState<PromotionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(influencerNotifier.notifier)
          .getUserById(widget.promotion?.influencerId ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تفاصيل الإشهار")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   ClientInfoCard(),
            ref.watch(influencerNotifier).isLoading ||
                    ref.read(influencerNotifier).userInfluencerModel == null
                ? CircularProgressIndicator()
                : InfluencerInfoCard(
                    influencerModel: ref
                        .read(influencerNotifier)
                        .userInfluencerModel,
                  ),
            PromotionCardWidget(
              promotion: widget.promotion ?? Promotion(),
              isInDetailsScreen: true,
              textStyle: TextStyle(
                color: ref
                    .read(themeModeNotifier.notifier)
                    .primaryTheme(ref: ref),
              ),
            ),
            CardContainer(
              title: widget.typeName ?? "",
              child: FilesSection(
                promotion: widget.promotion ?? Promotion(),
                typeName: widget.typeName,
              ),
            ),
            ScriptSection(
              promotion: widget.promotion ?? Promotion(),
              typeName: widget.typeName,
            ),
            TopicsSection(promotion: widget.promotion ?? Promotion()),
            RecommendationsSection(promotion: widget.promotion ?? Promotion()),
            MovementSection(promotion: widget.promotion ?? Promotion()),
            if (NewSession.get(PrefKeys.userType, '') == 'admin') ...[
              _AdminStatusAction(promotion: widget.promotion!),
            ],
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _AdminStatusAction extends ConsumerStatefulWidget {
  final Promotion promotion;
  const _AdminStatusAction({required this.promotion});

  @override
  ConsumerState<_AdminStatusAction> createState() => _AdminStatusActionState();
}

class _AdminStatusActionState extends ConsumerState<_AdminStatusAction> {
  int? _selectedStatusId;

  final Map<int, String> _statuses = {
    1: 'قيد المناقشة في انتضار المنصة',
    2: 'قيد المناقشة في انتضار العميل',
    3: 'قيد المناقشة في انتضار المؤثر',
    4: 'قيد التسليم',
    5: 'مرفوضة',
    6: 'مُعترض عليها',
  };

  @override
  void initState() {
    super.initState();
    _selectedStatusId = widget.promotion.statusId;
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      title: "تغيير حالة الإشهار (مسؤول)",
      child: Column(
        children: [
          DropdownButtonFormField<int>(
            value: _statuses.containsKey(_selectedStatusId)
                ? _selectedStatusId
                : null,
            decoration: const InputDecoration(
              labelText: 'حالة الإشهار',
              border: OutlineInputBorder(),
            ),
            items: _statuses.entries.map((e) {
              return DropdownMenuItem<int>(
                value: e.key,
                child: Text(e.value, style: AppTextStyle.titel),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                _selectedStatusId = val;
              });
            },
          ),
          const SizedBox(height: 0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.premrayColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed:
                  _selectedStatusId == null ||
                      _selectedStatusId == widget.promotion.statusId
                  ? null
                  : () async {
                      final success = await ref
                          .read(adminNotifierProvider.notifier)
                          .updatePromotionStatus(
                            widget.promotion.id!,
                            _selectedStatusId!,
                          );
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? 'تم تحديث الحالة بنجاح'
                                  : 'فشل تحديث الحالة',
                              style: const TextStyle(fontFamily: 'Cairo'),
                            ),
                            backgroundColor: success
                                ? Colors.green
                                : Colors.red,
                          ),
                        );
                      }
                    },
              child: const Text(
                'تحديث الحالة',
                style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
