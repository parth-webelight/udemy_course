import 'package:flutter/material.dart';

class ExplicitExample extends StatefulWidget {
  const ExplicitExample({super.key});

  @override
  State<ExplicitExample> createState() => _ExplicitExampleState();
}

class _ExplicitExampleState extends State<ExplicitExample>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    sizeAnimation = Tween<double>(begin: 100, end: 200)
        .animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explicit Animation")),
      body: Center(
        child: Container(
          width: sizeAnimation.value,
          height: sizeAnimation.value,
          color: Colors.green,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
