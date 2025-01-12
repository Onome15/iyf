import 'package:flutter/material.dart';

class DebtReduction extends StatelessWidget {
  const DebtReduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Personalized Finance Strategy",
                  style: TextStyle(fontSize: 13.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: Text(
                  "Debt Reduction Strategy",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15.0), // 15% of the screen height
              Row(
                children: [
                  const Text(
                    "Debt Reduction \n Action Plan",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(13.0), // Add padding
                    decoration: const BoxDecoration(
                      color: Color(0xff2e6ff34d), // Use the provided hex color
                      shape: BoxShape.circle, // Make it circular
                    ),
                    child: const Icon(Icons.volume_up),
                  ),
                ],
              ),
              const SizedBox(height: 10.0), // 10% of the screen height
              const Text(
                "Step-by-Step Approach to Paying Down Existing Debts",
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 10.0), // 10% of the screen height
              const Text(
                "Successfully managing and reducing your debt requires a clear and structured approach. Here is an effective strategy to help you start paying off your debts, focusing first on those with the highest interest rates:\n\n"
                "Assess Your Total Debt: List all your debts, including credit card balances, loans, and any other financial obligations, noting down their respective interest rates.\n\n"
                "Prioritize High-Interest Debts: Organize your debts in order from highest to lowest interest rate. This approach, often called the avalanche method, saves you the most money on interest over time.\n\n"
                "Create a Budget: Develop a budget that allocates funds specifically for debt repayment. Prioritize your spending to ensure you have enough to cover the minimum payments on all debts, with extra payments directed at the highest interest debts.\n\n"
                "Increase Payment Amounts: Whenever possible, increase the amount you put towards the debt with the highest interest rate. Even small increases can significantly cut down your overall interest costs and repayment period.\n\n"
                "Monitor and Adjust: Regularly review your budget and progress. Adjust your plan as needed to accommodate changes in your financial situation or to increase efficiency in debt repayment.\n\n"
                "Following this structured approach will help you manage and reduce your debts more effectively, leading to financial freedom sooner than you might think.",
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () => print('Export Button Pressed'),
                    icon: const Icon(
                      Icons.ios_share,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Export Plan',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 80,
                      ),
                      backgroundColor: const Color(0xFF2E6FF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
