import 'package:flutter/material.dart';
import 'package:iyl/screens/launch/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _navigateWithFade(
      BuildContext context, Widget destination) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenLandingPage', true);

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          'assets/landing_page/landing_page.png',
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/iyl_logo.png',
                        width: 350,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "More Than Just Health \n Over a Million Trust Us For Wellness",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              const Text("Ready for the life transforming experience?",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      _navigateWithFade(context, OnboardingScreen(0)),
                  style: ElevatedButton.styleFrom(
                    elevation: 12, // Increase elevation for more visible shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    shadowColor: Colors.white.withOpacity(0.7), // Softer shadow
                    backgroundColor: Colors.black, // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          "Let's Go",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // Space between text and icon
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
