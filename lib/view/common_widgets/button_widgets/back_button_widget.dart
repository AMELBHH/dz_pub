import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BackButtonWidget extends ConsumerWidget {
 final void Function()? onPressed;
 final ButtonStyle? style;
  const BackButtonWidget({super.key, this.onPressed,this.style});

  @override
  Widget build(BuildContext context,WidgetRef ref,) {
    return BackButton(
      style: style,
      color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
      onPressed: onPressed,
    );
  }
}
