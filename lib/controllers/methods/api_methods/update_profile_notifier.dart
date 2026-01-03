import 'dart:convert';
import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../../statuses/auth_state.dart';

class UpdateProfileNotifier extends StateNotifier<AuthState> {
  UpdateProfileNotifier() : super(AuthState());

  /// Update user profile data - supports all user types dynamically
  Future<bool> updateProfile({
    // Common fields
    String? name,
    String? email,
    String? phoneNumber,
    String? identityNumber,

    // Influencer fields
    String? bio,
    String? gender,
    String? dateOfBirth,
    String? shakeNumber,

    // Client without CR
    String? nickname,

    // Client with CR
    String? regOwnerName,
    String? institutionName,
    String? branchAddress,
    String? institutionAddress,
    String? rcNumber,
    String? nisNumber,
    String? nifNumber,
    String? iban,

    BuildContext? context,
  }) async {
    state = AuthState(isLoading: true);

    try {
      final token = NewSession.get(PrefKeys.token, '');
      final url = Uri.parse(ServerLocalhostEm.updateProfile);

      // Build dynamic request body - only include non-null fields
      final Map<String, dynamic> body = {};

      // Common fields
      if (name != null && name.isNotEmpty) body['name'] = name;
      if (email != null && email.isNotEmpty) body['email'] = email;
      if (phoneNumber != null && phoneNumber.isNotEmpty)
        body['phone_number'] = phoneNumber;
      if (identityNumber != null && identityNumber.isNotEmpty)
        body['identity_number'] = identityNumber;

      // Influencer fields
      if (bio != null && bio.isNotEmpty) body['bio'] = bio;
      if (gender != null && gender.isNotEmpty) body['gender'] = gender;
      if (dateOfBirth != null && dateOfBirth.isNotEmpty)
        body['date_of_birth'] = dateOfBirth;
      if (shakeNumber != null && shakeNumber.isNotEmpty)
        body['shake_number'] = shakeNumber;

      // Client fields
      if (nickname != null && nickname.isNotEmpty) body['nickname'] = nickname;
      if (regOwnerName != null && regOwnerName.isNotEmpty)
        body['reg_owner_name'] = regOwnerName;
      if (institutionName != null && institutionName.isNotEmpty)
        body['institution_name'] = institutionName;
      if (branchAddress != null && branchAddress.isNotEmpty)
        body['branch_address'] = branchAddress;
      if (institutionAddress != null && institutionAddress.isNotEmpty)
        body['institution_address'] = institutionAddress;
      if (rcNumber != null && rcNumber.isNotEmpty) body['rc_number'] = rcNumber;
      if (nisNumber != null && nisNumber.isNotEmpty)
        body['nis_number'] = nisNumber;
      if (nifNumber != null && nifNumber.isNotEmpty)
        body['nif_number'] = nifNumber;
      if (iban != null && iban.isNotEmpty) body['iban'] = iban;

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Update session data with new values
        if (name != null && name.isNotEmpty)
          await NewSession.save(PrefKeys.name, name);
        if (email != null && email.isNotEmpty)
          await NewSession.save(PrefKeys.email, email);
        if (phoneNumber != null && phoneNumber.isNotEmpty)
          await NewSession.save(PrefKeys.phone, phoneNumber);
        if (identityNumber != null && identityNumber.isNotEmpty)
          await NewSession.save(PrefKeys.identityNumber, identityNumber);

        // Influencer session updates
        if (bio != null && bio.isNotEmpty)
          await NewSession.save(PrefKeys.inflBio, bio);
        if (gender != null && gender.isNotEmpty)
          await NewSession.save(PrefKeys.inflGender, gender);
        if (dateOfBirth != null && dateOfBirth.isNotEmpty)
          await NewSession.save(PrefKeys.inflDob, dateOfBirth);
        if (shakeNumber != null && shakeNumber.isNotEmpty)
          await NewSession.save(PrefKeys.inflShake, shakeNumber);

        // Client session updates
        if (nickname != null && nickname.isNotEmpty)
          await NewSession.save(PrefKeys.nickName, nickname);
        if (regOwnerName != null && regOwnerName.isNotEmpty)
          await NewSession.save(PrefKeys.regOwnerName, regOwnerName);
        if (institutionName != null && institutionName.isNotEmpty)
          await NewSession.save(PrefKeys.institutionName, institutionName);
        if (branchAddress != null && branchAddress.isNotEmpty)
          await NewSession.save(PrefKeys.branchAddress, branchAddress);
        if (institutionAddress != null && institutionAddress.isNotEmpty)
          await NewSession.save(
            PrefKeys.institutionAddress,
            institutionAddress,
          );
        if (rcNumber != null && rcNumber.isNotEmpty)
          await NewSession.save(PrefKeys.rcNumber, rcNumber);
        if (nisNumber != null && nisNumber.isNotEmpty)
          await NewSession.save(PrefKeys.nisNumber, nisNumber);
        if (nifNumber != null && nifNumber.isNotEmpty)
          await NewSession.save(PrefKeys.nifNumber, nifNumber);
        if (iban != null && iban.isNotEmpty)
          await NewSession.save(PrefKeys.iban, iban);

        state = AuthState(isLoading: false);
        return true;
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['msg'] ?? 'حدث خطأ أثناء تحديث البيانات';

        state = AuthState(
          isLoading: false,
          hasError: true,
          errorMessage: errorMessage,
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      state = AuthState(
        isLoading: false,
        hasError: true,
        errorMessage: 'حدث خطأ في الاتصال بالخادم',
      );
      return false;
    }
  }
}
