// import 'package:dz_pub/controllers/providers/auth_provider.dart';
// import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../constants/coordination.dart';
// import '../../../../constants/get_it_controller.dart';
// import '../../../../constants/localization.dart';
// import '../../../../constants/strings.dart';
// import '../../../../session/new_session.dart';
//
// class ButtonCheckerPhoneNumberCompletedWidget extends ConsumerWidget {
//   const ButtonCheckerPhoneNumberCompletedWidget({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Row(
//       children: [
//         Text(
//           SetLocalization.of(context)!.getTranslateValue("verify_via_whatsapp"),
//           style: TextStyle(
//             color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
//             fontSize: getIt<AppDimension>().isSmallScreen(context) ? 12 : 14,
//           ),
//         ),
//         TextButton(
//             style: ButtonStyle(
//                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
//                   horizontal: 5,
//                 )),
//                 alignment: NewSession.get(
//                             PrefKeys.language,
//                             ""
//                                 "ar") ==
//                         "en"
//                     ? Alignment.centerLeft
//                     : Alignment.centerRight),
//             onPressed: () {
//               ref.read(hasCheckedPhone.notifier).state = true;
//
//
//             child: Text(
//               SetLocalization.of(context)!.getTranslateValue("verify"),
//               style: TextStyle(
//                   color: Colors.blue,
//                   fontSize:
//                       getIt<AppDimension>().isSmallScreen(context) ? 12 : 14,
//                   fontFamily: 'Cairo'),
//             ))
//       ],
//     );
//   }
// }
