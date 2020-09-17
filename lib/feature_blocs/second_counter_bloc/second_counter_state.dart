part of 'second_counter_bloc.dart';

abstract class SecondCounterState {
  SecondCounterState({
    this.value,
    this.isEnable = true,
  });

  final int value;
  final bool isEnable;
}

class InitialState extends SecondCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends SecondCounterState {
  SetCounter(int value) : super(value: value);
}

class EnabledState extends SecondCounterState {
  EnabledState(int value) : super(value: value, isEnable: true);
}

class DisabledState extends SecondCounterState {
  DisabledState(int value) : super(value: value, isEnable: false);
}

class LogoutState extends SecondCounterState {
  LogoutState() : super();
}
