part of 'first_counter_bloc.dart';

abstract class FirstCounterState {
  final int value;

  FirstCounterState({this.value});
}

class InitialState extends FirstCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends FirstCounterState {
  int value;

  SetCounter(this.value) : super(value: value);
}

class DisabledState extends FirstCounterState {
  DisabledState() : super();
}

class LogoutState extends FirstCounterState {
  LogoutState() : super();
}
