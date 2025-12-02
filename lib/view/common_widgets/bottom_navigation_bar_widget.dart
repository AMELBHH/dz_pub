// import 'package:flutter/material.dart';
// import 'package:ween_blaqe/controller/provider_controllers/providers/apartment_provider.dart';
// import '../../../constants/localization.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../controller/provider_controllers/providers/auth_provider.dart';
// import '../../controller/provider_controllers/providers/color_provider.dart';
//
// class BottomNavigationBarWidget extends ConsumerWidget {
//   final ScrollController? scrollController;
//
//   const BottomNavigationBarWidget({
//     super.key,
//     this.scrollController,
//   });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final indexNotifier = ref.read(btmNavBarIndexNotifier);
//
//     return BottomNavigationBar(
//       selectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
//       unselectedLabelStyle: const TextStyle(),
//       backgroundColor:
//           ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),
//       selectedItemColor:
//           ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref),
//       unselectedItemColor: Colors.grey,
//       type: BottomNavigationBarType.fixed,
//       iconSize: 30,
//       elevation: 0,
//       currentIndex: indexNotifier,
//       onTap: (i) {
//         if (i == 0 && indexNotifier == 0) {
//           // ref.read(isShowOwnerApartmentMode.notifier).state = false;
//           debugPrint(
//               "hasApartmentChanged -- ${ref.watch(isApartmentDataChangedNotifier.notifier).hasAnyChange(ref)}");
//           debugPrint("scrollController offset is ${scrollController?.offset}");
//           // Scroll to top when already on the home page
//           if (scrollController != null && scrollController!.offset > 400) {
//             scrollController!.animateTo(
//               0,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//             );
//           } else if (i == 0 &&
//               indexNotifier == 0 &&
//               scrollController!.offset < 100) {
//             ref.read(isAllTypesOfApartmentNotifier.notifier).state = true;
//             ref.read(selectedCityIdToFilter.notifier).state = 0;
//             ref.read(selectedTypeOwnerId.notifier).state = -1;
//             WidgetsBinding.instance.addPostFrameCallback((_) async {
//               await ref.read(fetchApartmentNotifier.notifier).fetchApartments(
//                   isOwnerApartments: false, isAll: true, cityId: 0, ref: ref);
//             });
//             ref.read(isBoyStudentNotifier.notifier).state = false;
//             ref.read(isGirlStudentNotifier.notifier).state = false;
//             ref.read(isFamiliesNotifier.notifier).state = false;
//           }
//         }
//         if (i == 1) {
//           WidgetsBinding.instance.addPostFrameCallback((_) async {
//             if (ref.read(bookmarkNotifier).bookmarkIds.isNotEmpty &&
//                     ref.read(bookmarkNotifier).bookmarkIds.length <= 2 ||
//                 indexNotifier == 1) {
//               await ref.read(fetchApartmentNotifier.notifier).fetchApartments(
//                   isOwnerApartments: false, isAll: true, cityId: 0, ref: ref);
//             } else if (ref.read(bookmarkNotifier).bookmarkIds.length > 2 &&
//                 indexNotifier == 1) {
//               await ref.read(fetchApartmentNotifier.notifier).fetchApartments(
//                   isOwnerApartments: false, isAll: true, cityId: 0, ref: ref);
//             }
//
//             await ref
//                 .watch(bookmarkNotifier.notifier)
//                 .fetchBookmarkedApartment(ref: ref);
//           });
//         }
//         ref.read(btmNavBarIndexNotifier.notifier).changeTo(i);
//       },
//       items: [
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.home_outlined),
//           label: SetLocalization.of(context)!.getTranslateValue("home"),
//           activeIcon: const Icon(Icons.home),
//         ),
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.bookmark_border_outlined),
//           label: SetLocalization.of(context)!.getTranslateValue("favorites"),
//           activeIcon: const Icon(Icons.bookmark),
//         ),
//         BottomNavigationBarItem(
//           icon: const Icon(Icons.person_2_outlined),
//           label: SetLocalization.of(context)!.getTranslateValue("my_account"),
//           activeIcon: const Icon(Icons.person_2),
//         ),
//       ],
//     );
//
//   }
// }
