import 'package:flutter/material.dart';

import '../model/quiz_question.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<QuizQuestion> questions;
  final List<String> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
  });

  int get correctCount {
    int count = 0;
    for (var i = 0; i < questions.length && i < selectedAnswers.length; i++) {
      final correctAnswer = questions[i].answers.first;
      if (selectedAnswers[i] == correctAnswer) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final totalQuestions = questions.length;
    final wrongCount = totalQuestions - correctCount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text('Quiz Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Your Score',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$correctCount / $totalQuestions',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Right: $correctCount   Wrong: $wrongCount',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Questions & Answers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final userAnswer = selectedAnswers[index];
                  final correctAnswer = question.answers.first;
                  final isCorrect = userAnswer == correctAnswer;

                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.text}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Your answer: $userAnswer',
                            style: TextStyle(
                              color: isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (!isCorrect)
                            Text(
                              'Correct answer: $correctAnswer',
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Retest Quiz',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

