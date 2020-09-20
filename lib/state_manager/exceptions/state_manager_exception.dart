import 'package:flutter/foundation.dart';

/// State manager exception
class StateManagerException implements Exception {
  /// Initializes state manager exception
  ///
  /// [message] is required
  StateManagerException({
    @required this.message,
  });

  /// Exception message
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
