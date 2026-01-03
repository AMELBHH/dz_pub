import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/circle_image_widget.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/client_profile.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/logout_button_widget.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/user_info_profile_widget.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/strings.dart';
import '../../controllers/providers/auth_provider.dart';
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          /// ----------- PROFILE IMAGE -----------
          const CircleImageWidget(),

          const SizedBox(height: 15),

          /// ----------- USER INFO -----------
          const ContainerWidget(child: UserInfoWidget()),

          const SizedBox(height: 10),

          /// ----------- EDIT PROFILE BUTTON -----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer(
              builder: (context, ref, child) {
                final isCheckingVerification = ref
                    .watch(checkVerificationNotifier)
                    .isLoading;

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: isCheckingVerification
                        ? null
                        : () async {
                            // Check verification status from API
                            final notifier = ref.read(
                              checkVerificationNotifier.notifier,
                            );
                            final isVerified = await notifier
                                .checkVerificationStatus();

                            if (!context.mounted) return;

                            if (isVerified) {
                              // Navigate to update profile screen
                              context.push('/Update_Profile');
                            } else {
                              // Show snackbar message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'لا يمكنك تعديل البيانات حتى يتم التحقق من حسابك',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.orange,
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                    icon: isCheckingVerification
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.edit),
                    label: Text(
                      isCheckingVerification
                          ? 'جاري التحقق...'
                          : 'تعديل الملف الشخصي',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ref
                          .read(themeModeNotifier.notifier)
                          .primaryTheme(ref: ref),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// ----------- INFLUENCER -----------
          if (userTypeId == 2) const InfluencerProfile(),

          /// ----------- CLIENT -----------
          if (userTypeId == 1) const ClientProfile(),

          const SizedBox(height: 20),

          const LogoutButtonWidget(),
        ],
      ),
    );
  }
}
