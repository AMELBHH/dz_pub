import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';
import '../../../controllers/auth/providers/color_provider.dart';
class TitleWidget extends ConsumerWidget {
  const TitleWidget({super.key,required this.title});
  final String title;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  20),
          child: Text(
            title,
            style:   TextStyle(
                fontSize: getIt<AppDimension>().isSmallScreen(context) ? 22 : 26,
                fontWeight: FontWeight.w600,

                inherit: true,
                color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref)
            ),
          ),
        ),
        const Expanded(child: Text("")),
      ],
    );
  }
}
