import 'package:flutter/material.dart';
import 'package:iyl/screens/wrapper.dart';
import '../../shared/methods.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.05;

    final double imageSize = screenWidth * 0.8;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () => pushNavigateWithFade(
                    context, const Wrapper(showSignIn: false)),
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
            Container(
              height: imageSize,
              width: imageSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 18),
                borderRadius: BorderRadius.circular(175),
                image: DecorationImage(
                  image: AssetImage(imageUrl[pageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              headerText[pageIndex],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subText[pageIndex],
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            _buildDots(context, pageIndex),
            _buildNavigationButtons(context, pageIndex),
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
              ? () => pushNavigateWithFade(
                  context, const Wrapper(showSignIn: false))
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
}
