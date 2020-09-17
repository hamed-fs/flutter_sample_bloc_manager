import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';

import 'base_state.dart';
import 'state_manager.dart';
import 'state_manager_contract.dart';

part 'dispatcher_event.dart';

class StateDispatcher {
  static final String authBlocListenerKey = 'AuthBlocListener';
  static final String connectivityBlocListenerKey = 'ConnectivityBlocListener';

  static final StateManagerContract _stateManager = StateManager.instance;

  static void initialize() {
    if (!_stateManager.hasListener<AuthBloc>(authBlocListenerKey)) {
      _stateManager.addListener<AuthBloc>(
        key: authBlocListenerKey,
        handler: (dynamic state) {
          if (state is LoginState) {
            _dispatcher(_DispatcherEvent.login);
          } else if (state is LogoutState) {
            _dispatcher(_DispatcherEvent.logout);
          }
        },
      );
    }

    if (!_stateManager
        .hasListener<ConnectivityBloc>(connectivityBlocListenerKey)) {
      _stateManager.addListener<ConnectivityBloc>(
        key: connectivityBlocListenerKey,
        handler: (dynamic state) {
          if (state is ConnectedState) {
            _dispatcher(_DispatcherEvent.enable);
          } else if (state is DisconnectedState) {
            _dispatcher(_DispatcherEvent.disable);
          }
        },
      );
    }
  }

  static void _dispatcher(_DispatcherEvent event) {
    _stateManager.repository.forEach((key, value) {
      if (value is BaseState) {
        BaseState state = value as BaseState;

        switch (event) {
          case _DispatcherEvent.enable:
            state.enable();
            break;
          case _DispatcherEvent.disable:
            state.disable();
            break;
          case _DispatcherEvent.login:
            state.login();
            break;
          case _DispatcherEvent.logout:
            state.logout();
            break;
        }
      }
    });
  }
}
