import 'package:dz_pub/api/users.dart';
import 'package:dz_pub/client/screens/client/Influencer_profile_details_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:flutter/material.dart';

class InfluencerInfoCard extends StatefulWidget {
  final User ?influencerModel;

  const InfluencerInfoCard({super.key,  this.influencerModel});

  @override
  State<InfluencerInfoCard> createState() => _InfluencerInfoCardState();
}

class _InfluencerInfoCardState extends State<InfluencerInfoCard> {
  @override
  Widget build(BuildContext context) {
    final user = widget.influencerModel;
    final influencer = user?.influencer;

    return CardContainer(
      title: "المؤثر",
      child:

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اسم المؤثر: ${user?.name ?? '--'}"),
          Text("التصنيف: ${influencer?.typeId  == 1 ? "معنوي": ""
              "طبيعي" }"),
          Text("التقييم: ${influencer?.rating ?? '--'}"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              //show detials of influncer
              Spacer(),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                => InfluencerProfileDetails(influencer: user,)));
              }, child: Text("المزيد عن المؤثر"))
            ],
          )

        ],
      ),
    );
  }
}
