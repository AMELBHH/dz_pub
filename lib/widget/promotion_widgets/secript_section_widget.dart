import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';

class ScriptSection extends StatelessWidget {
  final Promotion ?promotion;
  final String ?typeName;
  const ScriptSection({super.key,  this.promotion,this.typeName});

  @override
  Widget build(BuildContext context) {


    return CardContainer(
      title: "نص $typeName"?? "النص المطلوب",
      child: Text(promotion?.requirements??""),
    );
  }
}
