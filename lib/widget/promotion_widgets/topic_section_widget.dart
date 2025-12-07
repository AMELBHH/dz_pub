import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
class TopicsSection extends StatelessWidget {
  final Promotion promotion;

  const TopicsSection({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    final topics = promotion.topicFromInfluancers ?? [];

    if (topics.isEmpty) return const SizedBox();

    return CardContainer(
      title: "المواضيع",
      child: Column(
        children: topics.map((topic) {
          return ListTile(
            title: Text("هل يتطلب عينة :  ${topic.haveSample == "yes" ? "نعم" :
            "لا"
            }"),
            subtitle: Text(topic.detials),
          );
        }).toList(),
      ),
    );
  }
}
