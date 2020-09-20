import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_sample_bloc_manager/feature_blocs/first_counter_bloc/first_counter_bloc.dart'
    as first_bloc;
import 'package:flutter_sample_bloc_manager/feature_blocs/second_counter_bloc/second_counter_bloc.dart'
    as second_bloc;
import 'package:flutter_sample_bloc_manager/pages/first_counter_page.dart';
import 'package:flutter_sample_bloc_manager/pages/second_counter_page.dart';
import 'package:flutter_sample_bloc_manager/state_manager/event_dispatcher.dart';
import 'package:flutter_sample_bloc_manager/state_manager/state_manager.dart';

void main() {
  _registerBlocs();

  runApp(MyApp());
}

void _registerBlocs() {
  StateManager.instance.register<ConnectivityBloc>(() => ConnectivityBloc());
  StateManager.instance.register<AuthBloc>(() => AuthBloc());

  EventDispatcher(StateManager.instance).initialize();

  StateManager.instance.register<first_bloc.FirstCounterBloc>(
      () => first_bloc.FirstCounterBloc());
  StateManager.instance.register<second_bloc.SecondCounterBloc>(
      () => second_bloc.SecondCounterBloc());
}

class MyApp extends StatelessWidget {
  final ConnectivityBloc _connectivityBloc =
      StateManager.instance.fetch<ConnectivityBloc>();
  final AuthBloc _authBloc = StateManager.instance.fetch<AuthBloc>();

  final first_bloc.FirstCounterBloc _firstCounterBloc =
      StateManager.instance.fetch<first_bloc.FirstCounterBloc>();
  final second_bloc.SecondCounterBloc _secondCounterBloc =
      StateManager.instance.fetch<second_bloc.SecondCounterBloc>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Bloc Manager Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text('Flutter Bloc Manager Demo'),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildAuthButton(),
                    _buildConnectivityButton(),
                  ],
                ),
              ),
              BlocProvider<first_bloc.FirstCounterBloc>(
                create: (BuildContext context) => _firstCounterBloc,
                child: FirstCounterPage(
                  onIncrement: () =>
                      _firstCounterBloc.add(first_bloc.Increment()),
                  onDecrement: () =>
                      _firstCounterBloc.add(first_bloc.Decrement()),
                ),
              ),
              BlocProvider<second_bloc.SecondCounterBloc>(
                create: (BuildContext context) => _secondCounterBloc,
                child: SecondCounterPage(
                  onIncrement: () =>
                      _secondCounterBloc.add(second_bloc.Increment()),
                  onDecrement: () =>
                      _secondCounterBloc.add(second_bloc.Decrement()),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildConnectivityButton() => OutlineButton(
        child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
          cubit: _connectivityBloc,
          builder: (BuildContext context, ConnectivityState state) => Text(
            state is ConnectedState ? 'Disconnect' : 'Connect',
          ),
        ),
        onPressed: () => _connectivityBloc.add(
          _connectivityBloc.state is ConnectedState ? Disconnect() : Connect(),
        ),
      );

  Widget _buildAuthButton() => OutlineButton(
        child: BlocBuilder<AuthBloc, AuthorizeState>(
          cubit: _authBloc,
          builder: (BuildContext context, AuthorizeState state) => Text(
            state is LoginState ? 'Logout' : 'Login',
          ),
        ),
        onPressed: () => _authBloc.add(
          _authBloc.state is LoginState ? Logout() : Login(),
        ),
      );
}
