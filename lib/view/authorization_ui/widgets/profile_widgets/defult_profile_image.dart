import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DefaultImageWidget extends ConsumerWidget {
  const   DefaultImageWidget({super.key,this.radius});
  final double? radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      radius:radius,
      //put a normal person Icon
      backgroundColor: Colors.grey.shade700,
      child: Icon(
        Icons.person,
        size: radius,///the size of Icon is always equal to the radius.
        color: Colors.white,
      ),
    );
  }
}
