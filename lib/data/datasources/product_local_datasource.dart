import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(this._sharedPreferences);

  static const _productsCacheKey = 'products_cache';

  final SharedPreferences _sharedPreferences;

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final encodedProducts = jsonEncode(
      products
          .map(
            (product) => {
              'id': product.id,
              'title': product.title,
              'price': product.price,
              'image': product.image,
            },
          )
          .toList(),
    );

    await _sharedPreferences.setString(_productsCacheKey, encodedProducts);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final cachedString = _sharedPreferences.getString(_productsCacheKey);

    if (cachedString == null || cachedString.isEmpty) {
      return const <ProductModel>[];
    }

    final decoded = jsonDecode(cachedString);
    if (decoded is! List) {
      return const <ProductModel>[];
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }
}
