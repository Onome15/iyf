import 'package:flutter/material.dart';
import 'package:iyl/screens/home/home_screen.dart';
import '../../shared/navigateWithFade.dart';
import '../home/home_page.dart';
import 'quiz_questions.dart'; // Import the questions

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final List<Map<String, String>> _chatHistory = []; // Store chat messages
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  Future<void> _submitAnswers() async {
    print("Submitting answers: $_chatHistory");
    await Future.delayed(const Duration(seconds: 1));
    print("Answers submitted successfully!");
  }

  void _selectOption(String answer) {
    setState(() {
      _chatHistory.add({
        'question': quizQuestions[_chatHistory.length]['question'],
        'answer': answer,
      });

      // Automatically scroll to the bottom after a new answer
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });

      if (_chatHistory.length >= quizQuestions.length) {
        _submitAnswers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose ScrollController to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Based Assessment'),
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach ScrollController
              padding: const EdgeInsets.all(16),
              itemCount: _chatHistory.length + 1,
              itemBuilder: (context, index) {
                if (index < _chatHistory.length) {
                  final chat = _chatHistory[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        questionContainer(chat['question']!),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: answerContainer(chat['answer']!),
                        ),
                      ],
                    ),
                  );
                } else if (_chatHistory.length < quizQuestions.length) {
                  return questionContainer(
                    quizQuestions[_chatHistory.length]['question'],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Options section
          if (_chatHistory.length < quizQuestions.length)
            Container(
              width: double.infinity,
              height: screenHeight,
              color: Colors.grey[900],
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: quizQuestions[_chatHistory.length]['options']
                    .map<Widget>(
                      (option) => OutlinedButton(
                        onPressed: () => _selectOption(option),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          option,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (_chatHistory.length >= quizQuestions.length)
            Container(
              width: double.infinity,
              height: screenHeight,
              color: Colors.grey[900],
              // padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Quiz Taken Successfully!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Thanks For Taking The Assessment, Please Check your email or web for quiz summary',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 22),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        navigateWithFade(context, const HomeScreen());
                      },
                      child: const Text(
                        "Continue to Home",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget questionContainer(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 1,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget answerContainer(String text) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(25),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
