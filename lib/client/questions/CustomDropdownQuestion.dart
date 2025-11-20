

import 'package:dz_pub/client/questions/widget/ConstQuestions.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:dz_pub/widget/Text_Field_widget.dart';
import 'package:flutter/material.dart';

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

class DynamicQuestionScreen extends StatefulWidget {
  const DynamicQuestionScreen({super.key});

  @override
  State<DynamicQuestionScreen> createState() => _DynamicQuestionScreenState();
}

class _DynamicQuestionScreenState extends State<DynamicQuestionScreen> {
  String? selectedAnswer;
  String? selectedAnswer1;
  String? selectedAnswer2;
  String? selectedAnswer3;
  String? selectedAnswer4;
  String? selectedAnswer5;
  String? selectedAnswer6;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('ابدء اشهارك الان')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23 ,vertical: 4),
        child: ListView(
          children: [
            /// السؤال الأول
            CustomDropdownQuestion(
              questionText: 'هل يتطلب اعلانك تنقل المؤثر ؟',
              hintText: 'اختر الجواب المناسب ',
              selectedValue: selectedAnswer,
              items: const [
                DropdownMenuEntry(
                    value: 'نعم', label: 'نعم يتطلب اعلاني تنقل المؤثر'),
                DropdownMenuEntry(
                    value: 'لا', label: 'لا لايتطلب اعلاني تنقل المؤثر'),
              ],
              onSelected: (value) {
                setState(() {
                  selectedAnswer = value;
                  selectedAnswer1 =
                      selectedAnswer2 = selectedAnswer3 = selectedAnswer4 = null;
                });
              },
            ),

            /// إذا كانت الإجابة نعم
            if (selectedAnswer == 'نعم') ...[
              SizedBox(height: height * 0.03),
              Text('بتنقل المؤثر :', style: AppTextStyle.black19),
              SizedBox(height: height * 0.03),
              TextFieldwidget(
                hintText: 'عنوان حضور المؤثر',
                textInputType: TextInputType.text,
                maxLength: 50,
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
                      value: 'التسجيل حسب النموذج', label: 'التسجيل حسب النموذج'),
                  DropdownMenuEntry(
                      value: 'كتابة المطلوب مباشرة', label: 'كتابة المطلوب مباشرة'),
                ],
                onSelected: (value) {
                  setState(() {
                    selectedAnswer1 = value;
                    selectedAnswer2 =
                        selectedAnswer3 = selectedAnswer4 = null;
                  });
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
                    selectedAnswer3 =
                        selectedAnswer4 = selectedAnswer5 = selectedAnswer6 = null;
                  });
                },
              ),

              /// كتابة
              if (selectedAnswer2 == 'كتابة') ...[
                SizedBox(height: height * 0.03),
                ConstQuestions(
                  text1: 'اكتب نص المنشور كما تريده ان ينشر',
                  text2: 'ايموجي وصوالح اخرى',
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
                        value: 'الصورة جاهزة', label: 'الصورة جاهزة'),
                    DropdownMenuEntry(
                        value: 'الصورة من انشاء المؤثر',
                        label: 'الصورة من انشاء المؤثر'),
                  ],
                  onSelected: (value) {
                    setState(() => selectedAnswer3 = value);
                  },
                ),

                if (selectedAnswer3 == 'الصورة جاهزة') ...[
                   SizedBox(height: height * 0.03),
                  CustomButtonWidget(
                    onPressd: () {},
                    textStyle: AppTextStyle.black19,
                    textButton: '+ اضف الصورة هنا',
                    heigth: height * 0.09,
                    width: width * 0.6,
                    radius: 12,
                    colorButton: AppColors.premrayColor2,
                  ), SizedBox(height: height * 0.03),
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
                    },
                  ),

                  if (selectedAnswer5 == 'يتطلب') ...[
                    TextFieldwidget(
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
                  ] else if (selectedAnswer5 == 'لا يتطلب') ...[
                    TextFieldwidget(
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

              /// فيديو ✅ (مصحح ويظهر الآن)
              if (selectedAnswer2 == 'فيديو') ...[
                CustomDropdownQuestion(
                  questionText: 'هل فيديو اعلانك',
                  hintText: 'اختر الجواب المناسب ',
                  selectedValue: selectedAnswer4,
                  items: const [
                    DropdownMenuEntry(value: 'الفيديو جاهز', label: 'الفيديو جاهز'),
                    DropdownMenuEntry(
                        value: 'الفيديو من انشاء المؤثر',
                        label: 'الفيديو من انشاء المؤثر'),
                  ],
                  onSelected: (value) {
                    setState(() => selectedAnswer4 = value);
                  },
                ),

                if (selectedAnswer4 == 'الفيديو جاهز') ...[
                   SizedBox(height: height * 0.03),
                  CustomButtonWidget(
                    onPressd: () {},
                    textStyle: AppTextStyle.black19,
                    textButton: '+ اضف الفيديو هنا',
                    heigth: height * 0.09,
                    width: width * 0.6,
                    radius: 12,
                    colorButton: AppColors.premrayColor2,
                  ), SizedBox(height: height * 0.03),
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
                    TextFieldwidget(
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
                  ] else if (selectedAnswer6 == 'لا يتطلب') ...[
                    TextFieldwidget(
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
