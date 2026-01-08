import 'package:flutter/material.dart';
import 'package:quiz_app/features/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "QUIZ APP",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
