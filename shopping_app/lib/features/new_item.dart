// ignore_for_file: unused_field, prefer_final_fields, deprecated_member_use, unused_import, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/categories.dart';
import 'package:shopping_app/models/grocery.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/services/firebase_service.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() {
      _isSending = true;
    });
    final response = await FirebaseService.addGroceryItem(
      name: _enteredName,
      quantity: _enteredQuantity,
      category: _selectedCategory.title,
    );

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  InputDecoration _inputDecoration({
    required String label,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.amber.shade900, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
        title: const Text('Add a new item'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: _inputDecoration(
                    label: "Item Name",
                    icon: Icons.shopping_cart_outlined,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty || 
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _enteredName = newValue!,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _enteredQuantity.toString(),
                  decoration: _inputDecoration(
                    label: "Quantity",
                    icon: Icons.numbers,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.tryParse(value) == null ||
                        int.tryParse(value)! <= 0) {
                      return 'Must be a valid number.';
                    }
                    return null;
                  },
                  onSaved: (newValue) =>
                      _enteredQuantity = int.parse(newValue!),
                ),
                
                const SizedBox(height: 25),
                
                DropdownButtonFormField(
                  value: _selectedCategory,
                  decoration: _inputDecoration(
                    label: "Category",
                    icon: Icons.category_outlined,
                  ),
                  items: [
                    for (final category in categories.entries)
                      DropdownMenuItem(
                        value: category.value,
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: category.value.color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(category.value.title),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedCategory = value!);
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending
                          ? null
                          : () => _formKey.currentState!.reset(),
                      child:  Text('Reset',style: TextStyle(color: Colors.amber.shade900),),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _isSending ? null : _saveItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade900,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: _isSending
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.add),
                      label: Text(_isSending ? "Adding..." : "Add Item"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}