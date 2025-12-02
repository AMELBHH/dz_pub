import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:dz_pub/controllers/auth/providers/color_provider.dart';
import 'package:dz_pub/view/common_widgets/drop_down_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../constants/coordination.dart';
import '../../../../constants/get_it_controller.dart';

class DropDownUserTypeWidget extends ConsumerStatefulWidget {
  const DropDownUserTypeWidget({super.key, required this.stringValues});

  final List<String> stringValues;

  @override
  ConsumerState createState() => _DropDownUserTypeWidgetState();
}

class _DropDownUserTypeWidgetState
    extends ConsumerState<DropDownUserTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        TypeOfUserTitle(),
        DropdownFieldWidget(
          onChanged: (newValue) {
            ref.read(dropdownProvider.notifier).setSelectedItem(
                stringValues: widget.stringValues, currentValue: newValue);
          },
          items: ref.read(typeOfUser),
          isStringOnly: true,
        ),
        SizedBox(
          height: getIt<AppDimension>().isSmallScreen(context)
              ? 0
              : 10,
        )      ],
    );
  }
}

class TypeOfUserTitle extends ConsumerWidget {
  const TypeOfUserTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Text(
        "إختر صنفك",
        style: TextStyle(
          color: ref.read(themeModeNotifier.notifier).textTheme(ref: ref),
          fontSize: getIt<AppDimension>().isSmallScreen(context) ? 12 : 14,
        ),
        softWrap: true,
      ),
    );
  }
}
