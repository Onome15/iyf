import 'package:flutter/material.dart';
import 'package:iyl/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/methods.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenLandingPage = prefs.getBool('hasSeenLandingPage') ?? false;

      if (!hasSeenLandingPage) {
        replaceNavigateWithFade(context, const LandingPage());
      } else {
        //LandingPage() will be replaced later on with an Auth() or Wrapper()
        //User go directly to the Auth page if he has seen landing before.
        replaceNavigateWithFade(context, const Wrapper(showSignIn: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/iyl_logo.png',
              width: 350, // Adjust width and height as needed.
              height: 250,
              fit: BoxFit.contain, // Ensures the image maintains aspect ratio.
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                "More Than Just Health \n Over a Million Trust Us For Wellness",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
