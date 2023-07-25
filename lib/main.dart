import 'package:flutter/material.dart';
import 'package:sensorsapp/screens/sensors.dart';
import 'package:sensors/sensors.dart';
import 'package:sensorsapp/screens/sensors2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Sensors2(),
    );
  }
}
