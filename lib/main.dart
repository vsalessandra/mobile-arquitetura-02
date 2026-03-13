import 'package:flutter/material.dart';

import 'core/network/api_client.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/pages/product_page.dart';
import 'presentation/viewmodels/product_viewmodel.dart';

void main() {
  final apiClient = ApiClient();
  final remoteDataSource = ProductRemoteDataSourceImpl(apiClient);
  final repository = ProductRepositoryImpl(remoteDataSource);
  final viewModel = ProductViewModel(repository);

  viewModel.loadProducts();

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.viewModel});

  final ProductViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(viewModel: viewModel),
    );
  }
}
