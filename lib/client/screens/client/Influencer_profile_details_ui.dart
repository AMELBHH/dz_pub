import 'package:dz_pub/api/promations_models/promotions.dart';
import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/defult_profile_image.dart';
import 'package:dz_pub/widget/promotion_widgets/file_section_widget.dart';
import 'package:intl/intl.dart' as intl;

import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class InfluencerProfileDetails extends ConsumerStatefulWidget {
  const InfluencerProfileDetails({super.key, this.influencer});
final User ?influencer;
  @override
  ConsumerState createState() => _InfluencerProfileDetailsState();
}

class _InfluencerProfileDetailsState
    extends ConsumerState<InfluencerProfileDetails> {
  String buildStars(double rating) {
    int count = rating.toInt();       // convert double → int
    return rating == 0 ? "لا يوجد تقييمات": '⭐' * count;               //
    // repeat the star emoji
  }
    Promotion ?promotion;
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("social mideia link : ${widget.influencer?.influencer?.socialMediaLinks}");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await ref
          .read(promotionProvider.notifier)
          .getLastPromotionByInfluencer(widget.influencer?.id ?? 0);

      setState(() {
        promotion = result;
      });
    });
}
  @override
  Widget build(BuildContext context) {
    final createdAtString = widget.influencer?.createdAt?? "";
    String formattedCreatedAt = '';
    if (createdAtString.isNotEmpty) {
      try {
        // Parse the string into a DateTime object
        final createdAt = DateTime.parse(createdAtString);

        // Format it into a human-friendly format, e.g., "Nov 30, 2025 at 4:30 PM"
        final formatter = intl.DateFormat('MMM d, yyyy');
        formattedCreatedAt = formatter.format(createdAt);
      } catch (e) {
        formattedCreatedAt = createdAtString; // fallback if parsing fails
      }
    }
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('ابدء اشهارك الان'),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'block',
                    child: Text(' حظر',style: AppTextStyle.descriptionText),
                  ),
                  PopupMenuItem<String>(
                    value: 'report',
                    child: Text(' إبلاغ',style: AppTextStyle.descriptionText),
                  ),
                ];
              },
            ),
          ],
        ),


        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: height * 0.23),
                  Center(
                    child: Text(
                      widget.influencer?.name?? "بدون اسم",
                      style: AppTextStyle.premaryLineStyle,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text('49k', style: AppTextStyle.textpurpal),
                  //         Text('المتابعون', style: AppTextStyle.titel),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('49k', style: AppTextStyle.textpurpal),
                  //         Text('الاعمال', style: AppTextStyle.titel),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Text('49k', style: AppTextStyle.textpurpal),
                  //         Text('المتابعون', style: AppTextStyle.titel),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: height * 0.03),

                  Container(
                    padding: EdgeInsets.all(18),

                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.premrayColor2,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RowWidet(
                          description:"لا يوجد أوسمة",
                          //"سفير المنصة لمجال الفن سنة 2024",
                          title: 'الاوسمة :',
                        ),
                        SizedBox(height: height * 0.015),
                        RowWidet(
                          description: formattedCreatedAt,
                          title: 'تاريخ الانضمام :',
                        ),
                        SizedBox(height: height * 0.015),
                        RowWidet(
                            description:

                            buildStars(widget.influencer?.influencer?.rating ?? 0),
                          title: 'تقييم :'),
                        // RowWidet(description: '⭐⭐⭐', title: 'تقييم :'),
                         SizedBox(height: height * 0.015),
                        RowWidet(
                          description: widget.influencer?.influencer?.categories?.map((c) => c.name).join(", ")?? "",
                          title: 'المجالات:',
                        ),
                        // SizedBox(height: height * 0.015),
                        // RowWidet(
                        //   description: 'الغناء ,التمثيل ,الموضة',
                        //   title: 'المجالات الثانوية :',
                        // ),
                        SizedBox(height: height * 0.015),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),

                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.premrayColor2,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "نبذة عن :${widget.influencer?.name??''}",
                          style: AppTextStyle.titel,
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          widget.influencer?.influencer?.bio?? "",
                          style: AppTextStyle.descriptionText,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18),

                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.premrayColor2,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          " حسابات: ${widget.influencer?.name??''}",
                          style: AppTextStyle.titel,
                        ),

                        Column(
                          children:


                          widget.influencer?.influencer?.socialMediaLinks
                              ?.map((social) {



                            return
                              buildSocialTile(

                              id: social.socialMediaId??0, // safe because we
                                // checked
                              // above
                              url: social.url??"no soical",

                              name: widget.influencer?.name ?? 'any thing',
                            );
                          }).toList() ??
                              [
                                const SizedBox(
                                  child: Text("no social"),
                                ),
                              ],
                        )

                      ],
                    ),

                  ),



                  SizedBox(height: height * 0.02),
                  Container(
                    padding: EdgeInsets.all(18),

                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.premrayColor2,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'بعض الاعمال',
                          style: AppTextStyle.titel,
                        ),
                        SizedBox(height: height * 0.015),

                      FilesSection(promotion: promotion),

                        ref.read(promotionProvider).isLoading ?

                            CircularProgressIndicator()
                            : Text(promotion
                            ?.requirements??"" ,style:
                        AppTextStyle.descriptionText,)

                      ],
                    ),
                  ),






                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButtonWidget(
                      colorButton: AppColors.premrayColor,
                      onPressd: () {
                        context.pushNamed(AppRoutes.dynamicQuestionScreen);
                      },
                      textButton: 'ابدء اشهارك الان',
                      textStyle: AppTextStyle.homebuttonStyle,

                      heigth: height*0.06,
                      // width: width*0.5,
                      radius: 180,
                    ),
                  ),

                ],
              ),

              Positioned(
                child: Container(
                  height: height * 0.14,
                  decoration: BoxDecoration(
                    color: AppColors.premrayColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.01,
                left: width * 0.30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        border: Border.all(
                          color: AppColors.premrayColor,
                          width: 3,
                        ),
                      ),
                      child: SizedBox(
                        height: height * 0.20,
                     width: height * 0.20,                          child:
                      DefaultImageWidget(radius: 100,)),
                      // child: ClipOval(
                      //   child: Image.network(
                      //     'https://media.licdn.com/dms/image/v2/C4E12AQHzBAiANK2ceQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1627292304016?e=2147483647&v=beta&t=CaGaKBl8DcF2tV6Ygjhe9uOPJdAc25Gis-KnOGC8G9E',
                      //     height: height * 0.20,
                      //     width: height * 0.20,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildSocialTile({
    required int id,
    required String url,

    required String name,
  }) {


    switch (id) {
      case 1: // Facebook
        return _buildTile('assets/svg/facebook-svgrepo-com.svg', 'فيسبوك',
          url,);
      case 2: // Instagram
        return _buildTile('assets/svg/instagram-1-svgrepo-com.svg', 'إنستقرام',
          url,);
      case 3: // TikTok
        return _buildTile('assets/svg/tiktok-logo-logo-svgrepo-com.svg', "تيك"
            "توك", url, );
      case 4: // Twitter
        return _buildTile('assets/svg/twitter-svgrepo-com.svg', "تويتر | X",
          url, );
      case 5: // YouTube
        return _buildTile('assets/svg/youtube-svgrepo-com.svg', "يوتيوب",
          url, );
      default:
        return _buildTile('assets/svg/youtube-svgrepo-com.svg', name, url, );
    }
  }

  Widget _buildTile(String iconPath, String name, String url, ) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 30,
        width: 100
      ),
      title: Text(
        '$name',
        style: TextStyle(color: Colors.blueAccent,fontSize: 16),
      ),
      onTap: () => launchUrl(Uri.parse(url)),
    );
  }

}

class RowWidet extends StatelessWidget {
  final String title;
  final String description;
  const RowWidet({super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyle.titel),
        Text(description, style: AppTextStyle.descriptionText),
      ],
    );
  }
}
