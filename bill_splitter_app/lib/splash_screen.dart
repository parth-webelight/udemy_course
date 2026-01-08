import 'package:flutter/material.dart';

import 'features/bill_splitter/bill_splitter_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const BillSplitterScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade200,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(Icons.attach_money_outlined, color: Colors.white, size: 100),
            const SizedBox(height: 20,),
            Text("Split Your Bill !",style: TextStyle(color: Colors.white,fontSize: 28),),
          ],
        ),
      ),
    );
  }
}
