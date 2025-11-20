
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';

class LastStep extends StatelessWidget {
  const LastStep({super.key});

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SafeArea(
      child: Scaffold(
        body: 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 ,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                
              SizedBox(height: height * 0.05),
              Text('صحيح ان الاشهار يتم من المؤثر والمحتوى من المعلن ' ,style: AppTextStyle.black19,),
              SizedBox(height: height * 0.03),
              Text('لكن ادراج ضمن اعلان ذات طابع ناجح من (تنسيق ....)ذالك يتم عن طريق اشخاص ذات احترافية عالية ',style: AppTextStyle.descriptionText,),
              SizedBox(height: height * 0.02),
              Text('هل تريد الاستفادة من خدمات المنصة بمقابل ضئيل مقارنة مع الفوائد والطابع ان وافقت سيتم التواصل معك هاتفيا او عن طريق الرسائل ',style: AppTextStyle.descriptionText,),
              SizedBox(height: height * 0.08),
              CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.listTextStyle, textButton:'المواصلة مع الموافقة على خدمات المنصة', heigth:height*0.07 , width: width*0.9, radius: 180, colorButton: AppColors.premrayColor),
             SizedBox(height: height * 0.01),
              CustomButtonWidget(onPressd: (){}, textStyle: AppTextStyle.listTextStyle, textButton:'المواصلة دون الحصول على خدمات المنصة', heigth:height*0.07 , width: width*0.9, radius: 180, colorButton: AppColors.premrayColor)
          
            
            ],
          ),
        ),
      ),
    );
  }
}