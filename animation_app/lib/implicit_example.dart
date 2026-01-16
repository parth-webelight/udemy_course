import 'package:flutter/material.dart';

class ImplicitExample extends StatefulWidget {
  const ImplicitExample({super.key});

  @override
  State<ImplicitExample> createState() => _ImplicitExampleState();
}

class _ImplicitExampleState extends State<ImplicitExample> {
  double boxSize = 100;
  Color boxColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Implicit Animation")),
      body: Column(
        children: [
          Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: boxSize, 
              height: boxSize,
              color: boxColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            boxSize = boxSize == 100 ? 200 : 100;
            boxColor = boxColor == Colors.blue ? Colors.red : Colors.blue;
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}