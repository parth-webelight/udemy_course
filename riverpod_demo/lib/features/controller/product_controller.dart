import 'package:flutter_riverpod/legacy.dart';
import '../model/product_model.dart';
import '../data/dummy_products.dart';

class ProductController extends StateNotifier<List<ProductModel>> {
  ProductController() : super(dummyProducts);

  // ADD PRODUCT
  void addProduct(ProductModel product) {
    state = [...state, product];
  }

  // UPDATE PRODUCT
  void updateProduct(int id, ProductModel updated) {
    
    state = state.map((item) {
      return item.id == id ? updated : item;
    }).toList();
  }

  // DELETE PRODUCT
  void deleteProduct(int id) {
    state = state.where((item) => item.id != id).toList();
  }
}

// REAL PROVIDER
final productProvider =
    StateNotifierProvider<ProductController, List<ProductModel>>(
  (ref) => ProductController(),
);
