import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'bloc_manager_exception.dart';

typedef BlocManagerListenerHandler = void Function(dynamic state);

abstract class BlocManagerContract {
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate);

  T fetch<T extends Bloc<dynamic, dynamic>>();

  void addListener<T extends Bloc<dynamic, dynamic>>({
    @required String key,
    @required BlocManagerListenerHandler handler,
  });

  Future<void> removeListener<T>([String key]);

  Future<void> dispose<T>();
}

class BlocManager extends BlocManagerContract {
  factory BlocManager() => _instance;

  BlocManager._internal();

  static final BlocManager _instance = BlocManager._internal();

  static BlocManager get instance => _instance;

  final Map<dynamic, Function> _factories = <dynamic, Function>{};
  final Map<dynamic, Bloc<dynamic, dynamic>> _repository =
      <dynamic, Bloc<dynamic, dynamic>>{};
  final Map<String, StreamSubscription<dynamic>> _subscriptions =
      <String, StreamSubscription<dynamic>>{};

  Map<dynamic, Bloc<dynamic, dynamic>> get repository => _repository;

  @override
  void register<T extends Bloc<dynamic, dynamic>>(Function predicate) =>
      _factories[T] = predicate;

  @override
  T fetch<T extends Bloc<dynamic, dynamic>>() => _repository.containsKey(T)
      ? _repository[T]
      : _factories.containsKey(T)
          ? _invoke<T>()
          : throw BlocManagerException(
              message: _getCouldNotFindObjectErrorMessage(T),
            );

  @override
  void addListener<T extends Bloc<dynamic, dynamic>>({
    @required String key,
    @required BlocManagerListenerHandler handler,
  }) {
    final String objectKey = _getKey(type: T, key: key);

    if (_subscriptions.containsKey(objectKey)) {
      return;
    }

    final T bloc = fetch<T>();

    if (bloc == null) {
      throw BlocManagerException(
        message: _getCouldNotFindObjectErrorMessage(T),
      );
    }

    _subscriptions[objectKey] = bloc.listen(
      (dynamic state) => handler(state),
    );
  }

  @override
  Future<void> removeListener<T>([String key = '']) async {
    final String objectKey = _getKey(type: T, key: key);

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

  Bloc<dynamic, dynamic> _invoke<T>() => _repository[T] = _factories[T]();

  static String _getKey({@required dynamic type, String key}) => '$type::$key';

  static String _getCouldNotFindObjectErrorMessage(dynamic type) =>
      'Could not find <$type> object, use register method to add it to bloc manager.';
}
