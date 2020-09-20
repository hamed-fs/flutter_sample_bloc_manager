part of 'auth_bloc.dart';

@immutable
abstract class AuthorizeState {}

class LoginState extends AuthorizeState {}

class LogoutState extends AuthorizeState {}
