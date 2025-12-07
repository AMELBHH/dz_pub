// import 'package:dz_pub/api/promations_models/promotions.dart';
// import 'package:flutter/material.dart';
//
// class FilesSection extends StatelessWidget {
//   final Promotion promotion;
//
//   const FilesSection({super.key, required this.promotion});
//
//   @override
//   Widget build(BuildContext context) {
//     final files = promotion.file ?? [];
//
//     if (files.isEmpty) return const SizedBox();
//
//     return CardContainer(
//       title: "الملفات",
//       child: Column(
//         children: files.map((file) {
//           final url = file.file_path;
//
//           if (url.endsWith(".jpg") || url.endsWith(".png")) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Image.network(url),
//             );
//           }
//
//           if (url.endsWith(".mp4")) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: Text("🎬 فيديو: $url"),
//             );
//           }
//
//           return Text("ملف: $url");
//         }).toList(),
//       ),
//     );
//   }
// }
