import 'package:flutter/material.dart';
import 'package:iyl/screens/quiz/ai_response.dart';
import 'package:iyl/services/ai_service.dart';
import '../../shared/methods.dart';
import 'quiz_questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final List<Map<String, String>> _chatHistory = [];
  final ScrollController _scrollController = ScrollController();
  final ChatGPTService _chatGPTService = ChatGPTService();
  bool _isSubmitting = false;

  Future<void> _submitAnswers() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      String response = await _chatGPTService.analyzeAnswers(_chatHistory);

      replaceNavigateWithFade(
        context,
        AiResponse(
          response: response,
        ),
      );
    } catch (e) {
      print("Error submitting answers: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _selectOption(String answer) {
    setState(() {
      _chatHistory.add({
        'question': quizQuestions[_chatHistory.length]['question'],
        'answer': answer,
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height * 0.3;
    double progressValue = _chatHistory.length / quizQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health-Based Assessment'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progressValue,
            backgroundColor: Colors.grey[300],
            color: Colors.blue,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
                }
                if (_chatHistory.length < quizQuestions.length) {
                  return questionContainer(
                    quizQuestions[_chatHistory.length]['question'],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 50, color: Colors.green),
                  const SizedBox(height: 15),
                  const Text(
                    "Quiz Completed Successfully!",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Thank you for completing the assessment. Submit to get an overview",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitAnswers,
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 45), // Fixed width and height
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 25, // Adjust the size as needed
                            height: 25, // Adjust the size as needed
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth:
                                  3.0, // Slightly thinner for a better look
                            ),
                          )
                        : const Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )
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
          maxWidth: MediaQuery.of(context).size.width * 0.8,
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
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
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
      ),
    );
  }
}
