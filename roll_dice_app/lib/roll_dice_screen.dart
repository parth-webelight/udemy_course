import 'dart:math';
import 'package:flutter/material.dart';
import 'package:roll_dice_app/widgets/custom_button.dart';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen({super.key});

  @override
  State<RollDiceScreen> createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  int currentDiceIndex = 1;
  int currentCoinIndex = 1;
  WhichStateActive stateActive = WhichStateActive.dice;

  // Random().nextInt(max) + startPoint;
  // DO NOT WRITE MIN THAN AUTOMATICALLY ASSIGNED 0
  // Random().nextInt(6) + 5; IN THIS NUMBER ONLY 5 AND 10

  void rollDice() {
    setState(() {
      stateActive = WhichStateActive.dice;
      currentDiceIndex = Random().nextInt(6) + 1;
    });
    debugPrint(currentDiceIndex.toString());
  }

  void coinFlip() {
    setState(() {
      stateActive = WhichStateActive.coin;
      currentCoinIndex = Random().nextInt(2) + 1;
    });
    debugPrint(currentCoinIndex.toString());
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
          CustomButton(title: "Roll Dice", onPressed: rollDice),
          const SizedBox(height: 20),
          CustomButton(title: "Coin Flip", onPressed: coinFlip),
        ],
      ),
    );
  }
}

enum WhichStateActive { coin, dice }
