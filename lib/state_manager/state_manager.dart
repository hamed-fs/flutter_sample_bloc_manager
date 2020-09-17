import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'state_manager_contract.dart';
import 'state_manager_exception.dart';

class StateManager extends StateManagerContract {
  factory StateManager() => _instance;

  StateManager._internal();

  static final StateManager _instance = StateManager._internal();

  static StateManager get instance => _instance;

  final Map<dynamic, Function> _factories = <dynamic, Function>{};
  final Map<dynamic, Cubit<dynamic>> _repository = <dynamic, Cubit<dynamic>>{};
  final Map<String, StreamSubscription<dynamic>> _subscriptions =
      <String, StreamSubscription<dynamic>>{};

  @override
  Map<dynamic, Cubit<dynamic>> get repository => _repository;

  @override
  void register<T extends Cubit<dynamic>>(Function predicate) =>
      _factories[T] = predicate;

  @override
  T fetch<T extends Cubit<dynamic>>() => _repository.containsKey(T)
      ? _repository[T]
      : _factories.containsKey(T)
          ? _invoke<T>()
          : throw StateManagerException(
              message: _getCouldNotFindObjectErrorMessage(T),
            );

  @override
  void addListener<T extends Cubit<dynamic>>({
    @required String key,
    @required StateManagerListenerHandler handler,
  }) {
    final String objectKey = _getKey<T>(key);

    if (_subscriptions.containsKey(objectKey)) {
      return;
    }

    final T state = fetch<T>();

    if (state == null) {
      throw StateManagerException(
        message: _getCouldNotFindObjectErrorMessage(T),
      );
    }

    _subscriptions[objectKey] = state.listen(
      (dynamic state) => handler(state),
    );
  }

  @override
  Future<void> removeListener<T>([String key = '']) async {
    final String objectKey = _getKey<T>(key);

    _subscriptions.keys
        .where(
      (String itemKey) =>
          key.isEmpty ? itemKey.contains(objectKey) : itemKey == objectKey,
    )
        .forEach((String key) async {
      await _subscriptions[key].cancel();
      _subscriptions.remove(key);
    });
  }

  @override
  Future<void> dispose<T>() async {
    if (_repository.containsKey(T)) {
      await _repository[T].close();
      _repository.remove(T);

      await removeListener<T>();
    }
  }

  @override
  bool hasListener<T>(String key) =>
      _subscriptions.containsKey(_getKey<T>(key));

  Bloc<dynamic, dynamic> _invoke<T>() => _repository[T] = _factories[T]();

  static String _getKey<T>(String key) => '$T::$key';

  static String _getCouldNotFindObjectErrorMessage(dynamic type) =>
      'Could not find <$type> object, use register method to add it to state manager.';
}
