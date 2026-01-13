import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/features/data/dummy_data.dart';
import 'package:meals_app/features/data/favorites_provider.dart';
import 'package:meals_app/features/models/meal_model.dart';
import 'package:meals_app/features/screens/meal_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<MealModel> get favoriteMeals {
    return FavoritesProvider.getFavoriteMeals(dummyMealModels);
  }

  @override
  Widget build(BuildContext context) {
    final favorites = favoriteMeals;

    return Container(
      color: Colors.black,
      child: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.white24,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "No favorites yet!",
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Start adding meals to your favorites",
                    style: GoogleFonts.poppins(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: MealDetailsScreen(meal: favorites[index]),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                  child: Stack(
                    children: [
                      FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(favorites[index].imageUrl),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 44,
                          ),
                          child: Column(
                            children: [
                              Text(
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                favorites[index].title,
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${favorites[index].duration} mins',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.work,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    favorites[index].complexity.name[0].toUpperCase() +
                                        favorites[index].complexity.name.substring(1),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.money,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    favorites[index].affordability.name[0].toUpperCase() +
                                        favorites[index].affordability.name.substring(1),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
