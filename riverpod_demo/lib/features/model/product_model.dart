class ProductModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    double? price,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }
}
