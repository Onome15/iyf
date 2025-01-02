import 'package:flutter/material.dart';
import 'package:iyl/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'quiz/quiz_screen.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  bool? onboarding; // Null until loaded

  @override
  void initState() {
    super.initState();
    _fetchOnboardingStatus();
  }

  Future<void> _fetchOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      onboarding = prefs.getBool('onboarding') ?? false; // Default to false
    });
  }

  @override
  Widget build(BuildContext context) {
    if (onboarding == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return onboarding! ? const HomeScreen() : const QuizScreen();
  }
}
