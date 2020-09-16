import 'package:flutter_sample_bloc_manager/bloc_manager/base_bloc.dart';
import 'package:flutter_sample_bloc_manager/bloc_manager/bloc_manager.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';

const String authBlocListenerKey = 'AuthBlocListener';
const String connectivityBlocListenerKey = 'ConnectivityBlocListener';

class EventDispatcher {
  static final BlocManagerContract blocManager = BlocManager.instance;

  static void initialize() {
    if (!blocManager.hasListener<AuthBloc>(authBlocListenerKey)) {
      blocManager.addListener<AuthBloc>(
        key: authBlocListenerKey,
        handler: (dynamic state) {
          if (state is LoginState) {
            _dispatcher(DispatcherEvent.login);
          } else if (state is LogoutState) {
            _dispatcher(DispatcherEvent.logout);
          }
        },
      );
    }

    if (!blocManager
        .hasListener<ConnectivityBloc>(connectivityBlocListenerKey)) {
      blocManager.addListener<ConnectivityBloc>(
        key: connectivityBlocListenerKey,
        handler: (dynamic state) {
          if (state is ConnectedState) {
            _dispatcher(DispatcherEvent.enable);
          } else if (state is DisconnectedState) {
            _dispatcher(DispatcherEvent.disable);
          }
        },
      );
    }
  }

  static void _dispatcher(DispatcherEvent event) {
    blocManager.repository.forEach((key, value) {
      if (value is BaseBloc) {
        BaseBloc bloc = value as BaseBloc;

        switch (event) {
          case DispatcherEvent.enable:
            bloc.enable();
            break;
          case DispatcherEvent.disable:
            bloc.disable();
            break;
          case DispatcherEvent.login:
            bloc.login();
            break;
          case DispatcherEvent.logout:
            bloc.logout();
            break;
        }
      }
    });
  }
}

enum DispatcherEvent {
  enable,
  disable,
  login,
  logout,
}
