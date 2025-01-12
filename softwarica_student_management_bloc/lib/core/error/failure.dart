class Failure {
  final String message;

  Failure({
    required this.message,
  });
}

class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({
    required super.message,
  });
}

class WebApiFailure extends Failure {
  final int statusCode;

  WebApiFailure({
    required super.message,
    required this.statusCode,
  });
}
