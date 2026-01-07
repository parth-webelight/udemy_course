import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.all(20),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        textStyle: const TextStyle(fontSize: 28),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
