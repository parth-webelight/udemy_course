import 'package:flutter/material.dart';
import 'package:shopping_app/features/grocery_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      home: const GroceryList(),
      debugShowCheckedModeBanner: false,
    );
  }
}