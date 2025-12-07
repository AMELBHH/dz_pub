import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/widget/promotion_widgets/card_container_widget.dart';
import 'package:flutter/cupertino.dart';

class ClientInfoCard extends StatelessWidget {

  const ClientInfoCard({super.key});

  @override
  Widget build(BuildContext context) {


    return CardContainer(
      title: "العميل",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("اسم المستخدم: ${NewSession.get(PrefKeys.name, "name")}"),
          Text("البريد: ${NewSession.get(PrefKeys.email, "email")}"),
          Text("لديه سجل تجاري: ${NewSession.get(PrefKeys.isHaveCr, "no") == ""
              "yes" ? 'نعم' : 'لا'
          }"),
        ],
      ),
    );
  }
}
