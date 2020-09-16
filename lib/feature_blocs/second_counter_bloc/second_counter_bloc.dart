import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_sample_bloc_manager/base_bloc.dart';

part 'second_counter_event.dart';
part 'second_counter_state.dart';

class SecondCounterBloc extends Bloc<SecondCounterEvent, SecondCounterState>
    implements BaseBloc {
  SecondCounterBloc() : super(InitialState());

  @override
  Stream<SecondCounterState> mapEventToState(
    SecondCounterEvent event,
  ) async* {
    if (event is Increment) {
      yield SetCounter(state.value + 1);
    } else if (event is Decrement) {
      yield SetCounter(state.value - 1);
    }
  }

  @override
  void enable() {
    // TODO: implement enable
  }

  @override
  void disable() {
    // TODO: implement disable
  }

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void logout() {
    // TODO: implement logout
  }
}
