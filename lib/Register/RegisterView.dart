import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../HomeActivity/HomeWithBottomMenu.dart';
import '../LoginActivity/views/login_view.dart';
import 'Service/RegController.dart';

// Riverpod providers for visibility toggles
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider<bool>((ref) => false);

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RiderLeadViewState();
}

class _RiderLeadViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _mobileController = TextEditingController();
  final _companyController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int? selectedDepoID=0;

  String? selectedType;
  final List<String> kfhOptions = ['KFH', 'DC'];
  bool isChecked = false;

  void _showPopup() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Terms & Conditions"),
            content: const Text(
              "By checking this box, you agree to our terms.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isConfirmPasswordVisible = ref.watch(
      confirmPasswordVisibilityProvider,
    );

    final isLoading = ref.watch(regControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          'Create your profile',
          style: GoogleFonts.figtree(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your basic details",
              style: GoogleFonts.figtree(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Let's set up your profile",
              style: GoogleFonts.figtree(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Full Name*',
                    hint: 'Enter your full name',
                    controller: _nameController,
                    type: TextInputType.name,
                  ),
                  _buildMobileNumberField(
                    label: 'Mobile Number*',
                    hint: 'Enter your mobile number',
                    controller: _mobileController,
                  ),
                  _buildTextField(
                    label: 'Employee ID*',
                    hint: 'Enter your employee ID',
                    controller: _companyController,
                    type: TextInputType.number,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: "Area*",
                          hint: "Enter area",
                          controller: _areaController,
                          type: TextInputType.text,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: "City*",
                          hint: "Enter city",
                          controller: _cityController,
                          type: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  _buildDropdown("KFH/DC*", selectedType, kfhOptions, (value) {
                    setState(() => selectedType = value);
                  }),
                  _buildPasswordField(
                    controller: _passwordController,
                    label: "Password*",
                    hint: "Enter your password",
                    isVisible: isPasswordVisible,
                    toggleVisibility:
                        () =>
                            ref
                                .read(passwordVisibilityProvider.notifier)
                                .state = !isPasswordVisible,
                  ),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: "Confirm Password*",
                    hint: "Re-enter your password",
                    isVisible: isConfirmPasswordVisible,
                    toggleVisibility:
                        () =>
                            ref
                                .read(
                                  confirmPasswordVisibilityProvider.notifier,
                                )
                                .state = !isConfirmPasswordVisible,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() => isChecked = value ?? false);
                          if (value == true) _showPopup();
                        },
                        activeColor: Colors.green,
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'By checking this box, you agree to our ',
                            style: GoogleFonts.figtree(fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: GoogleFonts.figtree(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final nameValue = _nameController.text.trim();
                              final mobileNo = _mobileController.text.trim();
                              final companyId = _companyController.text.trim();

                              final area = _areaController.text.trim();
                              final city = _cityController.text.trim();
                              final password = _passwordController.text.trim();
                              final confirmPassword = _confirmPasswordController.text.trim();

                              if(selectedType=="DC"){
                                selectedDepoID=2;
                              }

                              if (!isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Kindly select Terms and Conditions",
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (password != confirmPassword) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Password mismatch"),
                                  ),
                                );
                                return;
                              }

                              try {
                                final result = await ref.read(regControllerProvider.notifier).register(
                                    nameValue, mobileNo,companyId ,city,area,selectedDepoID!,password);

                                if (result.status == '200') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Register successful!'), backgroundColor: Colors.green),
                                  );
                                  if (context.mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => const LoginView()),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result.msg), backgroundColor: Colors.red),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
                                );
                              }



                              // TODO: Call API or navigate to next screen
                            }
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.figtree(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.figtree(fontSize: 13),
                      ),
                      Text(
                        "Login",
                        style: GoogleFonts.figtree(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildMobileNumberField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Mobile number is required';
          } else if (value.trim().length != 10) {
            return 'Mobile number must be 10 digits';
          }
          return null;
        },
        style: GoogleFonts.figtree(fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          counterText: '',
          hintStyle: GoogleFonts.figtree(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
      ),
    );
  }
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required TextInputType type,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
        style: GoogleFonts.figtree(fontSize: 12),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: GoogleFonts.figtree(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String? selectedValue,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Required' : null,
        items:
            items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, style: GoogleFonts.figtree(fontSize: 14)),
                  ),
                )
                .toList(),
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Select $label',
          hintStyle: GoogleFonts.figtree(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator:
            (value) => value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: toggleVisibility,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
