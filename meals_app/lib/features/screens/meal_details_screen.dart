import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/features/providers/favorites_provider.dart';
import 'package:meals_app/features/models/meal_model.dart';

class MealDetailsScreen extends StatefulWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final MealModel meal;

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  MealModel get meal => widget.meal;

  String get complexityText {
    final name = meal.complexity.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  String get affordabilityText {
    final name = meal.affordability.name;
    return name[0].toUpperCase() + name.substring(1);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBadge(String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(meal.title, style: GoogleFonts.poppins()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              FavoritesProvider.isFavorite(meal.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: FavoritesProvider.isFavorite(meal.id)
                  ? Colors.red
                  : Colors.white,
            ),
            onPressed: () {
              setState(() {
                FavoritesProvider.toggleFavorite(meal.id);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 260,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildBadge('${meal.duration} mins', icon: Icons.schedule),
                      const SizedBox(width: 8),
                      _buildBadge(complexityText, icon: Icons.work),
                      const SizedBox(width: 8),
                      _buildBadge(affordabilityText, icon: Icons.money),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      if (meal.isGlutenFree)
                        _buildBadge('Gluten-free', icon: Icons.check_circle),
                      if (meal.isLactoseFree)
                        _buildBadge('Lactose-free', icon: Icons.check_circle),
                      if (meal.isVegan) _buildBadge('Vegan', icon: Icons.eco),
                      if (meal.isVegetarian)
                        _buildBadge('Vegetarian', icon: Icons.spa),
                    ],
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Ingredients'),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      itemCount: meal.ingredients.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ',
                                    style: TextStyle(color: Colors.white)),
                                Expanded(
                                  child: Text(
                                    meal.ingredients[index],
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (index != meal.ingredients.length - 1)
                              const Divider(
                                  color: Colors.white12, height: 8),
                          ],
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('Steps'),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meal.steps.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.orangeAccent,
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  meal.steps[index],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
