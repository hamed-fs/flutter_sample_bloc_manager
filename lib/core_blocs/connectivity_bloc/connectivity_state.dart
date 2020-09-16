part of 'connectivity_bloc.dart';

@immutable
abstract class ConnectivityState {}

class ConnectedState extends ConnectivityState {}

class DisconnectedState extends ConnectivityState {}
