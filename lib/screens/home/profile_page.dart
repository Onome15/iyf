import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class ProfilePage extends StatefulWidget {
  final String? response;

  const ProfilePage({super.key, required this.response});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fullName = "";
  String role = '';

  @override
  void initState() {
    super.initState();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('Fullname') ?? "Not set";
      role = prefs.getString('role') ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.1,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),

                    // Camera icon positioned at the edge
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Profile text
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(
                  color: Colors.blue,
                  thickness: 3.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bolt, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      "Performance Indicators",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                buildProgressRow(
                  progress: 0.99,
                  topText: "Health",
                  progressNumber: "99%",
                  color: Colors.green,
                ),
                const SizedBox(height: 25),
                buildProgressRow(
                  progress: 0.45,
                  topText: "Finance",
                  progressNumber: "45%",
                  color: Colors.red,
                ),
                const SizedBox(height: 25),
                buildProgressRow(
                  progress: 0.10,
                  topText: "Relationship",
                  progressNumber: "10%",
                  color: Colors.blue,
                ),
                const SizedBox(height: 25),
                const Divider(
                  color: Colors.blue, // Set the line color
                  thickness: 3.0, // Set the line thickness
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.psychology, color: Colors.blue),
                    SizedBox(width: 5),
                    Text(
                      "Personalized AI Knowledge Base",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Text(
                  "Your performance is based on the quiz you took. You can re-take the quiz to improve and update your performance.",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  (widget.response == null || widget.response!.isEmpty)
                      ? "Re-take Quiz to show your performance"
                      : widget.response!,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Re-Take Quiz',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgressRow({
    required double progress,
    required String topText,
    required String progressNumber,
    required Color color,
  }) {
    return Row(
      children: [
        // Circular progress with thunder icon
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: progress,
                color: color,
                strokeWidth: 4,
              ),
            ),
            Icon(
              Icons.bolt,
              color: color,
              size: 24,
            ),
          ],
        ),

        const SizedBox(width: 16),

        // Column with two text widgets
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$topText Progress",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "$progressNumber Performance",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
