// ignore_for_file: unused_local_variable, depend_on_referenced_packages, use_super_parameters

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/features/data/dummy_data.dart';
import 'package:meals_app/features/screens/categories_screen.dart';
import 'package:meals_app/features/screens/favorites_screen.dart';
import 'package:meals_app/features/screens/filter_screen.dart';
import 'package:page_transition/page_transition.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'Filter') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        PageTransition(type: PageTransitionType.fade, child: FilterScreen(currentFilters: _selectedFilters)),
      );
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
    } else {
      setState(() {
        _selectedFilters = {
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        };
        _selectedIndex = 0;
      });
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Pick your category';
      case 1:
        return 'Your Favorites';
      default:
        return 'Pick your category';
    }
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        final availableMeals = dummyMealModels.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();
        return CategoriesScreen(availableMeals: availableMeals);
      case 1:
        return const FavoritesScreen();
      default:
        final availableMeals = dummyMealModels.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();
        return CategoriesScreen(availableMeals: availableMeals);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(_getTitle(_selectedIndex)),
        centerTitle: true,
      ),
      body: _getScreen(_selectedIndex),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black45),
              child: Row(
                children: [
                  Icon(Icons.restaurant_menu, size: 48, color: Colors.white),
                  const SizedBox(width: 16),
                  Text(
                    'Cooking Up!',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.restaurant, color: Colors.white),
              title: Text(
                'All Meals',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                _setScreen('Meals');
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_list, color: Colors.white),
              title: Text(
                'Filter',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                _setScreen('Filter');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
