import 'package:meals_app/features/models/meal_model.dart';

class FavoritesProvider {
  
  // THIS LINE STAND'S PRIVATE VARIABLE IN THAT MEAN NOT ACCESS OUT SIDE THE CLASS.
  static final List<String> _favoriteMealIds = [];

  // THIS IS A PUBLIC GETTER. PUBLIC ONLY READ THIS LIST NOT MODIFY THAT'S WHY WRITE unmodifiable.
  // static List<String> get favoriteMealIds => List.unmodifiable(_favoriteMealIds);

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
    return allMeals
        .where((meal) => _favoriteMealIds.contains(meal.id))
        .toList();
  }
}