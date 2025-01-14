import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatGPTService {
  final String _apiUrl = "https://api.openai.com/v1/chat/completions";
  final String _apiKey =
      "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"; // Replace with your actual API key

  Future<String> analyzeAnswers(List<Map<String, String>> answers) async {
    try {
      // Prepare the message content from the answers
      final String messageContent = answers
          .map((answer) =>
              "${answer['question']}\nAnswer: ${answer['answer']}\n")
          .join();
      print("Message Content: $messageContent");

      // Prepare the API request body
      final body = jsonEncode({
        "model": "gpt-3.5-turbo",
        "temperature": 0.7,
        "top_p": 1.0,
        "messages": [
          {
            "role": "system",
            "content":
                "You are a leading expert in Wellness, Habit Building, Finance Management, and Relationship Advising. Provide highly detailed, professional, and comprehensive responses, including relevant examples and insights with respect to health regulations."
          },
          {"role": "user", "content": messageContent},
        ],
      });

      // Make the API request
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: body,
      );
      print("Response body: ${response.body}");

      // Handle the response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data['choices'][0]['message']['content'];
      } else {
        return "Error: Unable to process the request. (${response.statusCode})";
      }
    } catch (e) {
      return "Error $e";
    }
  }
}
