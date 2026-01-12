// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/features/models/categories_model.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({super.key, required this.categoriesModel});

  final CategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
          categoriesModel.color.withOpacity(0.55),
          categoriesModel.color.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
        ),
      ),
      child: Text(categoriesModel.title,style: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}