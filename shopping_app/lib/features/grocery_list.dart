// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shopping_app/data/categories.dart';
import 'package:shopping_app/models/grocery.dart';
import 'package:shopping_app/features/new_item.dart';
import 'package:shopping_app/services/firebase_service.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  bool _isLoading = true;
  String? _error;

  void _loadItems() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await FirebaseService.fetchGroceryItems();

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
          _isLoading = false;
        });
        return;
      }

      if (response.body == 'null') {
        setState(() {
          _groceryItems = [];
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];

      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
              (catItem) => catItem.value.title == item.value['category'],
            )
            .value;

        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _addItem() async {
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = Center(
        child: LoadingAnimationWidget.fallingDot(
          color: Colors.amber.shade900,
          size: 50,
        ),
      );
    } else if (_error != null) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loadItems, child: const Text('Retry')),
          ],
        ),
      );
    } else if (_groceryItems.isEmpty) {
      content = const Center(
        child: Text("Please add some item...", style: TextStyle(fontSize: 16)),
      );
    } else {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          final item = _groceryItems[index];
          return Dismissible(
            key: ValueKey(item.id),
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: const Row(
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              color: Colors.red.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (direction) async {
              setState(() {
                _groceryItems.remove(item);
              });

              final response = await FirebaseService.deleteItem(item.id);

              if (response.statusCode >= 400) {
                setState(() {
                  _groceryItems.insert(index, item);
                });
              }
            },
            child: ListTile(
              title: Text(item.name),
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: item.category.color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              trailing: Text(item.quantity.toString()),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade900,
        foregroundColor: Colors.white,
        title: const Text('Your Groceries'),
        centerTitle: true,
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
