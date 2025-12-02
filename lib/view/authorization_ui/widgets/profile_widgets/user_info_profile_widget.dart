import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

class UserInfoWidget extends ConsumerWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = NewSession.get(PrefKeys.name, '');
    final email = NewSession.get(PrefKeys.email, '');
    final phone = NewSession.get(PrefKeys.phone, '');
    final nickName = NewSession.get(PrefKeys.nickName, '');
    final createdAt = NewSession.get(PrefKeys.createdAt, '');
    final isVerified = NewSession.get(PrefKeys.isVerified, 'no');

    final createdAtString = NewSession.get(PrefKeys.createdAt, '');

// Check if the string is not empty
    String formattedCreatedAt = '';
    if (createdAtString.isNotEmpty) {
      try {
        // Parse the string into a DateTime object
        final createdAt = DateTime.parse(createdAtString);

        // Format it into a human-friendly format, e.g., "Nov 30, 2025 at 4:30 PM"
        final formatter = intl.DateFormat('MMM d, yyyy');
        formattedCreatedAt = formatter.format(createdAt);
      } catch (e) {
        formattedCreatedAt = createdAtString; // fallback if parsing fails
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // NAME + VERIFIED
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name.isEmpty ? "مستخدم غير معروف" : name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isVerified == "1" ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isVerified == "yes" ? "مُوَثَّق" : "غير مُوَثَّق",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // PHONE
          Text(
            "رقم الهاتف: $phone",
            style: const TextStyle(fontSize: 14),
          ),

          // EMAIL
          Text(
            "البريد الإلكتروني: $email",
            style: const TextStyle(fontSize: 14),
          ),    Text(
            "اللقب: $nickName",
            style: const TextStyle(fontSize: 14),
          ),
          //nickName



          const SizedBox(height: 10),

          // JOIN DATE
          Text(
            createdAt.isEmpty ? "تاريخ الانضمام: غير متوفر" : "تاريخ "
                "الانضمام: $formattedCreatedAt",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
