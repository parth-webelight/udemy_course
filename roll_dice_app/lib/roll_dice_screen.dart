import 'dart:math';
import 'package:flutter/material.dart';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen({super.key});

  @override
  State<RollDiceScreen> createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  int currentDiceIndex = 1;
  int currentCoinIndex = 1;
  WhichStateActive stateActive = WhichStateActive.dice;

  void rollDice() {
    setState(() {
      stateActive = WhichStateActive.dice;
      currentDiceIndex = Random().nextInt(6) + 1;
    });
  }

  void coinFlip() {
    setState(() {
      stateActive = WhichStateActive.coin;
      currentCoinIndex = Random().nextInt(2) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 26, 2, 80),
              Color.fromARGB(255, 45, 7, 98),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            stateActive == WhichStateActive.dice
                ? Image.asset(
                    "assets/images/dice-$currentDiceIndex.png",
                    width: 200,
                  )
                : Image.asset(
                    "assets/images/coin-$currentCoinIndex.png",
                    width: 200,
                  ),
            const SizedBox(height: 30),
            customButton("Roll Dice", rollDice),
            const SizedBox(height: 20),
            customButton("Coin Flip", coinFlip),
          ],
        ),
      );
  }
}

Widget customButton(String name, VoidCallback onPressed) {
  return TextButton(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(20),
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      textStyle: const TextStyle(fontSize: 28),
    ),
    onPressed: onPressed,
    child: Text(name),
  );
}

enum WhichStateActive {
  coin,
  dice
}
