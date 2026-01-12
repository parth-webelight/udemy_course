import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';

class BillSplitterScreen extends StatefulWidget {
  const BillSplitterScreen({super.key});

  @override
  State<BillSplitterScreen> createState() => _BillSplitterScreenState();
}

class _BillSplitterScreenState extends State<BillSplitterScreen> {
  final _formKey = GlobalKey<FormState>();

  final totalAmountController = TextEditingController();
  final numberOfMemberController = TextEditingController();

  @override
  void dispose() {
    totalAmountController.dispose();
    numberOfMemberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Bill Split",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: "Enter total amount",
                    labelText: "Total Amount",
                    keyboardType: TextInputType.number,
                    controller: totalAmountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Total amount is required";
                      }
                      if (double.tryParse(value) == null) {
                        return "Enter valid number";
                      }
                      if (double.parse(value) <= 0) {
                        return "Amount must be greater than 0";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  CustomTextFormField(
                    hintText: "Enter number of friends",
                    labelText: "Number of Friends",
                    keyboardType: TextInputType.number,
                    controller: numberOfMemberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Number of friends is required";
                      }
                      final count = int.tryParse(value);
                      if (count == null) {
                        return "Enter valid number";
                      }
                      if (count <= 0) {
                        return "Must be at least 1";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(15),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final total = double.parse(
                            totalAmountController.text,
                          );
                          final members = int.parse(
                            numberOfMemberController.text,
                          );
                          final perPerson = total / members;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Each person pays ₹${perPerson.toStringAsFixed(2)}",
                              ),
                            ),
                          );
                          totalAmountController.clear();
                          numberOfMemberController.clear();
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text("Calculate"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}