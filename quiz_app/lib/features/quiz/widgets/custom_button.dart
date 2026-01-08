import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(10),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple.shade400,
        textStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onPressed: onPressed,
      child: Text(title,textAlign: TextAlign.center,),
    );
  }
}
