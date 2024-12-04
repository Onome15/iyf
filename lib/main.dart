import 'package:flutter/material.dart';
import 'package:iyl/screens/authenticate/login.dart';
import 'package:iyl/screens/authenticate/otp_verification.dart';
import 'package:iyl/screens/authenticate/register.dart';
import 'screens/launch/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Sets a custom dark background.
        primaryColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Dark app bar color.
        ),
      ),
      home: const RegisterScreen(),
    );
  }
}
