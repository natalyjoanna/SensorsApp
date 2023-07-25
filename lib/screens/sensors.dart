import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sensors/sensors.dart';

class sensors extends StatefulWidget {
  const sensors({super.key});

  @override
  State<sensors> createState() => _sensorsState();
}

class _sensorsState extends State<sensors> {
  late StreamSubscription _streamSubscription;
  List<double> _accelerometerValues = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = [event.x, event.y, event.z];
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acelerómetro'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Valores del acelerómetro:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'X: ${_accelerometerValues[0].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Y: ${_accelerometerValues[1].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Z: ${_accelerometerValues[2].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
