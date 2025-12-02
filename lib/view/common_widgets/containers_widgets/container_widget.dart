import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../controllers/providers/color_provider.dart';


class ContainerWidget extends ConsumerWidget {
  const ContainerWidget({super.key,required this.child,this.bottomMargin,this
      .horizontalPadding});
final Widget child;
final double ? bottomMargin;
final double ? horizontalPadding;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity  ,
      margin:  EdgeInsets.fromLTRB(10, 2, 10, bottomMargin??10),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding??10)
          .copyWith(bottom: 10),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(7),
        color: ref.read(themeModeNotifier.notifier).containerTheme(ref: ref),

      ),
      child: child,
    );
  }
}
