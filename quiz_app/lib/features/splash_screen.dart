import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/features/quiz/screens/quiz_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Image.asset("assets/images/app_logo.jpg", width: 300),
            const SizedBox(height: 20),
            Text(
              "Learn flutter to fun way !",
              style: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 20),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
              },
              style: OutlinedButton.styleFrom (
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple
              ),
              icon: Icon(Icons.arrow_right_alt,color: Colors.white,),
              label: Text("Start Quiz",style: GoogleFonts.poppins(),),
            ),
          ],
        ),
      ),
    );
  }
}