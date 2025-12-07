import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:dz_pub/client/questions/widget/SelectableItem.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/view/common_widgets/button_widgets/back_button_widget.dart';
import 'package:dz_pub/view/common_widgets/custom_dropdown_question_widget.dart';
import 'package:dz_pub/view/common_widgets/text_form_field_widgets/text_form_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/coordination.dart';
import '../../constants/get_it_controller.dart';
import 'widgets/registration_widgets/button_reg_completed_widget.dart';
import 'widgets/registration_widgets/password_reg_completed_widget.dart';
import 'widgets/registration_widgets/email_completed_widget.dart';
import 'widgets/registration_widgets/title_reg_completed_widget.dart';
import 'widgets/registration_widgets/user_name_reg_completed_widget.dart';

class RegistrationUi extends ConsumerStatefulWidget {
  const RegistrationUi({super.key});

  @override
  ConsumerState createState() => _RegistrationUiState();
}

class _RegistrationUiState extends ConsumerState<RegistrationUi> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(isObscure.notifier).state = false;
    });
  }
bool  isHaveCr = false;
  final List<int> categoryIds = [];
  final List<int> socialMediaIds = [];
  final List<String> socialMediaLinks = [];

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      bottomColor: Colors.transparent,
      color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
      child: Scaffold(
          backgroundColor:
              ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child:
                  BackButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: getIt<AppDimension>().isSmallScreen(context)
                      ? 20 / 3
                      : 20,
                ),
                const TitleRegCompletedWidget(),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getIt<AppDimension>().isSmallScreen(context)
                            ? 15
                            : 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // UserNameWidget(),
                          const UserNameRegCompletedWidget(),
                          // HintUnderUserNameField(),
                          SizedBox(
                            height: getIt<AppDimension>().isSmallScreen(context)
                                ? 10
                                : 25,
                          ),
                        //  DropDownUserTypeWidget(
                          //   stringValues: ref.read(typeOfUser),
                          // ),

                          SizedBox(
                            height: getIt<AppDimension>().isSmallScreen(context)
                                ? 10
                                : 30,
                          ),
                          Form(
                              key: formPhoneKey,
                              child: EmailCompletedWidget(
                                validateValue: ref
                                        .watch(formFieldsNotifier)[
                                            'emailRegistration']
                                        ?.error ??
                                    "no error have",
                                controller: ref.read(emailController),
                                isEmailRegTextField: true,
                              )),
                          SizedBox(
                            height: getIt<AppDimension>().isSmallScreen(context)
                                ? 0
                                : 10,
                          ),
                          const PasswordRegCompletedWidget(),
                          // HintUnderPhoneNumberField(),

                          SizedBox(
                            height
                                : 25,
                          ),
                          // PasswordWidget(),
                    //      const PrivacyPolicyTextWidget(),
                          UserInfoWidgets(),
                          SizedBox(height: 25,),
                          NewSession.get(PrefKeys.userType, "") != "client" ?

                                InfluencerWidgets(categoryIds: categoryIds,socialMediaIds: socialMediaIds,socialMediaLinks: socialMediaLinks)
                                :
                          Column(
                            spacing: 25,

                            children: [

                            CustomDropdownQuestionWidget(
                              forRegistration: true,
                                  (value){
                                setState(() {
                                  isHaveCr = value == 'yes';
                                  if(value == "yes"){
                                    ref.read(isHaveCrProvider.notifier).state
                                    = "yes";
                                  }else{
                                    ref.read(isHaveCrProvider.notifier).state
                                    = "no";
                                  }


debugPrint("ref of isHave Cr Privder value is ${ref.read(isHaveCrProvider)}");
                                });

                              }, questionText: "",
                              hintText: "هل لديك سجل تجاري", items: [

                              DropdownMenuEntry(value: 'yes', label: 'نعم لدي '
                                  'سجل تجاري'),
                              DropdownMenuEntry(value: 'no', label:"لا ليس لدي "
                                  "سجل تجاري"),
                            ],
                            ),
                            isHaveCr ?
                           ClientWithCrWidgets()
                             :
                           ClientWithoutCrWidgets(),
                            ],),
// ElevatedButtonWidget(child: Text("register"), onPressed: (){
//   ref.read(categoryIdsProvider.notifier).state = categoryIds??[];
//
//   validateAndRegistration(ref, context);
// }, context: context),
                          ButtonRegCompletedWidget(categoryIds: categoryIds,
                          socialMediaIds: socialMediaIds,
                          socialMediaLinks: socialMediaLinks,
                          )
                        ])),


              ],
            )),
          )),
    );
  }
}

class ClientWithCrWidgets extends ConsumerStatefulWidget {
  const ClientWithCrWidgets({super.key});

  @override
  ConsumerState createState() => _ClientWithCrWidgetsState();
}

class _ClientWithCrWidgetsState extends ConsumerState<ClientWithCrWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 25,

      children: [

        TextFormFieldWidget(labelName: "الرقم الإحصائي",keyboardType: TextInputType
            .number,
        controller: ref.read(nisNumberController),
        ),
        TextFormFieldWidget(labelName: "رقم التسجيل في السجل التجاري",
            keyboardType: TextInputType.number,
        controller: ref.read(rcNumberController),
        ),
        TextFormFieldWidget(labelName: " رقم الحساب البنكي- إختياري",
            keyboardType:
        TextInputType.number,
        controller: ref.read(ibanController),
        ),
        TextFormFieldWidget(labelName: "الرقم الحسابي",keyboardType: TextInputType.number,
        controller: ref.read(nifNumberController),


        ),
        TextFormFieldWidget(labelName: "عنوان المؤسسة",
        controller: ref.read(institutionAddressController),
        ),
        TextFormFieldWidget(labelName: "عنوان الفرع - إختياري",
        controller: ref.read(branchAddressController),
        ),
        TextFormFieldWidget(labelName: "اسم المؤسسة",
        controller: ref.read(institutionNameController),
        ),
        TextFormFieldWidget(labelName: "اسم المالك",
    controller:     ref.read(regOwnerNameController)
        ),


      ],
    );
  }

}

class UserInfoWidgets extends ConsumerStatefulWidget {
  const     UserInfoWidgets({super.key});

  @override
  ConsumerState createState() => _UserInfoWidgetsState();
}

class _UserInfoWidgetsState extends ConsumerState<UserInfoWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 25,

      children: [
        TextFormFieldWidget(labelName: "رقم الهاتف",keyboardType:
        TextInputType.number,
        controller: ref.read(phoneController),

        ),
        TextFormFieldWidget(labelName: "رقم بطاقة التعريف",keyboardType:
        TextInputType
            .number,controller: ref.read(identityNumberController),

        maxLength: 20,),




      ],
    );
  }
}


class ClientWithoutCrWidgets extends ConsumerStatefulWidget {
  const   ClientWithoutCrWidgets({super.key});

  @override
  ConsumerState createState() => _ClientWithoutCrWidgetsState();
}

class _ClientWithoutCrWidgetsState extends ConsumerState<ClientWithoutCrWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 25,

      children: [


        TextFormFieldWidget(labelName: "اللقب",
        
        controller: ref.read(nicknameController),
        ),

      ],
    );
  }
}
class InfluencerWidgets extends ConsumerStatefulWidget {
  const InfluencerWidgets({super.key, this.categoryIds, this.socialMediaIds, this.socialMediaLinks});
  final List<int> ?categoryIds;
  final List<int> ?socialMediaIds;
  final List<String> ?socialMediaLinks;

  @override
  ConsumerState createState() => _InfluencerWidgetsState();
}

class _InfluencerWidgetsState extends ConsumerState<InfluencerWidgets> {
  List<SocialMediaItem> socialMediaItems = [
    SocialMediaItem(id: 1, label: "فيسبوك"),
    SocialMediaItem(id: 2, label: "انستغرام"),
    SocialMediaItem(id: 3, label: "تيك توك"),
    SocialMediaItem(id: 4, label: "يوتيوب"),
    SocialMediaItem(id: 5, label: "تويتر | X"),
  ];
  List<CategoryItem> categoriesItems = [

    CategoryItem(id: 1, label: "رياضة"),

    CategoryItem(id: 2, label: "طبخ"),

    CategoryItem(id: 3, label: "صحة"),


  ];
  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
spacing: 25,
        children: [
    TextFormFieldWidget(labelName: "نبده عن المؤثر",controller: ref.read(bioController)),


  CustomDropdownQuestionWidget(
forRegistration: true,
        (value){
  ref.read(typeOfInfluencerProvider.notifier).state = value??"";
debugPrint("type of infu on the ui ${ref.read(typeOfInfluencerProvider)}");
        }, questionText: "",
      hintText: "إختر النوع", items: [
        DropdownMenuEntry(value: '1', label: 'معنوي'),
        DropdownMenuEntry(value: '2', label: 'طبيعي'),
        ],
      ),
          SizedBox(height: 25,),
          SubTitleWidget(text: "إختر مجلاتك"),

          Column(
            children: categoriesItems.map((item) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableItem(
                    label: item.label,
                      onChanged: (selected) {
                        setState(() {
                          item.selected = selected;
                        });

                        if (item.selected) {
                          // Add to categoryIds (allow duplicates)
                          widget.categoryIds?.add(item.id);
                        } else {
                          // Remove the id
                          widget.categoryIds?.remove(item.id);
                        }

                        debugPrint("widget.categoryIds ${widget.categoryIds}");
                      },

                  ),
                ],
              );
            }).toList(),
          )
,
          SubTitleWidget(text: "إختر منصاتك"),
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
                        widget.socialMediaIds?.add(socialItem.id);
                        debugPrint("social media selected ${widget.socialMediaIds}");
                      } else {
                        widget.socialMediaIds?.remove(socialItem.id);
                      }
                    },
                  ),

                  // show url field ONLY if selected = true
                  if (socialItem.selected)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,
                         ).copyWith(top: 8,bottom: 25),
                      child: TextFormFieldWidget(

                        labelName:"ادخل رابط ${socialItem.label} الخاص بك",
                        fontSize:14,


                        onChanged: (value) {
                          socialItem.url = value;
                          widget.socialMediaLinks?.clear();
                          widget.socialMediaLinks?.addAll(
                            socialMediaItems
                                .where((i) => i.selected && i.url.isNotEmpty)
                                .map((i) => i.url)
                                .toList(),
                          );
                        },
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
/// ElevatedButtonWidget(child: Text("print selectd values"), onPressed: (){
///   List<Map<String, dynamic>> selectedSocialMedia = socialMediaItems
///       .where((item) => item.selected && item.url.isNotEmpty)
///       .map((item) => {
///     "id": item.id,
///     "url": item.url,
///   })
///       .toList();
///
///   debugPrint("selected values -  $selectedSocialMedia");
///
/// }, context: context)
    ]
    );
  }
}
class SocialMediaItem {
  final int id;               // your index
    final String label;         // name
  bool selected;              // if user selected it
  String url;                 // user URL

  SocialMediaItem({
    required this.id,
    required this.label,
    this.selected = false,
    this.url = '',
  });
}class CategoryItem {
  final int id;               // your index
  final String label;         // name
  bool selected;              // if user selected it

  CategoryItem({
    required this.id,
    required this.label,
    this.selected = false,
  });
}

class SubTitleWidget extends ConsumerWidget {
  const SubTitleWidget({super.key,required this.text});
final String text;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: TextStyle(
            color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          softWrap: true,
        ),
      ),
    );
  }
}
