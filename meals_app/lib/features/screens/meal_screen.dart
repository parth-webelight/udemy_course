import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/features/models/meal_model.dart';
import 'package:meals_app/features/screens/meal_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transparent_image/transparent_image.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<MealModel> meals;

  String complexityText(int index) {
    final complexityName = meals[index].complexity.name;
    return complexityName[0].toUpperCase() + complexityName.substring(1);
  }

  String affordabilityText(int index) {
    final affordabilityName = meals[index].affordability.name;
    return affordabilityName[0].toUpperCase() + affordabilityName.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: meals.isEmpty
          ? Center(
              child: Text(
                "Not found for this categories...",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: MealDetailsScreen(meal: meals[index]),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(meals[index].imageUrl),
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
                          padding: EdgeInsets.symmetric(
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
                                meals[index].title,
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
                                    '${meals[index].duration} mins',
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
                                    complexityText(index),
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
                                    affordabilityText(index),
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
