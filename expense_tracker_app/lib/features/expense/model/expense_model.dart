import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
final uuid = Uuid();



class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formatterDate {
    return formatter.format(date);
  }
}

enum Category { food, travel, leisure, work }

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expense;

  const ExpenseBucket({required this.category, required this.expense});

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
    : expense = allExpenses
          .where((element) => element.category == category)
          .toList();

  double get totalExpense {
    double sum = 0;
    for (final exp in expense) {
      sum += exp.amount;
    }
    return sum;
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};