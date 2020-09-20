import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_listener_contracts/auth_state_listener.dart';

part 'first_counter_event.dart';
part 'first_counter_state.dart';

class FirstCounterBloc extends Bloc<FirstCounterEvent, FirstCounterState>
    implements AuthStateListener {
  FirstCounterBloc() : super(LogoutState());

  @override
  Stream<FirstCounterState> mapEventToState(
    FirstCounterEvent event,
  ) async* {
    if (event is Increment) {
      yield SetCounter(state.value + 1);
    } else if (event is Decrement) {
      yield SetCounter(state.value - 1);
    } else if (event is Login) {
      yield InitialState();
    } else if (event is Logout) {
      yield LogoutState();
    } else if (event is Enable) {
      yield EnabledState(state.value ?? 0);
    } else if (event is Disable) {
      yield DisabledState(state.value ?? 0);
    }
  }

  @override
  void onLogin() => add(Login());

  @override
  void onLogout() => add(Logout());
}
