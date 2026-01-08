import 'package:first_app/passing_argument.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.color1, this.color2, {super.key});

  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PassingrRequiredArgument(
              name: "Hello Admin,",
              message: "Good Morning !",
            ),
            OptionalArgumet(subtitle: "Welcome to flutter dev !"),
            PositionalArgument("Welcome Back !"),
            RequiredArgument(data: "Hello !"),
            OptionalArgumentStateFull(userName: "User"),
            NamedArgument(userName: "Admin"),
          ],
        ),
      ),
    );
  }
}
