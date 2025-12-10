import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/client/screens/client/Influencer_profile_details_ui.dart';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/influencer_provider.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_notifier.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_font.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';

import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ListOfInfluencers extends ConsumerStatefulWidget {
  const ListOfInfluencers({super.key});

  @override
  ConsumerState createState() => _ListOfInfluencersState();
}

class _ListOfInfluencersState extends ConsumerState<ListOfInfluencers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ref.read(categorySelectableName) != ''
            ? Text(
                "قائمة المؤثرين في مجال: ${ref.watch(categorySelectableName)}",
                style: TextStyle(fontSize: 14),
              )
            : Text('قائمة المؤثرين'),
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
        child: ListOfInfluencersWidget(),
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

class ListOfInfluencersWidget extends ConsumerStatefulWidget {
  const ListOfInfluencersWidget({super.key});

  @override
  ConsumerState createState() => _ListOfInfluencersWidgetState();
}

class _ListOfInfluencersWidgetState
    extends ConsumerState<ListOfInfluencersWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint(
        "categorySelectable name = ${ref.read(categorySelectableName)}",
      );

      if (ref.watch(categorySelectableName.notifier).state == '') {
        await ref.watch(influencerNotifier.notifier).getInfluencers();
      } else if (ref.read(categorySelectedId) > 0 ||
          ref.read(categorySelectableName.notifier).state != '') {
        await ref
            .watch(influencerNotifier.notifier)
            .getInfluencers(categoryId: ref.read(categorySelectedId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final influencersList = ref.watch(influencerNotifier).influencer;
    return //list widget
    FutureBuilder(
      future: influencersList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            ref.read(influencerNotifier).isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('حدث خطأ: ${snapshot.error}');
        } else {
          final influencers = snapshot.data ?? [];

          if (influencers.isEmpty) {
            return Center(child: const Text("لا يوجد مؤثرين حالياً"));
          }

          // ✅ Return list of influencer cards
          return ListView.builder(
            itemCount: influencers.length,
            itemBuilder: (context, index) {
              final influencer = influencers[index];

              return CardOfInfluencersWidget(
                influencer: influencer,
                details: () {
                  // your navigation or actions here
                  // Navigator.push(...);
                },
              );
            },
          );
        }
      },
    );
  }
}

class CardOfInfluencersWidget extends ConsumerStatefulWidget {
  const CardOfInfluencersWidget({
    super.key,
    required this.details,
    this.influencer,
  });

  final User? influencer;
  final Function() details;

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

    final name = widget.influencer?.name ?? "بدون اسم";
    final categories = widget.influencer?.influencer?.categories ?? [];
    final influencerId = widget.influencer?.id ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.purple[40],
      shadowColor: AppColors.premrayColor,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Avatar
                ClipOval(
                  child: Icon(
                    Icons.person,
                    size: height * 0.10,
                    color: Colors.grey,
                  ),
                  // Image.network(
                  //   ref.read(defaultImage),
                  //   height: height * 0.10,
                  //   width: height * 0.10,
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (_, __, ___) => Icon(
                  //     Icons.person,
                  //     size: height * 0.10,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),

                const SizedBox(width: 14),

                /// Name + info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFont.mainFontName,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Categories (dynamic)
                      if (categories.isNotEmpty)
                        Text(
                          categories.map((c) => "• ${c.name}").join("  "),
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontFamily: AppFont.mainFontName,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 6),

                      /// Example badges or description
                      Text(
                        'الاوسمة : سفير المنصة لمجال الفن سنة 2024',
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontFamily: AppFont.mainFontName,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            /// Details Button
            CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd: () {
                debugPrint("influencerId ${widget.influencer?.id}");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        InfluencerProfileDetails(influencer: widget.influencer),
                  ),
                );
              },
              textStyle: AppTextStyle.textStyle,
              textButton: 'تفاصيل',
              heigth: height * 0.045,
              width: width * 0.55,
              radius: 8,
            ),

            const SizedBox(height: 10),

            /// Start Promotion Button
            CustomButtonWidget(
              colorButton: AppColors.premrayColor,
              onPressd: () {
                if (NewSession.get(PrefKeys.logged, "") != "OK") {
                  ref
                      .read(showSnackBarNotifier.notifier)
                      .showNormalSnackBar(
                        context: context,
                        message:
                            "برجاء تسجيل الدخول "
                            "اولا",
                      );
                  return;
                }
                ref.read(influencerIdProvider.notifier).state = influencerId;
                context.pushNamed(AppRoutes.dynamicQuestionScreen);
              },
              textStyle: AppTextStyle.textStyle,
              textButton: 'ابدء اشهارك الان',
              heigth: height * 0.045,
              width: width * 0.55,
              radius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
