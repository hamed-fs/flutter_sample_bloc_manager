part of 'second_counter_bloc.dart';

abstract class SecondCounterState {
  final int value;
  final bool isEnable;

  SecondCounterState({
    this.value,
    this.isEnable = true,
  });
}

class InitialState extends SecondCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends SecondCounterState {
  int value;

  SetCounter(this.value) : super(value: value);
}

class EnabledState extends SecondCounterState {
  final int value;

  EnabledState(this.value) : super(value: value, isEnable: true);
}

class DisabledState extends SecondCounterState {
  final int value;

  DisabledState(this.value) : super(value: value, isEnable: false);
}

class LogoutState extends SecondCounterState {
  LogoutState() : super();
}
