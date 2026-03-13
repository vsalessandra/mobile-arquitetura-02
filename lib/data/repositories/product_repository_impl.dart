import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final remoteModels = await _remoteDataSource.getProducts();
      await _localDataSource.cacheProducts(remoteModels);
      return remoteModels.map((model) => model.toEntity()).toList();
    } on Failure catch (failure) {
      final cachedModels = await _localDataSource.getCachedProducts();
      if (cachedModels.isNotEmpty) {
        return cachedModels.map((model) => model.toEntity()).toList();
      }

      throw failure;
    }
  }
}
