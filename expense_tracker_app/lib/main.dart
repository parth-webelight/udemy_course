import 'package:expense_tracker_app/features/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Tracking App",
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}