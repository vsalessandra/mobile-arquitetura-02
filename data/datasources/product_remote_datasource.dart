import '../../core/network/api_client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;
  static const _productsUrl = 'https://fakestoreapi.com/products';

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.getList(_productsUrl);

    return response
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }
}
