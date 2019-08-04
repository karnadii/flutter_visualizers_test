import 'package:flutter/material.dart';
import 'package:radio_suka/blocs/main.dart';
import 'package:radio_suka/screens/home.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Injector(
        models: [() => MainBloc()],
        builder: (_, __) => HomeScreen(),
      )
    );
  }
}