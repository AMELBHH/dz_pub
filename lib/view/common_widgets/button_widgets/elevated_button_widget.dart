import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';
class ElevatedButtonWidget extends ConsumerWidget {
  const ElevatedButtonWidget( {super.key, required this.child, required this
      .onPressed,required this.context,this.color,this.onLongPress,});
  final void Function()? onPressed;
  final Widget child;
  final Color? color;
  final  void Function()?onLongPress;
  final BuildContext context;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onLongPress: onLongPress,
      onPressed: onPressed
      ,style: fullButton(color: color??ref.read(themeModeNotifier.notifier)
        .primaryTheme(ref: ref),context: context)
      , child: child,);
  }
}

ButtonStyle fullButton({required Color color , required BuildContext context}) {
  return ElevatedButton.styleFrom(
    backgroundColor: color,
    elevation: 0,
    textStyle: TextStyle(

      fontSize: getIt<AppDimension>().isSmallScreen(context) ?14: 16,
      fontFamily: "Cairo",
      fontWeight:getIt<AppDimension>().isSmallScreen(context) ?  FontWeight
          .w500: FontWeight.w400,
      color: Colors.white,
    ),

    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7))),
  );
}
