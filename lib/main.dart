import 'package:flutter/material.dart';
import 'package:flutter_sample_bloc_manager/counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
              CounterPage(
                onIncrement: () {},
                onDecrement: () {},
              ),
              CounterPage(
                onIncrement: () {},
                onDecrement: () {},
              ),
              CounterPage(
                onIncrement: () {},
                onDecrement: () {},
              ),
            ],
          ),
        ));
  }
}
