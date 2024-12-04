import 'package:flutter/material.dart';
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
      home: const SplashScreen(),
    );
  }
}
