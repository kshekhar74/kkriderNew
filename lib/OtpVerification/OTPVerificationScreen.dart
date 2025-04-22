import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OTPVerificationScreen extends StatefulWidget {
  final String vehicleNo;
  final int otp; // OTP received from Login API

  const OTPVerificationScreen({
    super.key,
    required this.vehicleNo,
    required this.otp,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}
class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String _enteredOtp = '';
  bool _isVerifying = false;
  String _statusMessage = '';
  bool _isSuccess = false;


  Future<void> _saveLoginStatusAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('vehicleNo', widget.vehicleNo); // optional extra

   /* Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
    );*/
  }



  void _verifyOtp() {
    FocusScope.of(context).unfocus();

    setState(() {
      _isVerifying = true;
      _statusMessage = '';
    });

    Future.delayed(const Duration(seconds:1), () {
      setState(() {
        _isVerifying = false;
        if (_enteredOtp == widget.otp.toString()) {
          _isSuccess = true;
          _statusMessage = '✅ OTP Verified Successfully!';
        } else {
          _isSuccess = false;
          _statusMessage = '❌ Invalid OTP. Please try again.';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification',    style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'philosopher',
          color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the OTP sent to your mobile no',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'philosopher'),
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.green,
                focusedBorderColor: Colors.green.shade700,
                showFieldAsBox: true,
                onSubmit: (String verificationCode) {
                  _enteredOtp = verificationCode;
                },
              ),
              const SizedBox(height: 20),
              if (_isVerifying) const CircularProgressIndicator(),
              if (_statusMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    _statusMessage,
                    style: TextStyle(
                      color: _isSuccess ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isVerifying ? null : _saveLoginStatusAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isSuccess ? 'Continue' : 'Verify OTP',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
