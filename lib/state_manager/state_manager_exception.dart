class StateManagerException implements Exception {
  StateManagerException({
    this.message,
  });

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
