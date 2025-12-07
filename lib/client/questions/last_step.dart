import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LastStep extends ConsumerWidget {
  const LastStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              Text(
                'صحيح ان الاشهار يتم من المؤثر والمحتوى من المعلن ',
                style: AppTextStyle.black19,
              ),
              SizedBox(height: height * 0.03),
              Text(
                'لكن ادراج ضمن اعلان ذات طابع ناجح من (تنسيق ....)ذالك يتم عن طريق اشخاص ذات احترافية عالية ',
                style: AppTextStyle.descriptionText,
              ),
              SizedBox(height: height * 0.02),
              Text(
                'هل تريد الاستفادة من خدمات المنصة بمقابل ضئيل مقارنة مع الفوائد والطابع ان وافقت سيتم التواصل معك هاتفيا او عن طريق الرسائل ',
                style: AppTextStyle.descriptionText,
              ),
              SizedBox(height: height * 0.08),
              CustomButtonWidget(
                onPressd: () async {
                  await createPromotion(ref: ref);
                  debugPrint("the client id is ${NewSession.get(PrefKeys.id,
                      0)}");
                  debugPrint("notifier have error ? : ${ref.read
                    (promotionProvider).hasError}, message : ${ref.read
                    (promotionProvider).errorMessage}"

                      " ");
                  if(ref.read(promotionProvider).hasError){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "فشلت "
                        "علمية الإرسال، يرجى التأكد من صحة البيانات");
                  }else if(ref.read(promotionProvider).hasError == false){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "تم "
                        "إنشاء إشهارك بنجاح 🎉");
                  }
                },
                textStyle: AppTextStyle.listTextStyle,
                textButton: 'المواصلة مع الموافقة على خدمات المنصة',
                heigth: height * 0.07,
                width: width * 0.9,
                radius: 180,
                colorButton: AppColors.premrayColor,
              ),
              SizedBox(height: height * 0.01),
              CustomButtonWidget(
                onPressd: () async {
                  await createPromotion(ref: ref);
                  if(ref.read(promotionProvider).status == false){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "فشلت "
                        "علمية الإرسال، يرجى التأكد من صحة البيانات");
                  }else if(ref.read(promotionProvider).status){
                    ref.read(showSnackBarNotifier.notifier)
                        .showNormalSnackBar(context: context,message: "تم "
                        "إنشاء إشهارك بنجاح 🎉");
                  }
                },
                textStyle: AppTextStyle.listTextStyle,
                textButton: 'المواصلة دون الحصول على خدمات المنصة',
                heigth: height * 0.07,
                width: width * 0.9,
                radius: 180,
                colorButton: AppColors.premrayColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPromotion({required WidgetRef ref}) {
    return ref
        .read(promotionProvider.notifier)
        .createPromotion(
          clientId: NewSession.get(PrefKeys.id, 0),
          influencerId: ref.read(influencerIdProvider),
          requirements: ref.read(requirementsController.notifier).state.text,
          price:
              double.tryParse(ref.read(priceController.notifier).state.text) ??
              0,
          timeLine: ref.read(timeLineController.notifier).state.text,
          shouldInfluencerMovement: ref.read(shouldInfluencerMovementProvider),
          //statusId: ref.read(statusIdProvider),
          socialMediaIds: ref.read(socialMediaIdsProvider),
          socialMediaTypes: ref.read(postTypeIdsProvider),
          location: ref.read(locationController.notifier).state.text,
          // fileOfTopic: ref.read(fileOfTopicProvider),
          mediaFile: ref.read(fileOfTopicProvider),
          promationTypeId: ref.read(promotionTypeProvider),
          haveAForm: ref.read(haveAFormProvider),
          haveSmaple: ref.read(haveSampleProvider),
          topicIsReady: ref.read(isTopicReadyProvider),
          detials: ref.read(detailsController.notifier).state.text,
        );
  }

}
