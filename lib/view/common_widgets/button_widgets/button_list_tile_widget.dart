import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';

class ButtonListTileWidget extends ConsumerWidget {
  const ButtonListTileWidget(
      {super.key,
      required this.onTap,
      required this.title,
      this.image,
      this.icon,
      this.color});

  final Function onTap;
  final String title;
  final Image? image;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      iconColor: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

      onTap: () {
        onTap.call();
      },
      dense: getIt<AppDimension>().isSmallScreen(context),
      splashColor:
          ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref),
      // minVerticalPadding: ,

      contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      // leading: icon ,
      leading: image!=null || icon != null
          ? (image ??
              Icon(
                icon,
                size:
                    getIt<AppDimension>().isSmallScreen(context) ? 32 - 5 : 32,
              ))
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: getIt<AppDimension>().isSmallScreen(context) ?14: 16,
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
        ),
      ),
      trailing: Icon(
        size: getIt<AppDimension>().isSmallScreen(context) ? 24 - 4 : 24,
        Icons.arrow_forward_ios_rounded,
        color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      ),
    );
  }
}
