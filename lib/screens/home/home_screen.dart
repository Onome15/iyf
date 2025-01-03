import 'package:flutter/material.dart';
import 'package:iyl/shared/navigateWithFade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/auth_state_provider.dart';

import '../wrapper.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String fullName = " "; // Default value

  @override
  void initState() {
    super.initState();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('Fullname') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authStateProvider.notifier);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          left: screenWidth * 0.025,
          right: screenWidth * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.075,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: screenWidth * 0.1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: screenWidth * 0.025),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Good Evening,"),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.mail),
                SizedBox(width: screenWidth * 0.025),
                const Icon(Icons.notifications_active),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.025,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF2E6FF3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Summary ⚡",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "A quick summary of your progress since your last login",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildProgressRow("Health"),
                      buildProgressRow("Finance"),
                      buildProgressRow("Relationship"),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text(
              'What would you like to \n innovate Today?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildGridItem(
                      icon: Icons.health_and_safety,
                      text: "AI \n Coaches",
                      onClick: () async {
                        await authNotifier.logout();
                        navigateWithFade(
                            context, const Wrapper(showSignIn: true));
                      },
                    ),
                    buildGridItem(
                      icon: Icons.account_balance,
                      text: "Habit \n Building",
                      onClick: () => print("Habit Building clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.favorite,
                      text: "Bot \n Training",
                      onClick: () => print("Bot Training clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.lightbulb,
                      text: "AI \n Quiz",
                      onClick: () => print("AI Quiz clicked"),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildGridItem(
                      icon: Icons.book,
                      text: "Revenue \n / Affiliate",
                      onClick: () => print("Revenue / Affiliate clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.settings,
                      text: "Brand \n Voice",
                      onClick: () => print("Brand Voice clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.person,
                      text: "Cross \n Synergy",
                      onClick: () => print("Cross Synergy clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.help,
                      text: "Emotional \n Wellness",
                      onClick: () => print("Emotional Wellness clicked"),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildGridItem(
                      icon: Icons.travel_explore,
                      text: "Travel \n Plans",
                      onClick: () => print("Travel Plans clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.shopping_bag,
                      text: "Shopping \n Ideas",
                      onClick: () => print("Shopping Ideas clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.work,
                      text: "Work \n Solutions",
                      onClick: () => print("Work Solutions clicked"),
                    ),
                    buildGridItem(
                      icon: Icons.group,
                      text: "Teamwork \n Tasks",
                      onClick: () => print("Teamwork Tasks clicked"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressRow(String progressType) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.heart_broken,
            size: 18,
          ),
        ),
        const SizedBox(width: 3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '0% Performance',
              style: TextStyle(fontSize: 10),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "$progressType Progress",
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGridItem({
    required IconData icon,
    required String text,
    required VoidCallback onClick,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        height: screenHeight * 0.11,
        width: screenWidth * 0.215,
        decoration: BoxDecoration(
          color: const Color(0xFF2B3037),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: screenWidth * 0.08, color: Colors.white),
            SizedBox(height: screenHeight * 0.01),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
