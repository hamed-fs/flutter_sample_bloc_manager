import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_sample_bloc_manager/base_bloc.dart';

part 'first_counter_event.dart';
part 'first_counter_state.dart';

class FirstCounterBloc extends Bloc<FirstCounterEvent, FirstCounterState>
    implements BaseBloc {
  FirstCounterBloc() : super(InitialState());

  @override
  Stream<FirstCounterState> mapEventToState(
    FirstCounterEvent event,
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
