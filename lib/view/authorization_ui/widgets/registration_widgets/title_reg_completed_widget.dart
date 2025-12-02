import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';

class TitleRegCompletedWidget extends ConsumerWidget {
  const TitleRegCompletedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: const Row(
        spacing: 10,

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleScreenWidget(),
          // NameOfApp(),
        ],
      ),
    );
  }
}
class TitleScreenWidget extends ConsumerWidget {
  const TitleScreenWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return
        //title signup
        Text(
          "إبدأ التسجيل"
            //SetLocalization.of(context)!.getTranslateValue("start_registration")
            ,
          style: TextStyle(
            fontSize: getIt<AppDimension>().isSmallScreen(context) ? 22 : 26,
            inherit: true,
            fontWeight: FontWeight.w600,
            color:
            ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          ),
        );
    //nameApp
  }
}

// class NameOfApp extends ConsumerWidget {
//   const NameOfApp({super.key});
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return Row(
//       spacing: 10,
//       children: [
//         Text(
//           SetLocalization.of(context)!.getTranslateValue("in"),
//           style: TextStyle(
//               fontSize:
//                   getIt<AppDimension>().isSmallScreen(context) ? 22 : 26,
//               inherit: true,
//               fontWeight: FontWeight.w600,
//               color:
//               ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
//     ),
//         ),
//         Text(
//           SetLocalization.of(context)!.getTranslateValue("aqaree"),
//           style: TextStyle(
//             fontSize: getIt<AppDimension>().isSmallScreen(context) ? 22 : 26,
//             inherit: true,
//             color: ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
//
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
