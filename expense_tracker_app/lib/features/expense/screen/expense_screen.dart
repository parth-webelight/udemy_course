import 'package:expense_tracker_app/features/expense/model/expense_model.dart';
import 'package:expense_tracker_app/features/expense/widgets/chart/chart.dart';
import 'package:expense_tracker_app/features/expense/widgets/custom_bottom_sheet.dart';
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
      title: 'Lunch at Restaurant',
      amount: 45.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.food,
    ),
    ExpenseModel(
      title: 'Flight to Paris',
      amount: 850.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: Category.travel,
    ),
    ExpenseModel(
      title: 'Movie Tickets',
      amount: 25.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: Category.leisure,
    ),
    ExpenseModel(
      title: 'Office Supplies',
      amount: 120.75,
      date: DateTime.now().subtract(const Duration(days: 7)),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Groceries',
      amount: 95.30,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: Category.food,
    ),
    ExpenseModel(
      title: 'Taxi Ride',
      amount: 35.00,
      date: DateTime.now().subtract(const Duration(days: 4)),
      category: Category.travel,
    ),
  ];

  

  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CustomBottomSheet(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseModel expense) {
    setState(() {
      _registerExpense.add(expense);
      Navigator.pop(context);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registerExpense.indexOf(expense);
    setState(() {
      _registerExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registerExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Expense"),
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
          Chart(expenses: _registerExpense),
          Expanded(
            child: _registerExpense.isNotEmpty
                ? ListView.builder(
                    itemCount: _registerExpense.length,
                    itemBuilder: (context, index) => Dismissible(
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) =>
                          _removeExpense(_registerExpense[index]),
                      key: ValueKey(_registerExpense[index]),
                      child: ExpenseItem(
                        title: _registerExpense[index].title,
                        amount: _registerExpense[index].amount,
                        date: _registerExpense[index].date,
                        category: _registerExpense[index].category,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No expenses found !",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}