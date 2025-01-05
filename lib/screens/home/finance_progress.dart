import 'package:flutter/material.dart';

class FinanceProgress extends StatefulWidget {
  const FinanceProgress({super.key});

  @override
  State<FinanceProgress> createState() => _FinanceProgressState();
}

class _FinanceProgressState extends State<FinanceProgress> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action for the floating button
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Blue container (bottom)
                Container(
                  width: screenWidth,
                  height: 225,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Personalized Finance Progress",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Here is a tailored action plan and strategies for your Finance.",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),

                // Grey container (top)
                Positioned(
                  bottom: -60,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        plans('Pending'),
                        plans('Completed'),
                        plans('Total'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Due Today",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Text(
                        "Sort By",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  actionPlan(screenWidth, Colors.green),
                  const SizedBox(
                    height: 20,
                  ),
                  actionPlan(screenWidth, Colors.red),
                  const SizedBox(
                    height: 20,
                  ),
                  actionPlan(screenWidth, Colors.blueAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container actionPlan(double screenWidth, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black87,
      width: screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Colored bar
          Container(
            width: 5,
            height: 80,
            color: color, // Use the passed color
          ),
          const SizedBox(width: 8),
          // Column content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Action Outlined Plans",
                    style: TextStyle(color: color), // Use the passed color
                  ),
                  const Text(
                    "Investment Strategy Action Plan",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Begin researching investment options such as stocks, "
                    "bonds, or mutual funds suitable for your risk tolerance.",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Checkmark icon
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.check,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Column plans(String plan) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "11",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2E6FF3),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Text(
            "$plan Plan",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
