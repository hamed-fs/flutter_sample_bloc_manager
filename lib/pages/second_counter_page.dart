import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_bloc_manager/feature_blocs/second_counter_bloc/second_counter_bloc.dart';

class SecondCounterPage extends StatelessWidget {
  const SecondCounterPage({
    this.value,
    this.onIncrement,
    this.onDecrement,
    Key key,
  }) : super(key: key);

  final int value;
  final Function onIncrement;
  final Function onDecrement;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<SecondCounterBloc, SecondCounterState>(
            builder: (BuildContext context, SecondCounterState state) {
              if (state is! LogoutState) {
                return _buildLoggedIn(state);
              }

              return _buildLogout();
            },
          ),
        ),
      );

  Widget _buildLoggedIn(SecondCounterState state) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              state is DisabledState ? 'DISCONNECTED.' : '${state.value}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: state is DisabledState ? Colors.red : Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlineButton(
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onIncrement,
                ),
                OutlineButton(
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onDecrement,
                )
              ],
            ),
          )
        ],
      );

  Widget _buildLogout() => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'LOGGED OUT',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
