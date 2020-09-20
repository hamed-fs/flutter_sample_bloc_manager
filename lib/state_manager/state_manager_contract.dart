import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

typedef StateManagerListenerHandler = void Function(dynamic state);

/// State manager interface
///
/// This interface defines contract for state managers
abstract class StateManagerContract {
  /// Stores registered states instances
  Map<dynamic, Cubit<dynamic>> get repository;

  /// Registers a state to state manager
  ///
  /// [predicate] is required
  void register<T extends Cubit<dynamic>>(Function predicate);

  /// Fetches a state from state manager
  T fetch<T extends Cubit<dynamic>>();

  /// Adds a listener to state
  ///
  /// [key] is an identifier for listener, this field is required
  /// [handler] is a callback that will be executed when listener is called,
  /// this field is required
  void addListener<T extends Cubit<dynamic>>({
    @required String key,
    @required StateManagerListenerHandler handler,
  });

  /// Removes listener from state manager
  Future<void> removeListener<T>([String key]);

  /// Indicates that state of type [T] has listener or not
  bool hasListener<T>(String key);

  /// Disposes the state of type [T]
  Future<void> dispose<T>();
}
