
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/view/common_widgets/containers_widgets/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/coordination.dart';
import '../../../constants/get_it_controller.dart';

class ContainerLoadWidget extends ConsumerStatefulWidget {
  const ContainerLoadWidget(
      {super.key,
      required this.title,
      required this.child,
      required this.isLoading,
      this.textStyle}) ;

  final bool isLoading;
  final Widget child;
  final String title;
  final TextStyle ? textStyle;

  @override
  ConsumerState createState() => _ContainerLoadWidgetState();
}

class _ContainerLoadWidgetState
    extends ConsumerState<ContainerLoadWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
        child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                widget.title,
                style: widget.textStyle ??TextStyle(
                  color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),

                  fontSize:
                      getIt<AppDimension>().isSmallScreen(context) ? 16 : 18,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget.isLoading
              ? Text(
    "جاري التحميل..."
            // SetLocalization.of(context)!.getTranslateValue("loading"
            //   "...")
            ,
            style:  TextStyle(color: ref.read
            (themeModeNotifier
              .notifier).textTheme(ref: ref),
          ),)
              :
          widget.child,
        )
      ],
    ));
  }
}
