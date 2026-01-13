// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:meals_app/features/screens/tabs_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
     Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageTransition(type: PageTransitionType.fade, child: TabsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dining_rounded,
              color: Colors.black,
              size: 110,
            ),
            SizedBox(height: 20),
            Text(
              "Meals App",
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.black45,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            LoadingAnimationWidget.fourRotatingDots(color: Colors.black, size: 45),
          ],
        ),
      ),
    );
  }
}