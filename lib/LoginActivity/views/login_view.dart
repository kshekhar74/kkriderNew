import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HomeActivity/HomeWithBottomMenu.dart';
import '../services/login_controller.dart';

// Password visibility state provider
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginControllerProvider);
    final isVisible = ref.watch(passwordVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'philosopher', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(child: Image.asset('assets/images/app_logo.png', height: 80, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text('Login to your account', style: GoogleFonts.figtree(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('Create an account', style: GoogleFonts.figtree(fontSize: 12, fontWeight: FontWeight.w600)),
            const SizedBox(height: 24),

            // User ID field
            _buildMobileNumberField(
              label: 'Mobile Number*',
              hint: 'Enter your mobile number',
              controller: _mobileController,
            ),

            const SizedBox(height: 16),

            // Password field
            TextField(
              controller: _passwordController,
              obscureText: !isVisible,
              decoration: InputDecoration(

                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                  onPressed: () {
                    ref.read(passwordVisibilityProvider.notifier).state = !isVisible;
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 30),

            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final userId = _mobileController.text.trim();
                  final password = _passwordController.text.trim();
                  if(userId.length !=10){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mobile number must be 10 digits')),
                    );
                    return;
                  }

                  if (userId.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter both User ID and Password')),
                    );
                    return;
                  }
                  final userId1 = int.tryParse(_mobileController.text.trim());

                  try {
                    final result = await ref.read(loginControllerProvider.notifier).login(userId1!, password,"1","1");
                    if (result.status == '200') {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successful!'), backgroundColor: Colors.green),
                      );
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      await prefs.setInt('userId', result.data[0].id);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeWithBottomMenu()),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result.message), backgroundColor: Colors.red),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: const Text('Verify & Continue', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
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

}
