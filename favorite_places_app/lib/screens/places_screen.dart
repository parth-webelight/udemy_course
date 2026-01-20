import 'package:favorite_places_app/providers/user_places.dart';
import 'package:favorite_places_app/screens/add_places_screen.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Places',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.grey.shade600,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlacesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add Place',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(places: userPlaces),
      ),
      floatingActionButton: userPlaces.isEmpty
          ? FloatingActionButton.extended(
            backgroundColor: Colors.grey.shade600,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPlacesScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add, color: Colors.white,),
              label: const Text('Add Your First Place',style: TextStyle(color: Colors.white),),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPlacesScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
