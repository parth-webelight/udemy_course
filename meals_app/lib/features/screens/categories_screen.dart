import 'package:flutter/material.dart';
import 'package:meals_app/features/data/dummy_data.dart';
import 'package:meals_app/features/models/categories_model.dart';
import 'package:meals_app/features/models/meal_model.dart';
import 'package:meals_app/features/screens/meal_screen.dart';
import 'package:meals_app/features/widgets/categories_grid_item.dart';
import 'package:page_transition/page_transition.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<MealModel> availableMeals;

  void _selectCategory(BuildContext context, CategoriesModel categories) {
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(categories.id)).toList();
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: MealScreen(title: categories.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        children: [
          for (final category in availableCategories)
            if (availableMeals.any((meal) => meal.categories.contains(category.id)))
              CategoriesGridItem(
                categoriesModel: category,
                onSelectCategory: () => _selectCategory(context, category),
              ),
        ],
      ),
    );
  }
}