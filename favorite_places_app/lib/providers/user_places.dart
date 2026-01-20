import 'dart:io';
import 'package:favorite_places_app/helpers/db_helper.dart';
import 'package:favorite_places_app/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super([]) {
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    final places = dataList.map((item) => PlaceModel.fromMap(item)).toList();
    state = places;
  }

  Future<void> addPlace(String title, File image, PlaceLocation location) async {
    final newPlace = PlaceModel(
      title: title,
      image: image,
      location: location,
    );
    
    await DBHelper.insert('user_places', newPlace.toMap().cast<String, Object>());
    state = [newPlace, ...state];
  }

  Future<void> removePlace(String id) async {
    await DBHelper.delete('user_places', id);
    state = state.where((place) => place.id != id).toList();
  }

  Future<void> updatePlace(String id, String title, File image, PlaceLocation location) async {
    final updatedPlace = PlaceModel(
      id: id,
      title: title,
      image: image,
      location: location,
    );
    
    await DBHelper.update('user_places', id, updatedPlace.toMap().cast<String, Object>());
    state = state.map((place) => place.id == id ? updatedPlace : place).toList();
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
      (ref) => UserPlacesNotifier(),
    );
