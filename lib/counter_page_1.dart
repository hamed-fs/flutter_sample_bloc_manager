import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature_blocs/second_counter_bloc/second_counter_bloc.dart';

class CounterPage1 extends StatelessWidget {
  const CounterPage1({
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
        child: Column(
          children: [
            BlocBuilder<SecondCounterBloc, SecondCounterState>(
              builder: (context, state) {
                return Text(
                  '${state.value}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: onIncrement,
                  ),
                  RaisedButton(
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
        ),
      ),
    );
  }
}
