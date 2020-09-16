part of 'first_counter_bloc.dart';

abstract class FirstCounterEvent {}

class Increment extends FirstCounterEvent {}

class Decrement extends FirstCounterEvent {}

class Login extends FirstCounterEvent {}

class Logout extends FirstCounterEvent {}

class Enable extends FirstCounterEvent {}

class Disable extends FirstCounterEvent {}
