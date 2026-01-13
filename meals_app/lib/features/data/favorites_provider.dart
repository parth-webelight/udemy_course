import 'package:meals_app/features/models/meal_model.dart';

class FavoritesProvider {
  static final List<String> _favoriteMealIds = [];

  static List<String> get favoriteMealIds => List.unmodifiable(_favoriteMealIds);

  static bool isFavorite(String mealId) {
    return _favoriteMealIds.contains(mealId);
  }

  static void toggleFavorite(String mealId) {
    if (_favoriteMealIds.contains(mealId)) {
      _favoriteMealIds.remove(mealId);
    } else {
      _favoriteMealIds.add(mealId);
    }
  }

  static List<MealModel> getFavoriteMeals(List<MealModel> allMeals) {
    return allMeals.where((meal) => _favoriteMealIds.contains(meal.id)).toList();
  }
}
