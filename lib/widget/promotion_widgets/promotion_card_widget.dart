import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/client/screens/client/list_of_client_promotions.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromotionCardWidget extends ConsumerStatefulWidget {
  final Promotion promotion;
  final TextStyle ?textStyle;
  final Color ?colorButton;
  final bool isInDetailsScreen;
  const PromotionCardWidget({super.key, required this.promotion,
    this.textStyle, this.colorButton, required this.isInDetailsScreen,});

  @override
  ConsumerState createState() => _PromotionCardWidgetState();
}

class _PromotionCardWidgetState extends ConsumerState<PromotionCardWidget> {
  @override




  @override
  Widget build(BuildContext context) {
    final Map<int, String> promotionStatuses = {
      1: 'قيد المناقشة في انتضار المنصة',
      2: 'قيد المناقشة في انتضار العميل',
      3: 'قيد المناقشة في انتضار المؤثر',
      4: 'قيد التسليم',
      5: 'مرفوضة',
      6: 'مُعترض عليها',
    };

    return CardContainer(
      title: "معلومات الإشهار",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("السعر: ${widget.promotion.price}"),
          Text("المدة: ${widget.promotion.timeLine}"),
          Text("يتطلب تنقل المؤثر: ${widget.promotion.shouldInfluencerMovement
              == "yes" ? "نعم":"لا"
          }"),
          Text("الحالة: ${promotionStatuses[widget.promotion.statusId] ?? 'غير '
              'معروف'}",
            style: widget.textStyle,
          ),
          SizedBox(height: 10,),
         widget. isInDetailsScreen ? SizedBox() :   Center(
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: CustomButtonWidget(
                  onPressd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PromotionDetailsScreen(
                          promotion: widget.promotion,

                        ),
                      ),
                    );
                  },
                  textStyle: TextStyle(fontSize: 18),
                  textButton: 'عرض التفاصيل',

                  colorButton:  AppColors.premrayColor,
                ),
              ),
            ),

          )
        ],
      ),
    );
  }
}

