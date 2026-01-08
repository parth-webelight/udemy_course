import 'package:expense_tracker_app/features/expense/model/expense_model.dart';
import 'package:expense_tracker_app/features/expense/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<ExpenseModel> _registerExpense = [
    ExpenseModel(
      title: "Dinner",
      amount: 5000,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      title: "Travel",
      amount: 50000,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    ExpenseModel(
      title: "Travel",
      amount: 5000,
      date: DateTime.now(),
      category: Category.travel,
    ),
    ExpenseModel(
      title: "Buy PC",
      amount: 5000,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Dinner",
      amount: 500,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      title: "Buy CPU",
      amount: 5000,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Buy Car",
      amount: 5000,
      date: DateTime.now(),
      category: Category.work,
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Text("Hello !");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Track Expense"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpense();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("CHART"),
          Expanded(
            child: ListView.builder(
              itemCount: _registerExpense.length,
              itemBuilder: (context, index) => ExpenseItem(
                title: _registerExpense[index].title,
                amount: _registerExpense[index].amount,
                date: _registerExpense[index].date,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
