import 'package:dz_pub/api/promations_models/custom_promotions.dart';
import 'package:dz_pub/controllers/providers/promotion_provider.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfCustomPromotion extends ConsumerStatefulWidget {
  const ListOfCustomPromotion({super.key});

  @override
  ConsumerState createState() => _ListOfCustomPromotionState();
}

class _ListOfCustomPromotionState extends ConsumerState<ListOfCustomPromotion> {
  late Future<List<CustomPromotion>> future;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(promotionProvider.notifier).getCustomPromotionByClientId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إشهاراتي حسب الطلب")),
      body: FutureBuilder<List<CustomPromotion?>?>(
        future: ref.read(promotionProvider).customPromotion,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("لا توجد إشهارات حاليا"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: snapshot.data?.length,

              itemBuilder: (context, index) {
                return CardContainer(
                  title: "معلومات الإشهار ${index + 1}",
                  child: Column(
                    children: [Text(snapshot.data?[index]?.text ?? "")],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
