import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../HomeActivity/HomeTab/HomeScreen.dart';
import '../../HomeActivity/HomeWithBottomMenu.dart';
import '../../LoginActivity/providers/auth_provider.dart';
import '../../OtpVerification/OTPVerificationScreen.dart';

// StateProvider to manage password visibility
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _vehicleNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Watch the login loading state from Riverpod
    final isLoading = ref.watch(loginControllerProvider);
    final isVisible = ref.watch(passwordVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'philosopher',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),

      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(

              mainAxisSize: MainAxisSize.min,
              children: [

                Center(
                  child: Image.asset(
                    'assets/images/app_logo.png', // Replace with your asset
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                 Text(
                  'Login to your account ',
                  style: GoogleFonts.figtree(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Create an account',
                  style: GoogleFonts.figtree(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // 👤 User ID Field
                TextField(
                  controller: _userIdController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'User ID',
                    hintText: 'Enter your user ID',
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 🔐 Password Field
                TextField(
                  controller: _vehicleNoController,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        ref
                            .read(passwordVisibilityProvider.notifier)
                            .state = !isVisible;
                      },
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

                const SizedBox(height: 20),

                // 🔄 Login Button or Loader
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(

                        onPressed: () async {
                          final userId = _userIdController.text.trim();
                          final password = _vehicleNoController.text.trim();

                          if (userId.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter both User ID and Password'),
                              ),
                            );
                            return;
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeWithBottomMenu()),
                          );

                          /* // Simulate the login process by calling the login API
                      final result = await ref
                          .read(loginControllerProvider.notifier)
                          .login(userId, password); // Call your actual API here

                      if (result.status.toLowerCase() == '200') {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userID', userId);
                        await prefs.setString('driverID', result.truckDetail!.driverID.toString());
                        await prefs.setString('vehicleID', result.truckDetail!.vehicleID.toString());
                        await prefs.setString('phoneNumber', result.truckDetail!.phoneNumber);
                        await prefs.setString('email', result.truckDetail!.email);
                        await prefs.setString('compWhtsApp', result.truckDetail!.compWhtsApp);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result.msg),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }*/
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Verify & Continue',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
