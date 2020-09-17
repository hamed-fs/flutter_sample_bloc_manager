part of 'first_counter_bloc.dart';

abstract class FirstCounterState {
  FirstCounterState({
    this.value,
    this.isEnable = true,
  });

  final int value;
  final bool isEnable;
}

class InitialState extends FirstCounterState {
  InitialState() : super(value: 0);
}

class SetCounter extends FirstCounterState {
  SetCounter(int value) : super(value: value);
}

class EnabledState extends FirstCounterState {
  EnabledState(int value) : super(value: value, isEnable: true);
}

class DisabledState extends FirstCounterState {
  DisabledState(int value) : super(value: value, isEnable: false);
}

class LogoutState extends FirstCounterState {
  LogoutState() : super();
}
