import 'package:flutter/material.dart';
import '../model/quiz_question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  final List<String> selectedAnswers = [];

  void answerQuestion(String selectedAnswer) {
    setState(() {
      selectedAnswers.add(selectedAnswer);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              questions: questions,
              selectedAnswers: selectedAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...question.answers.map(
                (answer) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: customeButton(
                      () => answerQuestion(answer),
                      answer,
                      context,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customeButton(
  void Function() function,
  String text,
  BuildContext context,
) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
      padding: EdgeInsets.all(10),
    ),
    child: Text(text),
  );
}
