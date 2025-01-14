import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iyl/screens/home/home_screen.dart';
import '../../shared/navigateWithFade.dart';

class AiResponse extends StatefulWidget {
  final String response;

  const AiResponse({
    super.key,
    required this.response,
  });

  @override
  AiResponseState createState() => AiResponseState();
}

class AiResponseState extends State<AiResponse> {
  String displayedText = '';
  int currentIndex = 0;
  bool isTypingComplete = false;
  bool userInteracted = false; // Flag to detect user interaction
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onUserScroll);
    _startTypingEffect();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onUserScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onUserScroll() {
    // Detect user dragging the scroll view
    if (_scrollController.position.userScrollDirection !=
        ScrollDirection.idle) {
      setState(() {
        userInteracted = true; // Stop automatic scrolling
      });
    }
  }

  void _startTypingEffect() {
    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (currentIndex < widget.response.length) {
        setState(() {
          displayedText += widget.response[currentIndex];
          currentIndex++;
        });

        if (!userInteracted) {
          // Automatically scroll only if user hasn't interacted
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 50),
            curve: Curves.easeOut,
          );
        }
      } else {
        timer.cancel();
        setState(() {
          isTypingComplete = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wellness Overview"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: isTypingComplete
                ? () {
                    navigateWithFade(context, const HomeScreen());
                  }
                : null, // Disable until typing is complete
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Attach ScrollController
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayedText,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.6,
              ),
            ),
            if (isTypingComplete)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Continue to home with the icon above to begin AI coaching.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900], // Background color for better contrast
    );
  }
}
