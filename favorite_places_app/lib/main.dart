import 'package:favorite_places_app/screens/places_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Places',
      debugShowCheckedModeBanner: false,

      home: const PlacesScreen(),
    );
  }
}







// lib/
// helpers/
// │   db_helper.dart          # SQLite operations
// models/
// │    place_model.dart        # Data models with serialization
// providers/
// │   └user_places.dart        # Riverpod state management
// screens/
// │   places_screen.dart      # Main places list
// │   add_places_screen.dart  # Add new place form
// │   places_detail_screen.dart # Place details view
// widgets/
// │   image_input.dart        # Camera/gallery picker
// │   location_input.dart     # GPS location capture
// │   places_list.dart        # Places list with delete
// main.dart                   # App entry point with theming