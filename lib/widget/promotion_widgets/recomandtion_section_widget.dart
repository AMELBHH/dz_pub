import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';

class RecommendationsSection extends StatelessWidget {
  final Promotion promotion;

  const RecommendationsSection({required this.promotion});

  @override
  Widget build(BuildContext context) {
    final recommendations = promotion.recommendations ?? [];

    if (recommendations.isEmpty) return const SizedBox();

    return CardContainer(
      title: "التوصيات",
      child: Column(
        children: recommendations.map((rec) {
          return ListTile(
            title: Text(rec.text),
          );
        }).toList(),
      ),
    );
  }
}
