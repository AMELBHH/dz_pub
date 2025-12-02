
import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_font.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';

import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListOfInfluencers extends StatelessWidget {
  const ListOfInfluencers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المؤثرين'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.witheColor),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(150),
        ),
        onPressed: () {},
        child: Icon(Icons.filter_alt_outlined, color: AppColors.premrayColor),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
ListOfInfluencersWidget()
        // ListView(
        //   children: [
        //     CardOfInfuencersWidget(
        //       details: () {
        //         context.pushNamed(AppRoutes.influencerProfileDetails);
        //       },
        //     ),
        //     CardOfInfuencers(details: () {}),
        //     CardOfInfuencers(details: () {}),
        //   ],
        // ),
      ),
    );
  }
}

// class CardOfInfuencers extends StatefulWidget {
//   const CardOfInfuencers({super.key, required this.details,  this.imageUrl, this.name, this.categories});
//   final Function() details;
//   final String ?imageUrl;
//   final String ?name;
//   final List<String> ?categories;
//
//
//   @override
//   State<CardOfInfuencers> createState() => _CardOfInfuencersState();
// }

// class _CardOfInfuencersState extends State<CardOfInfuencers> {
  // String  defaultImage = "https://media.licdn.com/dms/image/v2/C4E12AQHzBA"
  //     "iANK2ceQ/article-cover_image-shrink_720_1280/article-cover_image-shrink"
  //     "_720_1280/0/1627292304016?e=2147483647&v=beta&t=CaGaKBl8DcF2tV6Ygjhe"
  //     "9uOPJdAc25Gis-KnOGC8G9E";
  // @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final width = size.width;
  //   final height = size.height;
  //   return
  //     Card(
  //     color: Colors.purple[40],
  //     shadowColor: AppColors.premrayColor,
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             ClipOval(
  //               child: Image.network(
  //                 widget.imageUrl??defaultImage,
  //                 height: height * 0.11,
  //                 width: height * 0.11,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             Column(
  //               children: [
  //                 Text(
  //                   widget.name??'Numidia Lezoul',
  //                   style: TextStyle(
  //                     fontSize: width * 0.06,
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: AppFont.mainFontName,
  //                     color: AppColors.blackColor,
  //                   ),
  //                 ),
  //                 Text(
  //                   'الاوسمة :سفير المنصة لمجال الفن سنة 2024',
  //                   style: TextStyle(
  //                     fontSize: width * 0.03,
  //                     fontWeight: FontWeight.w400,
  //                     fontFamily: AppFont.mainFontName,
  //                     color: AppColors.blackColor,
  //                   ),
  //                 ),
  //                 if(widget.categories != null)
  //                   Text(
  //                     widget.categories!.join(', '),
  //                     style: TextStyle(
  //                       fontSize: width * 0.036,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: AppFont.mainFontName,
  //                       color: AppColors.blackColor,
  //                     ),
  //                   ),
  //
  //                 Text(
  //                   'الغناء ,التمثيل ,الموضة',
  //                   style: TextStyle(
  //                     fontSize: width * 0.036,
  //                     fontWeight: FontWeight.w400,
  //                     fontFamily: AppFont.mainFontName,
  //                     color: AppColors.blackColor,
  //                   ),
  //                 ),
  //
  //
  //
  //               ],
  //             ),
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 90),
  //           child: CustomButtonWidget(
  //             colorButton: AppColors.premrayColor,
  //             onPressd: widget.details,
  //             textStyle: AppTextStyle.textStyle,
  //             textButton: 'تفاصيل',
  //             heigth: height * 0.03,
  //
  //             radius: 8,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 90),
  //           child: CustomButtonWidget(
  //             colorButton: AppColors.premrayColor,
  //             onPressd: () {
  //               context.pushNamed(AppRoutes.dynamicQuestionScreen);
  //             },
  //             textStyle: AppTextStyle.textStyle,
  //             textButton: 'ابدء اشهارك الان',
  //             heigth: height * 0.03,
  //             width: width * 0.55,
  //             radius: 8,
  //           ),
  //         ),
  //
  //
  //       ],
  //     ),
  //   );
  // }
// }

class ListOfInfluencersWidget extends ConsumerStatefulWidget {
  const ListOfInfluencersWidget({super.key});

  @override
  ConsumerState createState() => _ListOfInfluencersWidgetState();
}

class _ListOfInfluencersWidgetState
    extends ConsumerState<ListOfInfluencersWidget> {
  @override
  Widget build(BuildContext context) {
    return //list widget
    ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return CardOfInfluencersWidget(
          details: () {
                     context.pushNamed(AppRoutes.influencerProfileDetails);

          },
        );
      },
    );
  }
}

class CardOfInfluencersWidget extends ConsumerStatefulWidget {
  const CardOfInfluencersWidget( {super.key, required this.details, this
      .imageUrl,
    this.name, this.categories});
  final Function()details;
  final String ?imageUrl;
  final String ?name;
  final List<String> ?categories;


  @override
  ConsumerState createState() => _CardOfInfluencersWidgetState();
}

class _CardOfInfluencersWidgetState
    extends ConsumerState<CardOfInfluencersWidget> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Card(
      color: Colors.purple[40],
      shadowColor: AppColors.premrayColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Image.network(
                  widget.imageUrl??ref.read(defaultImage),
                  height: height * 0.10,
                  width: height * 0.10,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.name??'Numidia Lezoul',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    'الاوسمة :سفير المنصة لمجال الفن سنة 2024',
                    style: TextStyle(
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),
                  if(widget.categories != null)
                    Text(
                      widget.categories!.join(', '),
                      style: TextStyle(
                        fontSize: width * 0.036,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFont.mainFontName,
                        color: AppColors.blackColor,
                      ),
                    ),

                  Text(
                    'الغناء ,التمثيل ,الموضة',
                    style: TextStyle(
                      fontSize: width * 0.036,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.mainFontName,
                      color: AppColors.blackColor,
                    ),
                  ),



                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd:


              widget.details,
              textStyle: AppTextStyle.textStyle,
              textButton: 'تفاصيل',
              heigth: height * 0.03,

              radius: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 90),
            child: CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd: () {
                context.pushNamed(AppRoutes.dynamicQuestionScreen);
              },
              textStyle: AppTextStyle.textStyle,
              textButton: 'ابدء اشهارك الان',
              heigth: height * 0.03,
              width: width * 0.55,
              radius: 8,
            ),
          ),


        ],
      ),
    );
  }
}


