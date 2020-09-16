import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_bloc_manager/feature_blocs/first_counter_bloc/first_counter_bloc.dart';

class FirstCounterPage extends StatelessWidget {
  const FirstCounterPage({
    this.value,
    this.onIncrement,
    this.onDecrement,
    Key key,
  }) : super(key: key);

  final int value;
  final Function onIncrement;
  final Function onDecrement;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<FirstCounterBloc, FirstCounterState>(
            builder: (context, state) {
              if (state is! LogoutState) {
                return _buildLoggedIn(state);
              }

              return _buildLogout();
            },
          )),
    );
  }

  Widget _buildLoggedIn(FirstCounterState state) => Column(
        children: [
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
              children: [
                OutlineButton(
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: onIncrement,
                ),
                OutlineButton(
                  child: Text(
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

  Widget _buildLogout() => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'LOGGED OUT',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
