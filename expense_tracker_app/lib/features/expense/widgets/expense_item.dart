import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
  });
  final String title;
  final double amount;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Text(title),
      ),
    );
  }
}
