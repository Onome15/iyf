import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyl/screens/home/navbar.dart';
import 'package:iyl/screens/launch/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.grey[900],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        home: const BottomNavBar());
  }
}
