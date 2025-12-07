import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/controllers/providers/influencer_provider.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/client_card_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/influencer_card_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/movement_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/promotion_card_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/recomandtion_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/secript_section_widget.dart';
import 'package:dz_pub/widget/promotion_widgets/topic_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ListOfClientPromotions extends ConsumerStatefulWidget {
  const ListOfClientPromotions({super.key});

  @override
  ConsumerState createState() => _ListOfClientPromotionsState();
}

class _ListOfClientPromotionsState
    extends ConsumerState<ListOfClientPromotions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(promotionProvider.notifier).getPromotionsOfClient();


    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Promotion>>(
        future: ref.watch(promotionProvider).promotions,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                //
                // ref.read(influencerNotifier.notifier).getUserById(
                //     snapshot.data?[index].influencerId??0
                // );


                return PromotionCardWidget(promotion: snapshot
                    .data?[index]??Promotion() ,

                isInDetailsScreen: false,
                textStyle: TextStyle(color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref)),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ));

  }
}

class PromotionDetailsScreen extends ConsumerStatefulWidget {
  final Promotion? promotion;

  const PromotionDetailsScreen({
    super.key,
    this.promotion,
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
      appBar: AppBar(title: Text("تفاصيل العرض")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClientInfoCard(),
            ref.watch(influencerNotifier).isLoading||ref.read
              (influencerNotifier).userInfluencerModel == null ?
            CircularProgressIndicator() : InfluencerInfoCard(
              influencerModel: ref.read(influencerNotifier).userInfluencerModel,
            ),
            PromotionCardWidget(promotion: widget.promotion ?? Promotion(),
              isInDetailsScreen: true,
              textStyle: TextStyle(color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref)),),
            ScriptSection(promotion: widget.promotion ?? Promotion()),
            //FilesSection(promotion: promotion),
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

// class PromotionDetailsScreen extends StatelessWidget {
//   final Promotion? promotion;
//   final Client ?clientModel;
//   final Influencer ?influencerModel;
//
//   const PromotionDetailsScreen({super.key,  this.promotion,
//      this.clientModel,  this.influencerModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("تفاصيل العرض"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClientInfoCard(clientModel: clientModel??Client()),
//             InfluencerInfoCard(influencerModel: influencerModel??Influencer()),
//             MainInfoCard(promotion: promotion??Promotion()),
//             ScriptSection(promotion: promotion??Promotion()),
//             //FilesSection(promotion: promotion),
//             TopicsSection(promotion: promotion??Promotion()),
//             RecommendationsSection(promotion: promotion??Promotion()),
//             MovementSection(promotion: promotion??Promotion()),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
