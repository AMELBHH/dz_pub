import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';

class TitleLoginCompletedWidget extends ConsumerWidget {
  const TitleLoginCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
     padding:  EdgeInsets.fromLTRB(20,
          getIt<AppDimension>().isSmallScreen(context) ? 20 : 30, 20, 30),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تسجيل الدخول"
                //  SetLocalization.of(context)!.getTranslateValue("login")
      ,
            style: TextStyle(
                fontSize:
                    getIt<AppDimension>().isSmallScreen(context) ? 22 : 26,
                fontWeight: FontWeight.w600,
                inherit: true,
                color:
                    ref.read(themeModeNotifier.notifier).textTheme(ref: ref)),
          ),
          //nameApp

          // Row(
          //   children: <Widget>[
          //     Text(
          //       SetLocalization.of(context)!.getTranslateValue("in"),
          //       style: TextStyle(
          //           fontSize: getIt<AppDimension>().isSmallScreen(context)
          //               ? 22
          //               : 26,
          //           inherit: true,
          //           fontWeight: FontWeight.w600,
          //           color: ref
          //               .read(themeModeNotifier.notifier)
          //               .textTheme(ref: ref)),
          //     ),
          //     SizedBox(width: 10,),
          //     Text(
          //       SetLocalization.of(context)!
          //           .getTranslateValue("aqaree"),
          //       style: TextStyle(
          //         fontSize: getIt<AppDimension>().isSmallScreen(context)
          //             ? 22
          //             : 26,
          //         inherit: true,
          //         color: ref
          //             .read(themeModeNotifier.notifier)
          //             .primaryTheme(ref: ref),
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
