import 'dart:io';

import 'package:dz_pub/client/questions/widget/ConstQuestions.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:dz_pub/widget/Text_Field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/coordination.dart';
import '../../constants/get_it_controller.dart';
import '../../controllers/providers/color_provider.dart';

class CustomDropdownQuestion extends StatelessWidget {
  final String questionText;
  final String hintText;
  final String? selectedValue;
  final List<DropdownMenuEntry<String>> items;
  final ValueChanged<String?> onSelected;

  const CustomDropdownQuestion({
    super.key,
    required this.questionText,
    required this.hintText,
    required this.items,
    required this.onSelected,
    this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.03),
        Text(questionText, style: AppTextStyle.black19),
        SizedBox(height: height * 0.02),
        DropdownMenu<String>(
          width: width * 0.9,
          hintText: hintText,
          initialSelection: selectedValue,
          dropdownMenuEntries: items,
          onSelected: onSelected,
        ),
      ],
    );
  }
}

class DynamicQuestionScreen extends ConsumerStatefulWidget {
  const DynamicQuestionScreen({super.key});

  @override
  ConsumerState createState() => _DynamicScreenState();
}

class _DynamicScreenState extends ConsumerState<DynamicQuestionScreen> {
  String? selectedAnswer;
  String? selectedAnswer1;
  String? selectedAnswer2;
  String? selectedAnswer3;
  String? selectedAnswer4;
  String? selectedAnswer5;
  String? selectedAnswer6;

  int getPromotionTypeId(String value) {
    switch (value) {
      case 'فيديو':
        return 1;
      case 'صورة':
        return 2;
      case 'كتابة':
        return 3;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('ابدء اشهارك الان')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 4),
        child: ListView(
          children: [
            /// السؤال الأول
            CustomDropdownQuestion(
              questionText: 'هل يتطلب اعلانك تنقل المؤثر ؟',
              hintText: 'اختر الجواب المناسب ',
              selectedValue: selectedAnswer,
              items: const [
                DropdownMenuEntry(
                  value: 'نعم',
                  label: 'نعم يتطلب اعلاني تنقل المؤثر',
                ),
                DropdownMenuEntry(
                  value: 'لا',
                  label: 'لا لايتطلب اعلاني تنقل المؤثر',
                ),
              ],
              onSelected: (value) {
                setState(() {
                  selectedAnswer = value;
                  selectedAnswer1 = selectedAnswer2 = selectedAnswer3 =
                      selectedAnswer4 = null;
                });
                if (value == "نعم") {
                  ref.read(shouldInfluencerMovementProvider.notifier).state =
                      "yes";
                } else {
                  ref.read(shouldInfluencerMovementProvider.notifier).state =
                      "no";
                }
              },
            ),

            /// إذا كانت الإجابة نعم
            if (selectedAnswer == 'نعم') ...[
              SizedBox(height: height * 0.03),
              Text('بتنقل المؤثر :', style: AppTextStyle.black19),
              SizedBox(height: height * 0.03),
              TextFieldWidget(
                hintText: 'عنوان حضور المؤثر',
                textInputType: TextInputType.text,
                maxLength: 50,
                controller: ref.read(locationController),
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
              ConstQuestions(
                text1: 'اكتب المطلوب من المؤثر:',
                text2:
                    'اكتب ما الذي سيفعله المؤثر عند وصوله لمكان تسجيل الاشهار مع ذكر تاريخ الحضور وكل ما هو مهم ',
              ),
            ],

            /// إذا كانت الإجابة لا
            if (selectedAnswer == 'لا') ...[
              CustomDropdownQuestion(
                questionText: 'اختر طريقة تسجيل اشهارك',
                hintText: 'اختر الجواب المناسب ',
                selectedValue: selectedAnswer1,
                items: const [
                  DropdownMenuEntry(
                    value: 'التسجيل حسب النموذج',
                    label: 'التسجيل حسب النموذج',
                  ),
                  DropdownMenuEntry(
                    value: 'كتابة المطلوب مباشرة',
                    label: 'كتابة المطلوب مباشرة',
                  ),
                ],
                onSelected: (value) {
                  setState(() {
                    selectedAnswer1 = value;
                    selectedAnswer2 = selectedAnswer3 = selectedAnswer4 = null;
                  });
                  if (selectedAnswer1 == 'التسجيل حسب النموذج') {
                    ref.read(haveAFormProvider.notifier).state = "yes";
                  } else {
                    ref.read(haveAFormProvider.notifier).state = "no";
                  }
                },
              ),
            ],

            /// التسجيل حسب النموذج
            if (selectedAnswer1 == 'التسجيل حسب النموذج') ...[
              CustomDropdownQuestion(
                questionText: 'اختر نوع اشهارك',
                hintText: 'اختر الجواب المناسب ',
                selectedValue: selectedAnswer2,
                items: const [
                  DropdownMenuEntry(value: 'صورة', label: 'صورة'),
                  DropdownMenuEntry(value: 'فيديو', label: 'فيديو'),
                  DropdownMenuEntry(value: 'كتابة', label: 'كتابة'),
                ],
                onSelected: (value) {
                  setState(() {
                    selectedAnswer2 = value;
                    selectedAnswer3 = selectedAnswer4 = selectedAnswer5 =
                        selectedAnswer6 = null;
                  });

                  final id = getPromotionTypeId(value!);

                  ref.read(promotionTypeProvider.notifier).state = id;
                },
              ),

              /// كتابة
              if (selectedAnswer2 == 'كتابة') ...[
                Text("اكتب اي توصية او تفاصيل", style: AppTextStyle.black19),

                SizedBox(height: height * 0.03),
                ConstQuestions(
                  text1: 'اكتب نص المنشور كما تريده ان ينشر',
                  text2: 'ايموجي وصوالح اخرى',
                  alsoHaveDetails: true,
                ),
              ],

              /// صورة
              if (selectedAnswer2 == 'صورة') ...[
                CustomDropdownQuestion(
                  questionText: 'هل صورة اعلانك',
                  hintText: 'اختر الجواب المناسب ',
                  selectedValue: selectedAnswer3,
                  items: const [
                    DropdownMenuEntry(
                      value: 'الصورة جاهزة',
                      label: 'الصورة جاهزة',
                    ),
                    DropdownMenuEntry(
                      value: 'الصورة من انشاء المؤثر',
                      label: 'الصورة من انشاء المؤثر',
                    ),
                  ],
                  onSelected: (value) {
                    setState(() => selectedAnswer3 = value);
                    //topic_is_ready
                    if (value == "الصورة جاهزة") {
                      ref.read(isTopicReadyProvider.notifier).state = "yes";
                    } else {
                      ref.read(isTopicReadyProvider.notifier).state = "no";
                    }
                  },
                ),

                if (selectedAnswer3 == 'الصورة جاهزة') ...[
                  SizedBox(height: height * 0.03),
                  CustomButtonWidget(
                    onPressd: () async {
                      final ImagePicker picker = ImagePicker();

                      // pick image only
                      final XFile? picked =
                      await picker.pickImage(source: ImageSource.gallery);

                      if (picked != null) {
                        final file = File(picked.path);

                        ref.read(fileOfTopicProvider.notifier).state = file;
                        ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(
                          context: context,
                          message: "تم إضافة الصورة بنجاح",
                        );     }

                    },
                    textStyle: AppTextStyle.black19,
                    textButton: '+ اضف الصورة هنا',
                    heigth: height * 0.09,
                    width: width * 0.6,
                    radius: 12,
                    colorButton: AppColors.premrayColor2,
                  ),
                  SizedBox(height: height * 0.03),
                  ConstQuestions(
                    text1: 'اكتب الكتابة المرفقة للصورة كما تريدها ان تضهر ',
                    text2: 'اكتب الكتابة المرفقة للصورة كما تريدها ان تضهر ',
                  ),
                ] else if (selectedAnswer3 == 'الصورة من انشاء المؤثر') ...[
                  CustomDropdownQuestion(
                    questionText: 'هل يتطلب ارسال عينة ؟',
                    hintText: 'اختر الجواب المناسب ',
                    selectedValue: selectedAnswer5,
                    items: const [
                      DropdownMenuEntry(value: 'يتطلب', label: 'يتطلب'),
                      DropdownMenuEntry(value: 'لا يتطلب', label: 'لا يتطلب'),
                    ],
                    onSelected: (value) {
                      setState(() => selectedAnswer5 = value);
                      if (value == "لا يتطلب") {
                        ref.read(haveSampleProvider.notifier).state = "no";
                      } else {
                        ref.read(haveSampleProvider.notifier).state = "yes";
                      }
                    },
                  ),

                  if (selectedAnswer5 == 'يتطلب') ...[
                    HintTextWidget(),
                    SizedBox(height: height * 0.03),
                    ConstQuestions(
                      textFormFieldController: ref.read(detailsController),
                      text1: 'اكتب اي توصية او تفاصيل',
                      text2: 'تفاصيل',
                    ),
                  ] else if (selectedAnswer5 == 'لا يتطلب') ...[
                    HintTextWidget(),
                    SizedBox(height: height * 0.03),
                    ConstQuestions(
                      textFormFieldController: ref.read(detailsController),
                      text1: 'اكتب اي توصية او تفاصيل',
                      text2: 'تفاصيل',
                    ),
                  ],
                ],
              ],

              /// فيديو ✅ (مصحح ويظهر الآن)
              if (selectedAnswer2 == 'فيديو') ...[
                CustomDropdownQuestion(
                  questionText: 'هل فيديو اعلانك',
                  hintText: 'اختر الجواب المناسب ',
                  selectedValue: selectedAnswer4,
                  items: const [
                    DropdownMenuEntry(
                      value: 'الفيديو جاهز',
                      label: 'الفيديو جاهز',
                    ),
                    DropdownMenuEntry(
                      value: 'الفيديو من انشاء المؤثر',
                      label: 'الفيديو من انشاء المؤثر',
                    ),
                  ],
                  onSelected: (value) {
                    setState(() => selectedAnswer4 = value);

    if (value == "الفيديو جاهز") {
    ref.read(isTopicReadyProvider.notifier).state = "yes";
    } else {
    ref.read(isTopicReadyProvider.notifier).state = "no";

    }
                  },
                ),

                if (selectedAnswer4 == 'الفيديو جاهز') ...[
                  SizedBox(height: height * 0.03),
                  CustomButtonWidget(
                    onPressd: () async {
                      final ImagePicker picker = ImagePicker();

                      // pick video only
                      final XFile? picked =
                      await picker.pickVideo(source: ImageSource.gallery);

                      if (picked != null) {
                        final file = File(picked.path);

                        ref.read(fileOfTopicProvider.notifier).state = file;
                        ref.read(showSnackBarNotifier.notifier).showNormalSnackBar(
                          context: context,
                          message: "تم إضافة الفيديو بنجاح",
                        );    }


                    },
                    textStyle: AppTextStyle.black19,
                    textButton: '+ اضف الفيديو هنا',
                    heigth: height * 0.09,
                    width: width * 0.6,
                    radius: 12,
                    colorButton: AppColors.premrayColor2,
                  ),
                  SizedBox(height: height * 0.03),
                  ConstQuestions(
                    text1: 'اكتب الكتابة المرفقة للفيديو كما تريدها ان تضهر ',
                    text2: 'اكتب الكتابة المرفقة للفيديو كما تريدها ان تضهر ',
                  ),
                ] else if (selectedAnswer4 == 'الفيديو من انشاء المؤثر') ...[
                  CustomDropdownQuestion(
                    questionText: 'هل يتطلب ارسال عينة ؟',
                    hintText: 'اختر الجواب المناسب ',
                    selectedValue: selectedAnswer6,
                    items: const [
                      DropdownMenuEntry(value: 'يتطلب', label: 'يتطلب'),
                      DropdownMenuEntry(value: 'لا يتطلب', label: 'لا يتطلب'),
                    ],
                    onSelected: (value) {
                      setState(() => selectedAnswer6 = value);
                    },
                  ),

                  if (selectedAnswer6 == 'يتطلب') ...[
                    HintTextWidget(),
                    SizedBox(height: height * 0.03),
                    ConstQuestions(
                      text1: 'اكتب اي توصية او تفاصيل',
                      text2: 'تفاصيل',
                    ),
                  ] else if (selectedAnswer6 == 'لا يتطلب') ...[
                    TextFieldWidget(
                      hintText:
                          'في الاخير سياتيك اتصال من المنصة بخصوص المعلومات ارسال نموذجك الى المؤثر',
                      textInputType: TextInputType.text,
                      maxLines: 4,
                      suffixIcon: const Icon(Icons.attach_file),
                    ),
                    SizedBox(height: height * 0.03),
                    ConstQuestions(
                      text1: 'اكتب اي توصية او تفاصيل',
                      text2: 'تفاصيل',
                    ),
                  ],
                ],
              ],
            ],

            /// كتابة المطلوب مباشرة
            if (selectedAnswer1 == 'كتابة المطلوب مباشرة') ...[
              // Text('من دون تنقل المؤثر :', style: AppTextStyle.black19),
              SizedBox(height: height * 0.03),
              ConstQuestions(
                text1: 'اكتب المطلوب من المؤثر:',
                text2:
                    'اكتب ما الذي سيفعله المؤثر عند وصوله لمكان تسجيل الاشهار مع ذكر تاريخ الحضور وكل ما هو مهم ',
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HintTextWidget extends ConsumerWidget {
  const HintTextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        "في الاخير سياتيك اتصال من المنصة بخصوص المعلومات ارسال نموذجك الى المؤثر",
        style: TextStyle(
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

          fontSize: getIt<AppDimension>().isSmallScreen(context) ? 12 : 14,
        ),
        softWrap: true,
      ),
    );
  }
}
