import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
        Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2D2D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "River Pod",
              style: TextStyle(
                fontSize: 26.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3.w,
              ),
            ),

            SizedBox(height: 3.h),

            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
