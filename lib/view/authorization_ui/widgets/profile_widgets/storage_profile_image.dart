import 'dart:io';

import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MobileStorageImageWidget extends ConsumerWidget {
  const MobileStorageImageWidget({super.key,this.radius});
  final double ?radius;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
        radius:radius,

        //
        // backgroundImage: NetworkImage(NewSession.get("profile","def")),
        // Adjust the radius as needed
        backgroundColor: Colors.grey.shade700,
        // Set the background color of the avatar
        backgroundImage:
        FileImage(File( ref.watch(profileImageFile)?.path ?? "")))
    ;
  }
}
