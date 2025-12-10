import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:dz_pub/widget/Text_Field_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomPromotion extends ConsumerWidget {
  const CustomPromotion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final size = MediaQuery.of(context).size;
    //  final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(title: Text('ترويج حسب الطلب')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.1),

              TextFieldWidget(
                controller: ref.read(customPromotionController),
                hintText:
                'دمج المؤثرين /n تريد منا ان نقترح لك مؤثرا يليق بفكرتك ومنتجك',
                textInputType: TextInputType.text,
                maxLines: 10,
                suffixIcon: const Icon(Icons.attach_file),
              ),

              SizedBox(height: height * 0.16),
              CustomButtonWidget(
                onPressd: ()async {
                  await ref.read(promotionProvider.notifier).createCustomPromotion(
                    text: ref.read(customPromotionController).text,
                  );

                  if(ref.read(promotionProvider).hasError){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "فشلت "
                        "علمية الإرسال، يرجى التأكد من صحة البيانات");
                  }else if(ref.read(promotionProvider).hasError == false){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "تم "
                        "إنشاء إشهارك بنجاح 🎉");
                  }                },
                textStyle: AppTextStyle.listTextStyle,
                textButton: 'ارسال',
                colorButton: AppColors.premrayColor,
                heigth: height * 0.06,
              ),
            ],
          ),
        ),
      ),
    );
  }

}