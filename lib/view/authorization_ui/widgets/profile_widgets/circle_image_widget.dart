
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/view/authorization_ui/widgets/profile_widgets/defult_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../../constants/strings.dart';
import '../../../../../session/new_session.dart';

class CircleImageWidget extends ConsumerWidget {
  const CircleImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      alignment: NewSession.get(PrefKeys.language, 'ar') == 'en'
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref)),
            (ref.read(themeModeNotifier.notifier).backgroundAppTheme(ref: ref)),
            (ref.read(themeModeNotifier.notifier).containerTheme(ref: ref))
          ],
          // Three colors
          begin: Alignment.bottomCenter, // Horizontal gradient
          end: Alignment.topCenter,
          stops: const [0, 0.25, 0.0], // Color stops
        ),
      ),
      child: GestureDetector(
onTap: (){
  debugPrint("NewSession.get(PrefKeys.userType) : ${NewSession.get(PrefKeys
      .userType, '')}");
},
        child:

     //   ref.watch(profileImageFile)?.path != null ?
     //   const MobileStorageImageWidget(radius: 40,):
     //   ( NewSession.get(PrefKeys.profile, "def") != "images/profile/user
        //   .png"?
      //  const ServerImageWidget(radius: 40,):
        const DefaultImageWidget(radius: 40,)
        //),


      ),
    );
  }
}
