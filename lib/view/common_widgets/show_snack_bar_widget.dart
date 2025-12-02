// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class ShowSnackBarWidget extends ConsumerStatefulWidget {
//   const ShowSnackBarWidget({super.key, this.icon ,required this.message,
//   required this.context});
// final BuildContext context;
//   final String message;
//   final IconData? icon;
//
//   @override
//   ConsumerState createState() => _ShowSnackBarWidgetState();
// }
//
// class _ShowSnackBarWidgetState extends ConsumerState<ShowSnackBarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: Row(
//         children: [
//           if (widget.icon != null) Icon(widget.icon, size: 20),
//           const SizedBox(width: 8),
//           Text(widget.message),
//         ],
//       ),
//     );
//   }
// }
