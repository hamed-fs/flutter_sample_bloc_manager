part of 'second_counter_bloc.dart';

abstract class SecondCounterEvent {}

class Increment extends SecondCounterEvent {}

class Decrement extends SecondCounterEvent {}

class Login extends SecondCounterEvent {}

class Logout extends SecondCounterEvent {}

class Enable extends SecondCounterEvent {}

class Disable extends SecondCounterEvent {}
