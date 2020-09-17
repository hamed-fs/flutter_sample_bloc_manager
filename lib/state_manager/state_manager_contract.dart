import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

typedef StateManagerListenerHandler = void Function(dynamic state);

abstract class StateManagerContract {
  Map<dynamic, Cubit<dynamic>> get repository;

  void register<T extends Cubit<dynamic>>(Function predicate);

  T fetch<T extends Cubit<dynamic>>();

  void addListener<T extends Cubit<dynamic>>({
    @required String key,
    @required StateManagerListenerHandler handler,
  });

  Future<void> removeListener<T>([String key]);

  bool hasListener<T>(String key);

  Future<void> dispose<T>();
}
