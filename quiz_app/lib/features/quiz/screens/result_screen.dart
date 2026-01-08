import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    for (var i = 0; i < questions.length; i++) {
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
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$correctCount / $totalQuestions',
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Right: $correctCount   Wrong: $wrongCount',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Questions & Answers',
              style: GoogleFonts.poppins(
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
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Your answer: $userAnswer',
                            style: GoogleFonts.poppins(
                              color: isCorrect ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (!isCorrect)
                            Text(
                              'Correct answer: $correctAnswer',
                              style: GoogleFonts.poppins(color: Colors.green),
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
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Retest Quiz',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
