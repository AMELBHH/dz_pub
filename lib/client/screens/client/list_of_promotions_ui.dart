import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/widget/promotion_widgets/promotion_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ListOfPromotions extends ConsumerStatefulWidget {
  const ListOfPromotions({super.key, this.statusId, this.title});
  final int ?statusId;
  final String ?title;

  @override
  ConsumerState createState() => _ListOfClientPromotionsState();
}

class _ListOfClientPromotionsState
    extends ConsumerState<ListOfPromotions> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_)async {
     await ref.read(promotionProvider.notifier).getPromotionsOfClient(statusId: widget.statusId);
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title??"إشهاراتي"),
      ),
      body: FutureBuilder<List<Promotion>>(
        future: ref.watch(promotionProvider).promotions,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          if (snapshot.hasData) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text("لا يوجد إشهارات"));
            }
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
