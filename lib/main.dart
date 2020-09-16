import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_sample_bloc_manager/feature_blocs/first_counter_bloc/first_counter_bloc.dart'
    as first_bloc;
import 'package:flutter_sample_bloc_manager/feature_blocs/second_counter_bloc/second_counter_bloc.dart'
    as second_bloc;

import 'package:flutter_sample_bloc_manager/bloc_manager/bloc_manager.dart';

import 'package:flutter_sample_bloc_manager/counter_page_0.dart';
import 'package:flutter_sample_bloc_manager/counter_page_1.dart';

void main() {
  BlocManager.instance.register<first_bloc.FirstCounterBloc>(
      () => first_bloc.FirstCounterBloc());
  BlocManager.instance.register<second_bloc.SecondCounterBloc>(
      () => second_bloc.SecondCounterBloc());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final first_bloc.FirstCounterBloc _counter0 =
      BlocManager.instance.fetch<first_bloc.FirstCounterBloc>();
  final second_bloc.SecondCounterBloc _counter1 =
      BlocManager.instance.fetch<second_bloc.SecondCounterBloc>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo Home Page'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    child: Text('Logout/Login'),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text('Connect/Disconnect'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            BlocProvider(
              create: (context) => _counter0,
              child: CounterPage0(
                onIncrement: () => _counter0.add(first_bloc.Increment()),
                onDecrement: () => _counter0.add(first_bloc.Decrement()),
              ),
            ),
            BlocProvider(
              create: (context) => _counter1,
              child: CounterPage1(
                onIncrement: () => _counter1.add(second_bloc.Increment()),
                onDecrement: () => _counter1.add(second_bloc.Decrement()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
