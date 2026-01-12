import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.title,
    required this.isBackgroundColor,
  });
  final Function onPress;
  final String title;
  final bool isBackgroundColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPress(),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isBackgroundColor
            ? Colors.indigo
            : Colors.white,
      ),
      child: Text(
        widget.title,
        style: TextStyle(
          color: widget.isBackgroundColor ? Colors.white : Colors.indigo,
        ),
      ),
    );
  }
}
