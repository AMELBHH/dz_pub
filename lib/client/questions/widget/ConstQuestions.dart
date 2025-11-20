import 'package:dz_pub/client/questions/widget/SelectableItem.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:dz_pub/widget/Text_Field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConstQuestions extends StatefulWidget {
  final String text1;
  final String text2;
  const ConstQuestions({super.key, required this.text1 ,required this.text2});

  @override
  State<ConstQuestions> createState() => _ConstQuestionsState();
}

class _ConstQuestionsState extends State<ConstQuestions> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
       
        Text(widget.text1, style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        TextFieldwidget(
          hintText: widget.text2,
          textInputType: TextInputType.text,
          maxLines: 4,
          suffixIcon: Icon(Icons.attach_file),
        ),
        SizedBox(height: height * 0.02),
        Text('حدد اشكال اشهارك :', style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        SelectableItem(
         label: 'ريلز',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),  SizedBox(height: height * 0.01),
        SelectableItem(
         label:' منشور',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),  SizedBox(height: height * 0.01),
        SelectableItem(
         label:'ستوري',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),
                
            SizedBox(height: height * 0.02),
           
            Text('حدد المنصات :', style: AppTextStyle.black19),

             SizedBox(height: height * 0.02),
        SelectableItem(
         label: 'يوتيوب',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),  SizedBox(height: height * 0.01),
        SelectableItem(
         label:'توتر',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),  SizedBox(height: height * 0.01),
        SelectableItem(
         label:'تيك توك',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),SizedBox(height: height * 0.01),
                     SelectableItem(
         label:'انستغرام',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),SizedBox(height: height * 0.01),
                     SelectableItem(
         label:'فيسبوك',
         onChanged: (selected) {
           print('الحالة الآن: $selected');
         },
                    ),
                    
          SizedBox(height: height * 0.02),
            SizedBox(height: height * 0.02),
            Text('المبلغ المخصص :', style: AppTextStyle.black19),
            SizedBox(height: height * 0.02),
            TextFieldwidget(
              hintText: 'ادخل المبلغ الذي تخصصه لهذا الاشهار',
              textInputType: TextInputType.number,
              maxLength: 100,
            ),
            SizedBox(height: height * 0.02),
            Text('الوقت المستغرق :', style: AppTextStyle.black19),
            SizedBox(height: height * 0.02),
            TextFieldwidget(
              hintText: 'مثلا : اسبوع',
              textInputType: TextInputType.number,
              maxLength: 100,
            ),
            SizedBox(height: height * 0.06),
              Center(
                  child: CustomButtonWidget(
                    onPressd: () {
                      setState(() {
                       
                        context.pushNamed(AppRoutes.lastStep);
                      });
                    },
                    textStyle: AppTextStyle.textpurpal,
                    textButton: 'ارسال',
                    heigth: height * 0.03,
                    width: width * 0.4,
                    radius: 8,
                    colorButton: AppColors.grey,
                  ),
                ),
      ]    
            
          
        );
  }
}


