import 'package:flutter_sample_bloc_manager/bloc_manager/base_bloc.dart';
import 'package:flutter_sample_bloc_manager/bloc_manager/bloc_manager.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';

part 'dispatcher_event.dart';

class BlocDispatcher {
  static final String authBlocListenerKey = 'AuthBlocListener';
  static final String connectivityBlocListenerKey = 'ConnectivityBlocListener';

  static final BlocManagerContract _blocManager = BlocManager.instance;

  static void initialize() {
    if (!_blocManager.hasListener<AuthBloc>(authBlocListenerKey)) {
      _blocManager.addListener<AuthBloc>(
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

    if (!_blocManager
        .hasListener<ConnectivityBloc>(connectivityBlocListenerKey)) {
      _blocManager.addListener<ConnectivityBloc>(
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
    _blocManager.repository.forEach((key, value) {
      if (value is BaseBloc) {
        BaseBloc bloc = value as BaseBloc;

        switch (event) {
          case _DispatcherEvent.enable:
            bloc.enable();
            break;
          case _DispatcherEvent.disable:
            bloc.disable();
            break;
          case _DispatcherEvent.login:
            bloc.login();
            break;
          case _DispatcherEvent.logout:
            bloc.logout();
            break;
        }
      }
    });
  }
}
