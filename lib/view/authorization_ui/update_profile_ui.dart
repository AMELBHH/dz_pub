import 'package:dz_pub/constants/strings.dart';
import 'package:dz_pub/controllers/providers/auth_provider.dart';
import 'package:dz_pub/controllers/providers/color_provider.dart';
import 'package:dz_pub/session/new_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UpdateProfileUi extends ConsumerStatefulWidget {
  const UpdateProfileUi({super.key});

  @override
  ConsumerState<UpdateProfileUi> createState() => _UpdateProfileUiState();
}

class _UpdateProfileUiState extends ConsumerState<UpdateProfileUi> {
  final _formKey = GlobalKey<FormState>();

  // Common controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _identityNumberController;

  // Influencer controllers
  late TextEditingController _bioController;
  late TextEditingController _shakeNumberController;
  String? _gender;
  String? _dob;

  // Client controllers
  late TextEditingController _nicknameController;
  late TextEditingController _regOwnerNameController;
  late TextEditingController _institutionNameController;
  late TextEditingController _branchAddressController;
  late TextEditingController _institutionAddressController;
  late TextEditingController _rcNumberController;
  late TextEditingController _nisNumberController;
  late TextEditingController _nifNumberController;
  late TextEditingController _ibanController;

  @override
  void initState() {
    super.initState();
    // Common fields
    _nameController = TextEditingController(
      text: NewSession.get(PrefKeys.name, ''),
    );
    _emailController = TextEditingController(
      text: NewSession.get(PrefKeys.email, ''),
    );
    _phoneController = TextEditingController(
      text: NewSession.get(PrefKeys.phone, ''),
    );
    _identityNumberController = TextEditingController(
      text: NewSession.get(PrefKeys.identityNumber, ''),
    );

    // Influencer fields
    _bioController = TextEditingController(
      text: NewSession.get(PrefKeys.inflBio, ''),
    );
    _shakeNumberController = TextEditingController(
      text: NewSession.get(PrefKeys.inflShake, ''),
    );
    final savedGender = NewSession.get(PrefKeys.inflGender, '');
    _gender = savedGender.isEmpty ? null : savedGender;

    final savedDob = NewSession.get(PrefKeys.inflDob, '');
    _dob = savedDob.isEmpty ? null : savedDob;

    // Client fields
    _nicknameController = TextEditingController(
      text: NewSession.get(PrefKeys.nickName, ''),
    );
    _regOwnerNameController = TextEditingController(
      text: NewSession.get(PrefKeys.regOwnerName, ''),
    );
    _institutionNameController = TextEditingController(
      text: NewSession.get(PrefKeys.institutionName, ''),
    );
    _branchAddressController = TextEditingController(
      text: NewSession.get(PrefKeys.branchAddress, ''),
    );
    _institutionAddressController = TextEditingController(
      text: NewSession.get(PrefKeys.institutionAddress, ''),
    );
    _rcNumberController = TextEditingController(
      text: NewSession.get(PrefKeys.rcNumber, ''),
    );
    _nisNumberController = TextEditingController(
      text: NewSession.get(PrefKeys.nisNumber, ''),
    );
    _nifNumberController = TextEditingController(
      text: NewSession.get(PrefKeys.nifNumber, ''),
    );
    _ibanController = TextEditingController(
      text: NewSession.get(PrefKeys.iban, ''),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _identityNumberController.dispose();
    _bioController.dispose();
    _shakeNumberController.dispose();
    _nicknameController.dispose();
    _regOwnerNameController.dispose();
    _institutionNameController.dispose();
    _branchAddressController.dispose();
    _institutionAddressController.dispose();
    _rcNumberController.dispose();
    _nisNumberController.dispose();
    _nifNumberController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'Cairo')),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob != null
          ? DateTime.tryParse(_dob!) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dob =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(updateProfileNotifier.notifier);

      final success = await notifier.updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        identityNumber: _identityNumberController.text.trim(),

        // Influencer
        bio: _bioController.text.trim(),
        gender: _gender,
        dateOfBirth: _dob,
        shakeNumber: _shakeNumberController.text.trim(),

        // Client
        nickname: _nicknameController.text.trim(),
        regOwnerName: _regOwnerNameController.text.trim(),
        institutionName: _institutionNameController.text.trim(),
        branchAddress: _branchAddressController.text.trim(),
        institutionAddress: _institutionAddressController.text.trim(),
        rcNumber: _rcNumberController.text.trim(),
        nisNumber: _nisNumberController.text.trim(),
        nifNumber: _nifNumberController.text.trim(),
        iban: _ibanController.text.trim(),

        context: context,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('تم تحديث البيانات بنجاح');
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) context.pop();
        });
      } else {
        final errorMsg =
            ref.read(updateProfileNotifier).errorMessage ??
            'حدث خطأ أثناء تحديث البيانات';
        _showSnackBar(errorMsg, isError: true);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    final color = ref.read(themeModeNotifier.notifier).textTheme(ref: ref);
    final primary = ref.read(themeModeNotifier.notifier).primaryTheme(ref: ref);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: color, fontFamily: 'Cairo'),
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: color, fontFamily: 'Cairo'),
          prefixIcon: Icon(icon, color: color),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primary, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(updateProfileNotifier).isLoading;
    final userTypeId = NewSession.get(PrefKeys.userTypeId, 1);
    final userType = NewSession.get(PrefKeys.userType, '');
    final isHaveCr = NewSession.get(PrefKeys.isHaveCr, 'no') == 'yes';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تعديل الملف الشخصي',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                // --- Common Section ---
                _buildSectionTitle('البيانات الأساسية'),
                _buildTextField(
                  controller: _nameController,
                  label: 'الاسم الكامل',
                  icon: Icons.person,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'الرجاء إدخال الاسم' : null,
                ),
                _buildTextField(
                  controller: _emailController,
                  label: 'البريد الإلكتروني',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => v != null && !v.contains('@')
                      ? 'بريد إلكتروني غير صالح'
                      : null,
                ),
                _buildTextField(
                  controller: _phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                  controller: _identityNumberController,
                  label: 'رقم بطاقة التعريف',
                  icon: Icons.badge,
                  keyboardType: TextInputType.number,
                ),

                // --- Influencer Section ---
                if (userTypeId == 2 || userType != 'client') ...[
                  _buildSectionTitle('بيانات المؤثر'),
                  _buildTextField(
                    controller: _bioController,
                    label: 'نبذة شخصية',
                    icon: Icons.description,
                  ),
                  _buildTextField(
                    controller: _shakeNumberController,
                    label: 'رقم الشيك',
                    icon: Icons.account_balance_wallet,
                  ),

                  // Gender Dropdown
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: InputDecoration(
                        labelText: 'الجنس',
                        labelStyle: TextStyle(
                          color: ref
                              .read(themeModeNotifier.notifier)
                              .textTheme(ref: ref),
                          fontFamily: 'Cairo',
                        ),
                        prefixIcon: Icon(
                          Icons.people,
                          color: ref
                              .read(themeModeNotifier.notifier)
                              .textTheme(ref: ref),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                                DropdownMenuEntry(value: 'male', label: 'ذكر'),
                                DropdownMenuEntry(
                                  value: 'female',
                                  label: 'أنثى',
                                ),
                              ]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.value,
                                  child: Text(e.label),
                                ),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _gender = v),
                    ),
                  ),

                  // DOB Picker
                  _buildTextField(
                    controller: TextEditingController(text: _dob ?? ''),
                    label: 'تاريخ الميلاد',
                    icon: Icons.calendar_today,
                    readOnly: true,
                    onTap: _selectDate,
                  ),
                ],

                // --- Client Section ---
                if (userTypeId == 1 || userType == 'client') ...[
                  _buildSectionTitle('بيانات العميل'),
                  if (!isHaveCr)
                    _buildTextField(
                      controller: _nicknameController,
                      label: 'اللقب',
                      icon: Icons.alternate_email,
                    ),

                  if (isHaveCr) ...[
                    _buildTextField(
                      controller: _regOwnerNameController,
                      label: 'اسم المالك',
                      icon: Icons.person_outline,
                    ),
                    _buildTextField(
                      controller: _institutionNameController,
                      label: 'اسم المؤسسة',
                      icon: Icons.business,
                    ),
                    _buildTextField(
                      controller: _institutionAddressController,
                      label: 'عنوان المؤسسة',
                      icon: Icons.location_city,
                    ),
                    _buildTextField(
                      controller: _branchAddressController,
                      label: 'عنوان الفرع (اختياري)',
                      icon: Icons.location_on,
                    ),
                    _buildTextField(
                      controller: _rcNumberController,
                      label: 'رقم السجل التجاري',
                      icon: Icons.numbers,
                    ),
                    _buildTextField(
                      controller: _nisNumberController,
                      label: 'الرقم الإحصائي (NIS)',
                      icon: Icons.analytics,
                    ),
                    _buildTextField(
                      controller: _nifNumberController,
                      label: 'الرقم الجبائي (NIF)',
                      icon: Icons.receipt_long,
                    ),
                    _buildTextField(
                      controller: _ibanController,
                      label: 'رقم الحساب البنكي (IBAN)',
                      icon: Icons.account_balance,
                    ),
                  ],
                ],

                const SizedBox(height: 20),

                // Update Button
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ref
                          .read(themeModeNotifier.notifier)
                          .primaryTheme(ref: ref),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'حفظ التعديلات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final color = ref.read(themeModeNotifier.notifier).textTheme(ref: ref);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Cairo',
            ),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
