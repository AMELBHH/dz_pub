import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';

class MovementSection extends StatelessWidget {
  final Promotion promotion;

  const MovementSection({super.key, required this.promotion});

  @override
  Widget build(BuildContext context) {
    if (promotion.movement == null) return const SizedBox();

    return CardContainer(
      title: "مكان التواجد",
      child: Text(promotion.movement?.location ?? "--"),
    );
  }
}
