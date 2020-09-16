part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityEvent {}

class Connect extends ConnectivityEvent {}

class Disconnect extends ConnectivityEvent {}
