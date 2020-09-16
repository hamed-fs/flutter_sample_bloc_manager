part of 'second_counter_bloc.dart';

abstract class SecondCounterState {
  final int value;

  SecondCounterState({this.value});
}

class InitialState extends SecondCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends SecondCounterState {
  int value;

  SetCounter(this.value) : super(value: value);
}

class DisabledState extends SecondCounterState {
  DisabledState() : super();
}

class LogoutState extends SecondCounterState {
  LogoutState() : super();
}
