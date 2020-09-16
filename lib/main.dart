import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_bloc_manager/bloc_manager/bloc_manager.dart';
import 'package:flutter_sample_bloc_manager/bloc_manager/event_dispatcher.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_sample_bloc_manager/core_blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_sample_bloc_manager/pages/first_counter_page.dart';
import 'package:flutter_sample_bloc_manager/feature_blocs/first_counter_bloc/first_counter_bloc.dart'
    as first_bloc;
import 'package:flutter_sample_bloc_manager/feature_blocs/second_counter_bloc/second_counter_bloc.dart'
    as second_bloc;
import 'package:flutter_sample_bloc_manager/pages/second_counter_page.dart';

void main() {
  _registerBlocs();

  runApp(MyApp());
}

void _registerBlocs() {
  BlocManager.instance.register<ConnectivityBloc>(() => ConnectivityBloc());
  BlocManager.instance.register<AuthBloc>(() => AuthBloc());

  EventDispatcher.initialize();

  BlocManager.instance.register<first_bloc.FirstCounterBloc>(
      () => first_bloc.FirstCounterBloc());
  BlocManager.instance.register<second_bloc.SecondCounterBloc>(
      () => second_bloc.SecondCounterBloc());
}

class MyApp extends StatelessWidget {
  final ConnectivityBloc _connectivityBloc =
      BlocManager.instance.fetch<ConnectivityBloc>();
  final AuthBloc _authBloc = BlocManager.instance.fetch<AuthBloc>();

  final first_bloc.FirstCounterBloc _firstCounterBloc =
      BlocManager.instance.fetch<first_bloc.FirstCounterBloc>();
  final second_bloc.SecondCounterBloc _secondCounterBloc =
      BlocManager.instance.fetch<second_bloc.SecondCounterBloc>();

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
            title: Text('Flutter Bloc Manager Demo'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildAuthButton(),
                    _buildConnectivityButton(),
                  ],
                ),
              ),
              BlocProvider(
                create: (context) => _firstCounterBloc,
                child: FirstCounterPage(
                  onIncrement: () =>
                      _firstCounterBloc.add(first_bloc.Increment()),
                  onDecrement: () =>
                      _firstCounterBloc.add(first_bloc.Decrement()),
                ),
              ),
              BlocProvider(
                create: (context) => _secondCounterBloc,
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
          builder: (context, state) => Text(
            state is ConnectedState ? 'Disconnect' : 'Connect',
          ),
        ),
        onPressed: () => _connectivityBloc.add(
          _connectivityBloc.state is ConnectedState ? Disconnect() : Connect(),
        ),
      );

  Widget _buildAuthButton() => OutlineButton(
        child: BlocBuilder<AuthBloc, AuthState>(
          cubit: _authBloc,
          builder: (context, state) => Text(
            state is LoginState ? 'Logout' : 'Login',
          ),
        ),
        onPressed: () => _authBloc.add(
          _authBloc.state is LoginState ? Logout() : Login(),
        ),
      );
}
