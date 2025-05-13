import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kk_new_project/core/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeActivity/HomeTab/HomeScreen.dart';
import 'HomeActivity/HomeWithBottomMenu.dart';
import 'LoginActivity/views/login_view.dart';
import 'StartScreen/RiderLeadStartScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await _getCurrentLocation(); // Fetch location before the splash screen delay
    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    debugPrint("Splash initState called");
    debugPrint("isLoggedIn: $isLoggedIn");

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  HomeWithBottomMenu()), // Ensure HomeScreen is correctly defined
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RiderLeadStartScreen()), // Ensure LoginView is correctly defined
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Handle the case when location services are not enabled
      return;
    }

    // Check permission status
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always &&
          permission != LocationPermission.whileInUse) {
        // Permission denied, handle this scenario
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    Constants.latValue = position.latitude;
    Constants.longValue = position.longitude;

    debugPrint("Location fetched: Lat: ${Constants.latValue}, Long: ${Constants.longValue}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png', height: 200, width: 200),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
