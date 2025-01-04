import 'package:flutter/material.dart';

class FinanceProgress extends StatefulWidget {
  const FinanceProgress({super.key});

  @override
  State<FinanceProgress> createState() => _FinanceProgressState();
}

class _FinanceProgressState extends State<FinanceProgress> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello world"),
      ),
    );
  }
}
