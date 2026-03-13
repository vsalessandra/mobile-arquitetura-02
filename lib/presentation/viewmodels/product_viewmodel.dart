import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductState {
  const ProductState({
    this.isLoading = false,
    this.products = const <Product>[],
    this.error,
  });

  final bool isLoading;
  final List<Product> products;
  final String? error;

  ProductState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? error,
    bool clearError = false,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
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
    state.value = state.value.copyWith(isLoading: true, clearError: true);

    try {
      final products = await repository.getProducts();
      state.value = state.value.copyWith(
        isLoading: false,
        products: products,
        clearError: true,
      );
    } catch (error) {
      state.value = state.value.copyWith(
        isLoading: false,
        error: error.toString(),
      );
    }
  }

  void dispose() {
    state.dispose();
  }
}
