class Failure implements Exception {
  Failure(this.message);

  final String message;

  @override
  String toString() => 'Failure(message: $message)';
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
