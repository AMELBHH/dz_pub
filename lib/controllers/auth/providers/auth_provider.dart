import 'dart:async';

import 'package:dz_pub/controllers/auth/methods/api_methods/refresh_user_data_notifier.dart';
import 'package:dz_pub/controllers/auth/methods/api_methods/register_notifier.dart';
import 'package:dz_pub/controllers/auth/methods/hybrid_methods/drop_down_notifier.dart';
import 'package:dz_pub/controllers/auth/statuses/auth_state.dart';
import 'package:dz_pub/controllers/auth/statuses/validate_text_form_field_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/categories.dart';
import '../../../api/users.dart';
import '../methods/api_methods/login_notifier.dart';
import '../methods/hybrid_methods/auth_validator/login_and_reg_validators/text_field_validate_notifier.dart';
import '../methods/local_methods/logout_notifier.dart';

// import '../../../controller/provider_controllers/local_methods/switcher_theme_mode.dart';


final registerNotifier = StateNotifierProvider<RegisterNotifier, AuthState>(
    (ref) => RegisterNotifier());

final loginNotifier = StateNotifierProvider<LoginNotifier, AuthState>((ref) {
  return LoginNotifier();
});

final logoutNotifier = StateNotifierProvider<LogoutNotifier, AuthState>((ref) {
  return LogoutNotifier();
});
// final loadProfileImageNotifier =
//     StateNotifierProvider<LoadProfileImageNotifier, AuthState>(
//         (ref) => LoadProfileImageNotifier());
// final compressAndUploadImageNotifier =
//     StateNotifierProvider<CompressAndUploadProfileImageNotifier, AuthState>(
//         (ref) => CompressAndUploadProfileImageNotifier());

/// a [formFieldsNotifier] only usage for textFormField widgets in two UI Screens
/// [LoginUi] and [RegistrationUi]
final userObjectProvider = StateProvider<User?>((ref) => null);
final formFieldsNotifier =
    StateNotifierProvider<FormFieldsNotifier, Map<String, TextFieldState>>(
        (ref) => FormFieldsNotifier());



final refreshUserDataNotifier =
    StateNotifierProvider<RefreshUserDataNotifier, AuthState>(
        (ref) => RefreshUserDataNotifier());






final dropdownProvider = StateNotifierProvider<DropdownNotifier, int>((ref) {
  return DropdownNotifier();
});


final emailLoginController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});


final otpCodeController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

final passwordLoginController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
/*
  String ? phone,
  String ? identityNumber,
  String ?nickname,
  String ? regOwnerName,
  String ? institutionName,
  String ? branchAddress,
  String? institutionAddress,
  String ? rcNumber,
  String ? nisNumber,
  String ? iban,
  String ? isHaveCr,
  String?typeOfInfluencer,
  List<int> ?categoryIds,
  List<int> ? socialMediaIds,
  List<String> ? socialMediaLinks,
 */
final phoneController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final identityNumberController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final nicknameController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});
final bioController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final regOwnerNameController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final institutionNameController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final branchAddressController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final institutionAddressController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final rcNumberController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final nisNumberController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});
final nifNumberController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});

final ibanController = StateProvider<TextEditingController>((ref) {
  final c = TextEditingController();
  ref.onDispose(() => c.dispose());
  return c;
});



// For select or dropdowns (NOT text)

// For arrays
  final categoryIdsProvider = StateProvider<List<int>>((ref) => []);
  final socialMediaIdsProvider = StateProvider<List<int>>((ref) => []);
  final socialMediaLinksProvider = StateProvider<List<String>>((ref) => []);

final passwordRegController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final newPasswordController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final sureNewPasswordController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final oldPasswordController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final updateUsernameController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final updatePhoneNumberController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final streamUpdateUserDataController = StateProvider<StreamController<String>>(
  (ref) {
    final controller = StreamController<String>.broadcast();
    ref.onDispose(() => controller.close());
    return controller;
  },
);
final whatsappController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

final facebookController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

final emailController = StateProvider<TextEditingController>((ref) {
  //Reg => registration
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

final userNameController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});
final sendNoticeForUcController = StateProvider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(
      () => controller.dispose()); // Dispose when the provider is disposed
  return controller;
});

final isObscure = StateProvider<bool>((ref) => true);
final hasCheckedPhone = StateProvider<bool>((ref) => false);
final isPhoneNumberIsAlreadyTaken = StateProvider<bool>((ref) => false);
final isPop = StateProvider<bool>((ref) => false);
final whatsAppIsActive = StateProvider<bool>((ref) => true);
final phoneIsActive = StateProvider<bool>((ref) => true);
final emailIsActive = StateProvider<bool>((ref) => false);
final facebookIsActive = StateProvider<bool>((ref) => false);
final isOldPassword = StateProvider<bool>((ref) => false);
final dataHasChanged = StateProvider<bool>((ref) => false);
final isSureObscure = StateProvider<bool>((ref) => true);
final isUpdateImageProfile = StateProvider<bool>((ref) => false);
final isShowOwnerApartmentMode = StateProvider<bool>((ref) => false);
// final locationServiceChecker = StateProvider<bool>((ref) => false);
final isClient = StateProvider<bool>((ref) => false);
final email = StateProvider<String>((ref) => "");
final facebook = StateProvider<String>((ref) => "");
final phone = StateProvider<String>((ref) => "");
final whatsapp = StateProvider<String>((ref) => "");
final   isHaveCrProvider     = StateProvider<String>((ref) => "no");
final defaultImage = StateProvider<String>((ref) => ""
    "https://media.licdn.com/dms/image/v2/C4E12AQHzBA"
    "iANK2ceQ/article-cover_image-shrink_720_1280/article-cover_image-shrink"
    "_720_1280/0/1627292304016?e=2147483647&v=beta&t=CaGaKBl8DcF2tV6Ygjhe"
    "9uOPJdAc25Gis-KnOGC8G9E");
final selectedCountryCode = StateProvider<String>((ref) => "+970");
final tokenOfUser = StateProvider<String>((ref) => "");
    final typeOfInfluencerProvider = StateProvider<String>((ref) => "");

/// those string value is the errors that show in TextFormField widget
final updateUserNameValidate = StateProvider<String?>((ref) => null);
final oldPasswordValidate = StateProvider<String?>((ref) => null);
final newPasswordValidate = StateProvider<String?>((ref) => null);
final sureNewPasswordValidate = StateProvider<String?>((ref) => null);
final updatePhoneValidate = StateProvider<String?>((ref) => null);
final countriesCodes = StateProvider<List<String>>((ref) => [
  "+970",
  "+972",    ]);
final typeOfUser = StateProvider<List<String>>((ref) => [
  "مالك",
  "مكتب عقاري",
    ]);
final categoriesOfInfluencer = StateProvider<Future<List<Category?>?>>((ref)
=> Future.value([]));

final errorStatusCode = StateProvider<int>((ref) => 0);
final ownerIdNotifier = StateProvider<int>((ref) => 0);

final profileImageFile = StateProvider<XFile?>((ref) => null);

final userData = StateProvider<User?>((ref) => User());

///that the [formLoginEmailKey],[formLoginPasswordKey],[formPhoneKey],
///[formRegPasswordKey],[formUsernameKey] , use the [Validator] class
///and [FormFieldsNotifier] , and every method in hybrid_method folder
/// to make validate for tow screens [LoginUi] and [RegistrationUi]
/// only.
final formLoginEmailKey = GlobalKey<FormState>();
final formLoginPasswordKey = GlobalKey<FormState>();
final formPhoneKey = GlobalKey<FormState>();
final formRegPasswordKey = GlobalKey<FormState>();
final formUsernameKey = GlobalKey<FormState>();

/// the  [updateUsernameFormKey] ,[updatePhoneNumberFormKey],
/// [oldPasswordFormKey],[newPasswordFormKey],[sureNewPasswordFormKey] usage
/// for [UpdateUserDataUi] screen only.
final updateUsernameFormKey = GlobalKey<FormState>();
final updatePhoneNumberFormKey = GlobalKey<FormState>();
final oldPasswordFormKey = GlobalKey<FormState>();
final newPasswordFormKey = GlobalKey<FormState>();
final sureNewPasswordFormKey = GlobalKey<FormState>();

