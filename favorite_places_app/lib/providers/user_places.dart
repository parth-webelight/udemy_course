import 'dart:io';
import 'package:favorite_places_app/helpers/db_helper.dart';
import 'package:favorite_places_app/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super([]) {
    loadPlaces();
  }

  Future<DBResult> loadPlaces() async {
    final dataList = await DBHelper.getData('user_places');

    if (dataList.isEmpty) {
      state = [];
      return DBResult.empty;
    }

    state = dataList.map((e) => PlaceModel.fromMap(e)).toList();
    return DBResult.success;
  }

  Future<DBResult> addPlace(
    String title,
    File image,
    PlaceLocation location,
  ) async {
    final newPlace = PlaceModel(
      title: title,
      image: image,
      location: location,
    );

    final result = await DBHelper.insert(
      'user_places',
      newPlace.toMap().cast<String, Object>(),
    );

    if (result == DBResult.success) {
      state = [newPlace, ...state];
    }

    return result;
  }

  Future<DBResult> removePlace(String id) async {
    final result = await DBHelper.delete('user_places', id);

    if (result == DBResult.success) {
      state = state.where((place) => place.id != id).toList();
    }

    return result;
  }
}


final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
      (ref) => UserPlacesNotifier(),
    );
