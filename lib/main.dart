import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'SplashScreen.dart';


void main()   {
  runApp(
    ProviderScope(
      child: MyApp(), // Your root widget
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const SplashScreen(),
    ));
  }
}
void setupFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission (for iOS)
  messaging.requestPermission();

  // Get device token
  messaging.getToken().then((token) {
    print('FCM Token: $token');
    // Send token to backend if needed
  });

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message: ${message.notification?.title}');
  });

  // Background & terminated state
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Tapped on notification: ${message.notification?.title}');
  });
}

