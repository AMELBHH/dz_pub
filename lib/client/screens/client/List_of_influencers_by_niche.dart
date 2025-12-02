import 'package:dz_pub/api/categories.dart';
import 'package:dz_pub/controllers/providers/influencer_provider.dart';
import 'package:dz_pub/core/styling/App_colors.dart';
import 'package:dz_pub/core/styling/App_text_style.dart';
import 'package:dz_pub/routing/App_routes.dart';
import 'package:dz_pub/widget/Custom_Button_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
/*

 */


class ListOfInfluencersByNiche extends ConsumerStatefulWidget {
  const ListOfInfluencersByNiche({super.key});

  @override
  ConsumerState createState() => _ListOfInfluencersByNicheState();
}

class _ListOfInfluencersByNicheState extends ConsumerState<ListOfInfluencersByNiche> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(ref.watch(getCategoryNotifier).categories == null){
      await ref.watch(getCategoryNotifier.notifier).getCategory();
    }}
    );

  }
  @override
  Widget build(BuildContext context) {
     final categoriesFuture = ref.read(getCategoryNotifier).categories;

    final size = MediaQuery.of(context).size;
    //final width = size.width;
    final height = size.height;
    return

      Scaffold(

        body:
        ref.watch(getCategoryNotifier).isLoading ?

            Center(child: CircularProgressIndicator()):

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:  Consumer(
            builder: (context, ref, _) {
              final influencerState = ref.watch(getInfluencerNotifier);

              return FutureBuilder<List<Category?>?>(
                future: categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      influencerState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text("خطأ: ${snapshot.error}");
                  }

                  final categories = snapshot.data ?? [];

                  if (categories.isEmpty) {
                    return const Center(child: Text("لا توجد تصنيفات"));
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: categories.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: CustomButtonWidget(
                          heigth: 55,
                          onPressd: () async {
                            await ref
                                .read(getInfluencerNotifier.notifier)
                                .getInfluencer(cat?.id ?? 0);
ref.read(categorySelectableName.notifier).state = cat?.name ?? "";
                            context.pushNamed(
                              AppRoutes.listOfInfluencers,
                              queryParameters: {"categoryId": cat?.id.toString()},
                            );
                          },
                          textStyle: AppTextStyle.homebuttonStyle,
                          textButton: cat?.name ?? "تصنيف غير معروف",
                          colorButton: AppColors.premrayColor,
                        ),
                      );
                    }).toList(),
                  );
                },
              );
            },
          )          ,
        ),
      );
  }
}
