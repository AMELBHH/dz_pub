import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:dz_pub/controllers/show_snack_bar_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';
/// s [ShowSnackBarNotifier] class has two methods, first [showSnackBar]
/// that show when connection of wifi turn-off , or turn-on ,
/// second [showNormalSnackBar] that show when user make an action that should
/// to take a massage in the UI.
class ShowSnackBarNotifier extends StateNotifier<ShowSnackBarState> {
  ShowSnackBarNotifier() : super(ShowSnackBarState());

  void showSnackBar(
      {required BuildContext context,
      required WidgetRef ref,
      String? message,
      IconData? icon,
      Color ?textColor
      }) {
    message?.isNotEmpty ?? false
        ? state = state.copyWith(message: message)
        : state = state.copyWith(message: null);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
        margin: EdgeInsets.only(
            bottom: icon != null ? 70 : 55, left: 25, right: 25),

        duration: const Duration(seconds: 3),

        padding: icon != null ? const EdgeInsets.all(10) : kTabLabelPadding,
        content: icon != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    icon,
                 //   color: ref.read(connectivityNotifier.notifier).isConnected
                     //   ? Colors.green
                   //     : Colors.grey.withValues(alpha: .87),
                    size: 28,
                  ),
                ],
              )
            : Text(
                state.message ?? "",
                style: TextStyle(
                  fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
                  fontFamily: "Cairo",
                  color: textColor??
                      ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
                ),
              ),
      ),
    );
  }

  void showNormalSnackBar(
      {required BuildContext context,
      String? message,
      Color? backgroundColor,
      Color? textColor}) {
    message?.isNotEmpty ?? false
        ? state = state.copyWith(message: message)
        : state = state.copyWith(message: null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,

        duration: const Duration(seconds: 3),
        // padding: kTabLabelPadding,
        content: Text(
          state.message ?? "",
          style: TextStyle(
            fontSize: getIt<AppDimension>().isSmallScreen(context) ? 14 : 16,
            fontFamily: "Cairo",
            color: textColor,
          ),
        ),
      ),
    );
  }
}
final showSnackBarNotifier =
StateNotifierProvider<ShowSnackBarNotifier,ShowSnackBarState>(
        (ref) =>ShowSnackBarNotifier());
