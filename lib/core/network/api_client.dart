import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors/failures.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<dynamic>> getList(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerFailure(
          'Erro ao consultar API. Status: ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List<dynamic>) {
        throw ServerFailure('Resposta inválida da API.');
      }

      return decoded;
    } on http.ClientException catch (error) {
      throw NetworkFailure('Falha de conexão: ${error.message}');
    } on ServerFailure {
      rethrow;
    } catch (_) {
      throw ServerFailure('Erro inesperado ao consultar a API.');
    }
  }
}
