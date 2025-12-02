import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget aline =  const Aline();
class Aline extends ConsumerWidget {
  const Aline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Divider(
      color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

      height: 1,
      thickness: .5,
    );
  }
}


