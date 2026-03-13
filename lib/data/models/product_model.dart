import '../../domain/entities/product.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  final int id;
  final String title;
  final double price;
  final String image;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      title: (json['title'] as String?) ?? '',
      price: (json['price'] as num).toDouble(),
      image: (json['image'] as String?) ?? '',
    );
  }

  Product toEntity() {
    return Product(id: id, title: title, price: price, image: image);
  }
}
