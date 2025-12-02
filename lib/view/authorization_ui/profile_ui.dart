import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/circle_image_widget.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/client_profile.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/logout_button_widget.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/user_info_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/strings.dart';
import '../../session/new_session.dart';
import '../common_widgets/containers_widgets/container_widget.dart';
import 'widgets/profile_widgets/influencer_profile.dart';

// import your widgets:
/// CircleImageWidget()
/// UserInfoWidget()
/// InfluencerProfile()
/// ClientProfile()
/// UserProfileSkeletonUi()
/// ContainerWidget()
/// PrefKeys + NewSession

class ProfileUi extends ConsumerWidget {
  const ProfileUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLoading =
    //     ref.watch(loadProfileImageNotifier).isLoading ||
    //         ref.watch(compressAndUploadImageNotifier).isLoading;

    // if (isLoading) {
    //   return const UserProfileSkeletonUi();
    // }

    // get user type from SharedPreferences
    final userType = NewSession.get(PrefKeys.userType, 'client');
    final userTypeId = NewSession.get(PrefKeys.userTypeId, 1);

    return



      SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 10),

          /// ----------- PROFILE IMAGE -----------
          const CircleImageWidget(),

          const SizedBox(height: 15),

          /// ----------- USER INFO -----------
          const ContainerWidget(
            child: UserInfoWidget(),
          ),

          const SizedBox(height: 10),

          /// ----------- INFLUENCER -----------
          if (userType == "influencer" || userTypeId == 2)
            const InfluencerProfile(),

          /// ----------- CLIENT -----------
          if (userType == "client" || userTypeId == 1)
            const ClientProfile(),

          const SizedBox(height: 20),

        const LogoutButtonWidget(),
        ],
      ),
    );
  }
}
