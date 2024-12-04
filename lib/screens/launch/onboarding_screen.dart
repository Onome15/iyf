import 'package:flutter/material.dart';
import '../authenticate/register.dart';

class OnboardingScreen extends StatelessWidget {
  final int pageIndex;

  OnboardingScreen(this.pageIndex, {super.key});

  final List<String> headerText = [
    "Artificial Intelligence",
    "AI Health Quiz",
    "Your Dedicated AI Coach",
    "Sign Up in 3 Steps",
  ];

  final List<String> subText = [
    "    Discover personalized health, get a dedicated AI wellness partner as your coach, Build your brand’s voice with AI-driven content creation tools.",
    "Take our quick quiz to uncover actionable insights tailored to your health, finances, and relationships. It’s your first step toward a healthier, happier you!",
    "Stay on track with personalized guidance, habit-building tools, and progress tracking—all designed to fit your unique lifestyle and goals.",
    "1. Login or Sign Up: Share your goals. \n 2. Engage:Take Thr Quiz. \n 3. Thrive: Monitor your progress and celebrate.",
  ];

  final List<String> imageUrl = [
    "assets/onboarding/onboarding1.jpg",
    "assets/onboarding/onboarding2.jpg",
    "assets/onboarding/onboarding3.jpg",
    "assets/onboarding/onboarding4.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () =>
                    _navigateWithFade(context, const RegisterScreen()),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(2),
                ),
                child:
                    const Text("Skip", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 350, // Larger image size
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 18), // Thicker border
                      borderRadius:
                          BorderRadius.circular(175), // Ensures circular shape
                      image: DecorationImage(
                        image: AssetImage(imageUrl[pageIndex]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    headerText[pageIndex],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    subText[pageIndex],
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildDots(context, pageIndex),
                  const SizedBox(height: 45),
                  _buildNavigationButtons(context, pageIndex),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDots(BuildContext context, int pageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: index == pageIndex ? Colors.white : Colors.white54,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  Widget _buildNavigationButtons(BuildContext context, int pageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: pageIndex == 0
              ? null
              : () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingScreen(pageIndex - 1)),
                  ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          ),
          child: const Text("Back"),
        ),
        OutlinedButton(
          onPressed: pageIndex == 3
              ? () => _navigateWithFade(context, const RegisterScreen())
              : () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OnboardingScreen(pageIndex + 1)),
                  ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
          ),
          child: const Text("Next", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  void _navigateWithFade(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }
}
