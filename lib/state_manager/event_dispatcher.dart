// ignore_for_file: avoid_as

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_listener_contracts/auth_state_listener.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_listener_contracts/connectivity_state_listener.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_manager_contract.dart';

const String authBlocListenerKey = 'AuthBlocListener';
const String connectivityBlocListenerKey = 'ConnectivityBlocListener';

/// Event dispatcher for dispatching common events
class EventDispatcher {
  /// Initializes event dispatcher
  EventDispatcher(this.stateManager);

  /// State manager
  final StateManagerContract stateManager;

  void initialize() {
    if (!stateManager
        .hasListener<ConnectivityBloc>(connectivityBlocListenerKey)) {
      stateManager.addListener<ConnectivityBloc>(
        key: connectivityBlocListenerKey,
        handler: (dynamic state) => _dispatcher(state),
      );
    }

    if (!stateManager.hasListener<AuthBloc>(authBlocListenerKey)) {
      stateManager.addListener<AuthBloc>(
        key: authBlocListenerKey,
        handler: (dynamic state) => _dispatcher(state),
      );
    }
  }

  // TODO(hamed): replace with real state
  void _dispatcher(dynamic state) {
    stateManager.repository.forEach((dynamic key, Cubit<dynamic> value) {
      if (value is AuthStateListener) {
        final AuthStateListener listener = value as AuthStateListener;

        if (state is LoginState) {
          listener.onLogin();
        } else if (state is LogoutState) {
          listener.onLogout();
        }
      }

      if (value is ConnectivityStateListener) {
        final ConnectivityStateListener listener =
            value as ConnectivityStateListener;

        if (state is ConnectedState) {
          listener.onConnect();
        } else if (state is DisconnectedState) {
          listener.onDisconnect();
        }
      }
    });
  }
}
