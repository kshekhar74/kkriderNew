import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _RiderLeadViewState();
}

class _RiderLeadViewState extends State<Counter> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _empIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();

  String? selectedType;

  final List<String> kfhOptions = ['KFH', 'DC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          "Create your profile",
          style: GoogleFonts.figtree(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your basic details",
              style: GoogleFonts.figtree(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Let's set up your profile",
              style: GoogleFonts.figtree(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 14),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField("Full Name*", _nameController, TextInputType.name),
                  _buildTextField("Mobile Number*", _mobileController, TextInputType.phone),
                  _buildTextField("Employee ID*", _empIdController, TextInputType.text),
                  _buildDropdown("KFH/DC*", selectedType, kfhOptions, (value) {
                    setState(() {
                      selectedType = value;
                    });
                  }),
                  _buildTextField("Password*", _passwordController, TextInputType.visiblePassword, isObscure: true),
                  _buildTextField("Confirm Password*", _confirmPasswordController, TextInputType.visiblePassword, isObscure: true),

                  // Area + City Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField("Area*", _areaController, TextInputType.text),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField("City*", _cityController, TextInputType.text),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF60C98B),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Submit data
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Submitting your profile...")),
                          );
                        }
                      },
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.figtree(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, TextInputType type, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: type,
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        style: GoogleFonts.figtree(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.figtree(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        onChanged: onChanged,
        validator: (value) => value == null ? 'Required' : null,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: GoogleFonts.figtree(fontSize: 14)),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: GoogleFonts.figtree(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
      ),
    );
  }
}
