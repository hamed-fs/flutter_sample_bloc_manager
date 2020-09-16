part of 'first_counter_bloc.dart';

abstract class FirstCounterState {
  final int value;
  final bool isEnable;

  FirstCounterState({
    this.value,
    this.isEnable = true,
  });
}

class InitialState extends FirstCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends FirstCounterState {
  int value;

  SetCounter(this.value) : super(value: value);
}

class EnabledState extends FirstCounterState {
  final int value;

  EnabledState(this.value) : super(value: value, isEnable: true);
}

class DisabledState extends FirstCounterState {
  final int value;

  DisabledState(this.value) : super(value: value, isEnable: false);
}

class LogoutState extends FirstCounterState {
  LogoutState() : super();
}
