import 'dart:convert';

import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/view/common_widgets/containers_widgets/container_widget.dart';
import 'package:dz_pub/view/common_widgets/text_widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api/categories.dart';
import '../../../../api/social_media.dart';

class InfluencerProfile extends ConsumerStatefulWidget {
  const InfluencerProfile({super.key});

  @override
  ConsumerState<InfluencerProfile> createState() => _InfluencerProfileState();
}

class _InfluencerProfileState extends ConsumerState<InfluencerProfile> {
  @override
  Widget build(BuildContext context) {
    const Map<int, String> platformNames = {
      1: "فيسبوك",
      2: "إنستغرام",
      3: "تيك توك",
      4: "يوتيوب",
      5: "تويتر",
    };
    final influencerCategories = ref.watch(loginNotifier).categories;
    final influencerSocialMediaLinks = ref
        .watch(loginNotifier)
        .socialMediaLinks;

    final bio = NewSession.get(PrefKeys.inflBio, '');
    final gender = NewSession.get(PrefKeys.inflGender, '');
    final rating = NewSession.get(PrefKeys.inflRating, 0.0);

    final socialJson = NewSession.get(PrefKeys.inflSocialLinks, '');
    List<SocialMediaLink> socialLinks = [];

    final categoryJson = NewSession.get(PrefKeys.inflCategories, '');
    final categories = categoryJson.isEmpty
        ? <dynamic>[]
        : (jsonDecode(categoryJson) as List);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// =============================
          ///  روابط السوشيال ميديا
          /// =============================
          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("روابط التواصل الاجتماعي"),
                FutureBuilder<List<SocialMediaLink?>?>(
                  future: influencerSocialMediaLinks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('حدث خطأ: ${snapshot.error}');
                    } else {
                      final socialMediaLinks = snapshot.data ?? [];

                      if (socialMediaLinks.isEmpty) {
                        return const Text("لا توجد روابط حالياً");
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: socialMediaLinks.map((item) {
                            final int id = item?.socialMediaId ?? 0;
                            final String url = item?.url ?? "";
                            final platformName =
                                platformNames[id] ?? "غير معروف";

                            return Text("$platformName: $url");
                          }).toList(),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// =============================
          ///  التصنيفات
          /// =============================
          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("التصنيفات"),

                FutureBuilder<List<Category?>?>(
                  future: influencerCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // show a loading indicator
                    } else if (snapshot.hasError) {
                      return Text('حدث خطأ: ${snapshot.error}');
                    } else {
                      final categories = snapshot.data ?? [];

                      if (categories.isEmpty) {
                        return const Text("لا توجد تصنيفات");
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: categories.map((cat) {
                            final name = cat?.name ?? "تصنيف غير معروف";
                            return Text("- $name");
                          }).toList(),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// =============================
          ///  معلومات المؤثر
          /// =============================
          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("معلومات عن المؤثر"),
                if (bio.isNotEmpty)
                  Text(
                    "السيرة الذاتية: $bio",
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                if (gender.isNotEmpty)
                  Text(
                    "الجنس: $gender",
                    style: const TextStyle(fontFamily: 'Cairo'),
                  ),
                Text(
                  "التقييم: $rating",
                  style: const TextStyle(fontFamily: 'Cairo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
