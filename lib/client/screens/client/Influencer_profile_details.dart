import 'package:dz_pub/core/styling/App_colors.dart';

import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class InfluencerProfileDetails extends StatelessWidget {
  const InfluencerProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Numidia Lezoul',
                      style: AppTextStyle.premaryLineStyle,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('49k', style: AppTextStyle.textpurpal),
                          Text('المتابعون', style: AppTextStyle.titel),
                        ],
                      ),
                      Column(
                        children: [
                          Text('49k', style: AppTextStyle.textpurpal),
                          Text('الاعمال', style: AppTextStyle.titel),
                        ],
                      ),
                      Column(
                        children: [
                          Text('49k', style: AppTextStyle.textpurpal),
                          Text('المتابعون', style: AppTextStyle.titel),
                        ],
                      ),
                    ],
                  ),
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
                          description: "سفير المنصة لمجال الفن سنة 2024",
                          title: 'الاوسمة :',
                        ),
                        SizedBox(height: height * 0.015),
                        RowWidet(
                          description: '2024/05/09',
                          title: 'تاريخ الانضمام :',
                        ),
                        SizedBox(height: height * 0.015),
                        // RowWidet(description: '⭐⭐⭐⭐', title: 'تقييم :'),
                        // SizedBox(height: height * 0.015),
                        RowWidet(
                          description: 'الغناء ,التمثيل ,الموضة',
                          title: 'المجالات الرئسية:',
                        ),
                        SizedBox(height: height * 0.015),
                        RowWidet(
                          description: 'الغناء ,التمثيل ,الموضة',
                          title: 'المجالات الثانوية :',
                        ),
                        SizedBox(height: height * 0.015),
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
                          'نبذة عن Numidia Lezoul :',
                          style: AppTextStyle.titel,
                        ),
                        SizedBox(height: height * 0.015),
                        Text(
                          'بدأت مسيرتها من خلال برنامج المواهب ألحان وشباب، ما فتح أمامها أبواب التمثيل والإعلام. كما درست الموسيقى والتراث الأندلسي لمدة 8 سنوات، وهو ما منحها قاعدة فنية قوية',
                          style: AppTextStyle.descriptionText,
                        ),
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
                          ' Numidia Lezoul :حسابات ',
                          style: AppTextStyle.titel,
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/facebook-svgrepo-com.svg',
                            height: height * 0.035,
                            width: width * 0.35,
                          ), // أيقونة على اليسار
                          title: Text(
                            'نبذة عن Numidia Lezoul :',
                            style: AppTextStyle.descriptionText,
                          ),
                          onTap: () {
                            launchUrl(
                              Uri.parse(
                                'https://www.facebook.com/numidialezoul',
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/instagram-1-svgrepo-com.svg',
                            height: height * 0.035,
                            width: width * 0.35,
                          ), // أيقونة على اليسار
                          title: Text(
                            'نبذة عن Numidia Lezoul :',
                            style: AppTextStyle.descriptionText,
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/tiktok-logo-logo-svgrepo-com.svg',
                            height: height * 0.035,
                            width: width * 0.35,
                          ), // أيقونة على اليسار
                          title: Text(
                            'نبذة عن Numidia Lezoul :',
                            style: AppTextStyle.descriptionText,
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/twitter-svgrepo-com.svg',
                            height: height * 0.035,
                            width: width * 0.35,
                          ), // أيقونة على اليسار
                          title: Text(
                            'نبذة عن Numidia Lezoul :',
                            style: AppTextStyle.descriptionText,
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/svg/youtube-svgrepo-com.svg',
                            height: height * 0.035,
                            width: width * 0.35,
                          ), // أيقونة على اليسار
                          title: Text(
                            'نبذة عن Numidia Lezoul :',
                            style: AppTextStyle.descriptionText,
                          ),
                        ),
                        
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
                        Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQCRSq6q-N86Jaj8byHfh5kScct5ic_FbcTQ&s'),
                        Text('محاكمة المؤثرين.. نوميديا لزول تفقد الوعي بعد سماعها لالتماسات النيابة' ,style: AppTextStyle.descriptionText,)

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
                      child: ClipOval(
                        child: Image.network(
                          'https://media.licdn.com/dms/image/v2/C4E12AQHzBAiANK2ceQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1627292304016?e=2147483647&v=beta&t=CaGaKBl8DcF2tV6Ygjhe9uOPJdAc25Gis-KnOGC8G9E',
                          height: height * 0.20,
                          width: height * 0.20,
                          fit: BoxFit.cover,
                        ),
                      ),
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
