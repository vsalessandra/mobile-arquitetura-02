import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'data/datasources/product_local_datasource.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'presentation/pages/product_page.dart';
import 'presentation/viewmodels/product_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final apiClient = ApiClient();
  final remoteDataSource = ProductRemoteDataSourceImpl(apiClient);
  final localDataSource = ProductLocalDataSourceImpl(sharedPreferences);
  final repository = ProductRepositoryImpl(remoteDataSource, localDataSource);
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
