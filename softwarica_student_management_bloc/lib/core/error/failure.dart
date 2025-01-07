class Failure {
  final String message;
  final int? statusCode;
  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

class ApiFailure extends Failure {
  @override
  // ignore: overridden_fields
  final int statusCode;

  ApiFailure({
    required this.statusCode,
    required super.message,
  })
}
