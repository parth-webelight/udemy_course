import 'package:expense_tracker_app/features/expense/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.onAddExpense});

  final Function(ExpenseModel expense) onAddExpense;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
    debugPrint(_selectedDate.toString());
  }

  void _submitData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid input !!"),
          content: Text(
            "Please make sure a valid title, amount, date and category was entered.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("I Understand"),
            ),
          ],
        ),
      );
    } else {
      widget.onAddExpense(
        ExpenseModel(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            "Add New Expense",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              hintText: "Enter Title",
              labelText: "Title",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Enter Amount",
              labelText: "Amount",
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                _selectedDate == null
                    ? "No Date Selected"
                    : formatter.format(_selectedDate!),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                onPressed: () {
                  _presentDatePicker();
                },
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              DropdownButton<Category>(
                style: Theme.of(context).textTheme.bodyMedium,
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (e) => DropdownMenuItem<Category>(
                        value: e,
                        child: Text(
                          e.name.toString().toUpperCase(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    } else {
                      _selectedCategory = value;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitData();
                },
                child: Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
