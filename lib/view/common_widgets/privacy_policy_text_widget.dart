// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../constants/coordination.dart';
// import '../../../../constants/get_it_controller.dart';
// import '../../../../constants/localization.dart';
// import '../../../../constants/strings.dart';
// import '../../controller/provider_controllers/providers/color_provider.dart';
// import '../../core/utils/funcations/route_pages/push_routes.dart';
//
// class PrivacyPolicyTextWidget extends ConsumerWidget {
//   const PrivacyPolicyTextWidget({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: EdgeInsets.only(
//           top: getIt<AppDimension>().isSmallScreen(context) ? 22 : 30.0),
//       child: GestureDetector(
//         onTap: () {
//           myPushName(context, MyPagesRoutes.privacyPolicy);
//         },
//         child: Opacity(
//           opacity: .5,
//           child: Text(
//             SetLocalization.of(context)!.getTranslateValue("agree_terms"),
//             style: TextStyle(
//               decoration: TextDecoration.underline,
//               color: Colors.blue,
//               fontSize: 14.5,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
