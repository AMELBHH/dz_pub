import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:dz_pub/view/common_widgets/containers_widgets/container_widget.dart';
import 'package:dz_pub/view/common_widgets/text_widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientProfile extends ConsumerWidget {
  const ClientProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHaveCr = NewSession.get(PrefKeys.isHaveCr, 'no');

    return Column(
      children: [
        if (isHaveCr == "yes") const ClientWithCr(),
        if (isHaveCr == "no") const ClientWithoutCr(),
      ],
    );
  }
}
class ClientWithCr extends ConsumerWidget {
  const ClientWithCr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownerName = NewSession.get(PrefKeys.regOwnerName, '');
    final institution = NewSession.get(PrefKeys.institutionName, '');
    final branchAddress = NewSession.get(PrefKeys.branchAddress, '');
    final rc = NewSession.get(PrefKeys.rcNumber, '');
    final nif = NewSession.get(PrefKeys.nifNumber, '');
    final nis = NewSession.get(PrefKeys.nisNumber, '');
    final iban = NewSession.get(PrefKeys.iban, '');
    final licenseImage = NewSession.get(PrefKeys.imageOfLicense, '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("معلومات الشركة"),
                Text("اسم المالك: $ownerName"),
                Text("اسم المؤسسة: $institution"),
                Text("عنوان الفرع: $branchAddress"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("بيانات السجل التجاري"),
                Text("رقم السجل التجاري (RC): $rc"),
                Text("الرقم الجبائي (NIF): $nif"),
                Text("رقم الضمان الاجتماعي (NIS): $nis"),
                Text("رقم الحساب البنكي (IBAN): $iban"),
              ],
            ),
          ),

          const SizedBox(height: 10),

          ContainerWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("صورة السجل التجاري"),
                licenseImage.isEmpty
                    ? const Text("لا توجد صورة مرفوعة")
                    : Image.network(licenseImage, height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ClientWithoutCr extends ConsumerWidget {
  const ClientWithoutCr({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullName = NewSession.get(PrefKeys.name, '');
    final identityNumber = NewSession.get(PrefKeys.identityNumber, '');
    final gender = NewSession.get(PrefKeys.gender, '');
    final birthday = NewSession.get(PrefKeys.birthday, '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleText("المعلومات الشخصية"),
            Text("الاسم الكامل: $fullName"),
            Text("رقم الهوية: $identityNumber"),
            Text("الجنس: $gender"),
            Text("تاريخ الميلاد: $birthday"),
          ],
        ),
      ),
    );
  }
}
