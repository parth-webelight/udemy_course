import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String _baseUrl =
      'flutter-prep-1601-default-rtdb.firebaseio.com';

  static Future<http.Response> addGroceryItem({
    required String name,
    required int quantity,
    required String category,
  }) async {
    final url = Uri.https(_baseUrl, 'shopping-list.json');

    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'category': category,
      }),
    );
  }

  static Future<http.Response> fetchGroceryItems() {
    final url = Uri.https(_baseUrl, 'shopping-list.json');
    return http.get(url);
  }

  static Future<http.Response> deleteItem(String id) {
    final url = Uri.https(_baseUrl, 'shopping-list/$id.json');
    return http.delete(url);
  }
} 