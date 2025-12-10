
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
import '../../../widget/promotion_widgets/movement_section_widget.dart';

class PromotionDetailsScreen extends ConsumerStatefulWidget {
  final Promotion? promotion;
  final String ?typeName;

  const PromotionDetailsScreen({
    super.key,
    this.promotion,
    this.typeName,

  });

  @override
  ConsumerState createState() => _PromotionDetailsScreenState();
}

class _PromotionDetailsScreenState
    extends ConsumerState<PromotionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(influencerNotifier.notifier)
          .getUserById(widget.promotion?.influencerId??0);


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
            ref.watch(influencerNotifier).isLoading||ref.read
              (influencerNotifier).userInfluencerModel == null ?
            CircularProgressIndicator() : InfluencerInfoCard(
              influencerModel: ref.read(influencerNotifier).userInfluencerModel,
            ),
            PromotionCardWidget(promotion: widget.promotion ?? Promotion(),
              isInDetailsScreen: true,
              textStyle: TextStyle(color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref)),),
            CardContainer(
                title: widget.typeName??"",
                child: FilesSection(promotion: widget.promotion ?? Promotion(),typeName: widget.typeName,)),
            ScriptSection(promotion: widget.promotion ?? Promotion(),
                typeName: widget.typeName,),
            TopicsSection(promotion: widget.promotion ?? Promotion()),
            RecommendationsSection(promotion: widget.promotion ?? Promotion()),
            MovementSection(promotion: widget.promotion ?? Promotion()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
