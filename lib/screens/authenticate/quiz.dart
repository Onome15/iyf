import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is your favorite programming language?',
      'options': ['Dart', 'Python', 'Java', 'C#', 'gyvv'],
    },
    {
      'question': 'What is your preferred IDE?',
      'options': ['VS Code', 'Android Studio', 'IntelliJ IDEA', 'Eclipse'],
    },
    {
      'question': 'What type of projects do you enjoy?',
      'options': [
        'Web Development',
        'Mobile Apps',
        'Data Science',
        'Game Development',
        'vyvy'
      ],
    },
  ];

  final List<Map<String, String>> _chatHistory = []; // Store chat messages

  Future<void> _submitAnswers() async {
    print("Submitting answers: $_chatHistory");
    await Future.delayed(const Duration(seconds: 1));
    print("Answers submitted successfully!");
  }

  void _selectOption(String answer) {
    setState(() {
      _chatHistory.add({
        'question': _questions[_chatHistory.length]['question'],
        'answer': answer,
      });

      if (_chatHistory.length >= _questions.length) {
        _submitAnswers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Based Assessment'),
      ),
      body: Column(
        children: [
          // Chat history
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _chatHistory.length + 1,
              itemBuilder: (context, index) {
                if (index < _chatHistory.length) {
                  final chat = _chatHistory[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Question
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            chat['question']!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Answer
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                            child: Text(
                              chat['answer']!,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (_chatHistory.length < _questions.length) {
                  // Show the current question at the end
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _questions[_chatHistory.length]['question'],
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Options section
          if (_chatHistory.length < _questions.length)
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[900],
              padding: const EdgeInsets.all(15),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _questions[_chatHistory.length]['options']
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
                          style: const TextStyle(
                              color: Colors.white), // White text
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          if (_chatHistory.length >= _questions.length)
            Container(
              width: double.infinity, // Full width
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Thank you for completing the quiz!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
