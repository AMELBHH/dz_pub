import 'package:dz_pub/client/questions/widget/SelectableItem.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:dz_pub/widget/Text_Field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConstQuestions extends ConsumerStatefulWidget {
  const ConstQuestions({
    super.key,
    required this.text1,
    required this.text2,
     this.textFormFieldController,
    this.alsoHaveDetails



  });

  final String text1;
  final String text2;
  final TextEditingController? textFormFieldController;

  final bool ?alsoHaveDetails;

  @override
  ConsumerState createState() => _ConstQuestionsState();
}

class _ConstQuestionsState extends ConsumerState<ConstQuestions> {
  List<_SocialMediaPromationType> postTypes = [
    _SocialMediaPromationType(id: 1, label: "منشور"),
    _SocialMediaPromationType(id: 2, label: "ريلز"),
    _SocialMediaPromationType(id: 3, label: "ستوري"),
  ];
  List<SocialMediaItem> socialMediaItems = [
    SocialMediaItem(id: 1, label: "فيسبوك"),
    SocialMediaItem(id: 2, label: "انستغرام"),
    SocialMediaItem(id: 3, label: "تيك توك"),
    SocialMediaItem(id: 4, label: "يوتيوب"),
    SocialMediaItem(id: 5, label: "تويتر | X"),
  ];
  @override
  Widget build(BuildContext context) {
    final postTypeIds = ref.read(postTypeIdsProvider);
    final socialMediaIds = ref.read(socialMediaIdsProvider);

  final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text1, style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        TextFieldWidget(
          controller: widget.textFormFieldController??ref.read
            (requirementsController),
          hintText: widget.text2,
          textInputType: TextInputType.text,
          maxLines: 4,
          suffixIcon: Icon(Icons.attach_file),
        ),        SizedBox(height: height * 0.02),

    widget.alsoHaveDetails??false ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text("اكتب اي توصية او تفاصيل", style: AppTextStyle.black19),
            SizedBox(height: height * 0.02),
            TextFieldWidget(
              controller: ref.read(detailsController),
              hintText:"تفاصيل",
              textInputType: TextInputType.text,
              maxLines: 4,
              suffixIcon: Icon(Icons.attach_file),
            ),
          ],
        ):
        SizedBox(),
        SizedBox(height: height * 0.02),
        Text('حدد اشكال اشهارك :', style: AppTextStyle.black19),
        Column(
          children: postTypes.map((item) {
            return Column(
              children: [
                SelectableItem(
                  label: item.label,
                  onChanged: (selected) {
                    setState(() {
                      item.selected = selected;
                    });
                    if (item.selected) {
                   postTypeIds.add(item.id);
                    } else {
                      // Remove the id
                     postTypeIds.remove(item.id);
                    }
                    debugPrint("${item.label} = $selected");
                  },
                ),
                SizedBox(height: height * 0.01),
              ],
            );
          }).toList(),
        ),

        SizedBox(height: height * 0.02),

        Text('حدد المنصات :', style: AppTextStyle.black19),

        SizedBox(height: height * 0.02),
        Column(
          children: socialMediaItems.map((socialItem) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // selectable item
                SelectableItem(
                  label: socialItem.label,
                  onChanged: (selected) {
                    setState(() {
                      socialItem.selected = selected;
                    });
                    if (socialItem.selected) {
                      socialMediaIds.add(socialItem.id);
                      debugPrint(
                        "social media selected $socialMediaIds",
                      );
                    } else {
                      socialMediaIds.remove(socialItem.id);
                    }
                  },
                ),

                SizedBox(height: height * 0.01),

              ],
            );
          }).toList(),
        ),
        SizedBox(height: height * 0.02),
        SizedBox(height: height * 0.02),
        Text('المبلغ المخصص :', style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        TextFieldWidget(
          controller: ref.read(priceController),
          hintText: 'ادخل المبلغ الذي تخصصه لهذا الاشهار',
          textInputType: TextInputType.number,
          maxLength: 100,
        ),
        SizedBox(height: height * 0.02),
        Text('الوقت المستغرق :', style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        TextFieldWidget(
          controller: ref.read(timeLineController),
          hintText: 'مثلا : اسبوع',
          textInputType: TextInputType.text,
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
      ],
    );
  }
}

class _SocialMediaPromationType {
  final int id;
  final String label;
  bool selected;

  _SocialMediaPromationType({
    required this.id,
    required this.label,
    this.selected = false,
  });
}

class SocialMediaItem {
  final int id; // your index
  bool selected; // if user selected it
  final String label; // name

  SocialMediaItem({
    required this.id,
    required this.label,
    this.selected = false,
  });
}
