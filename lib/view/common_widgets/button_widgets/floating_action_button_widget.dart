// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
//
// import '../../../constants/localization.dart';
// import '../../../constants/strings.dart';
// import '../../../session/new_session.dart';
//
// class FloatingActionButtonWidget extends ConsumerStatefulWidget {
//   const FloatingActionButtonWidget({super.key});
//
//   @override
//   FloatingActionButtonWidgetState createState() =>
//       FloatingActionButtonWidgetState();
// }
//
// class FloatingActionButtonWidgetState
//     extends ConsumerState<FloatingActionButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     var isConnected = ref.watch(connectivityNotifier.notifier).isConnected;
//
//     return FloatingActionButton(
//       tooltip: SetLocalization.of(context)!.getTranslateValue("add_ad"),
//       backgroundColor:
//           ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
//       shape: ContinuousRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       onPressed: () {
//         setState(() {
//           isConnected;
//         });
//         debugPrint("is connected $isConnected");
//         if (isConnected) {
//           if (NewSession.get(PrefKeys.logged, "") == "") {
//             /// this how show if user not logged
//             ref.read(alertNotifier.notifier).alertWithTwoBtn(
//                   textColor:
//                       ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
//                   borderColor: ref
//                       .read(themeModeNotifier.notifier)
//                       .primaryTheme(ref: ref),
//                   containerColor: ref
//                       .read(themeModeNotifier.notifier)
//                       .containerTheme(ref: ref),
//                   onClickOkBtn: () {
//                     Navigator.pop(context);
//                     myPushName(context, MyPagesRoutes.login);
//                   },
//                   textOfCancelButton:
//                       SetLocalization.of(context)!.getTranslateValue("cancel"),
//                   context: context,
//                   //login_to_create_ad
//                   title:
//                       SetLocalization.of(context)!.getTranslateValue("login"),
//                   message: SetLocalization.of(context)!
//                       .getTranslateValue("login_to_create_ad"),
//                   // SetLocalization.of(context)!
//                   //     .getTranslateValue("login_to_add_apartment"),
//                   textOfOkButton:
//                       SetLocalization.of(context)!.getTranslateValue("login"),
//                 );
//           } else {
//             myPushName(context, MyPagesRoutes.step1);
//           }
//         } else {
//           /// this show if no internet have
//           ref.watch(showSnackBarNotifier.notifier).showNormalSnackBar(
//                 backgroundColor: ref
//                     .read(themeModeNotifier.notifier)
//                     .backgroundAppTheme(ref: ref),
//                 textColor:
//                     ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
//                 context: context,
//                 message: SetLocalization.of(context)!
//                     .getTranslateValue("no_internet"),
//               );
//           return;
//         }
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           ref.read(toggleOwnerButtonsNotifier).isEdit = false;
//           ref.read(toggleOwnerButtonsNotifier).isDelete = false;
//         });
//       },
//       child: const Icon(
//         Icons.add_home_outlined,
//         color: Colors.white,
//       ),
//     );
//   }
// }
