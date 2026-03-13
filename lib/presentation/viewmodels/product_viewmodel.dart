import 'package:flutter/foundation.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

enum ProductUiStatus { initial, loading, success, error }

class ProductState {
  const ProductState({
    this.status = ProductUiStatus.initial,
    this.products = const <Product>[],
    this.error,
  });

  final ProductUiStatus status;
  final List<Product> products;
  final String? error;

  bool get isLoading => status == ProductUiStatus.loading;

  ProductState copyWith({
    ProductUiStatus? status,
    List<Product>? products,
    String? error,
    bool clearError = false,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class ProductViewModel {
  ProductViewModel(this.repository);

  final ProductRepository repository;
  final ValueNotifier<ProductState> state = ValueNotifier(const ProductState());

  Future<void> loadProducts() async {
    state.value = state.value.copyWith(
      status: ProductUiStatus.loading,
      clearError: true,
    );

    try {
      final products = await repository.getProducts();
      state.value = state.value.copyWith(
        status: ProductUiStatus.success,
        products: products,
        clearError: true,
      );
    } catch (error) {
      state.value = state.value.copyWith(
        status: ProductUiStatus.error,
        error: _mapErrorMessage(error),
      );
    }
  }

  String _mapErrorMessage(Object error) {
    if (error is Failure) {
      return error.message;
    }

    return 'Não foi possível carregar os produtos.';
  }

  void dispose() {
    state.dispose();
  }
}
