import 'package:dz_pub/controllers/auth/providers/auth_provider.dart';
  import 'package:dz_pub/view/common_widgets/button_widgets/outline_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' ;

class LogoutButtonWidget extends ConsumerStatefulWidget {
  const LogoutButtonWidget({super.key});

  @override
  ConsumerState createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends ConsumerState<LogoutButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 60),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: OutlinedButtonWidget(
          child: const Text(
            "تسجيل الخروج",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            /// مسح كل البيانات من الذاكرة
         await ref.read(logoutNotifier.notifier).logout();
          },
        ),
      ),
    );
  }
}
