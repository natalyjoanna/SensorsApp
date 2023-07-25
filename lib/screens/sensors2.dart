import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sensors/sensors.dart';

class Sensors2 extends StatefulWidget {
  const Sensors2({super.key});

  @override
  State<Sensors2> createState() => _Sensors2State();
}

class _Sensors2State extends State<Sensors2> {
  double _yAccel = 0.0;
  final double _threshold = 5.0;
  int _stepCount = 0;
  double _prevYAccel = 0.0;
  bool _isPositive = true;
  late Color containerColor;
  String _image = "";

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _yAccel = event.y;
        _onAccelerometerChanged(_yAccel);

        if (_stepCount < 5) {
          containerColor = Colors.green;
          _image = 'assets/per1.png';
        } else if (_stepCount > 5 && _stepCount < 10) {
          containerColor = Colors.amber;
          _image = 'assets/per2.png';
        } else if (_stepCount > 10) {
          containerColor = Colors.red;
          _image = 'assets/per3.png';
        }
      });
    });
  }

  void _onAccelerometerChanged(double yAccel) {
    if (_prevYAccel == 0.0) {
      _prevYAccel = yAccel;
      return;
    }

    if (_isPositive &&
        yAccel < _prevYAccel &&
        (_prevYAccel - yAccel) > _threshold) {
      setState(() {
        _stepCount++;
      });
      _isPositive = false;
    } else if (!_isPositive &&
        yAccel > _prevYAccel &&
        (yAccel - _prevYAccel) > _threshold) {
      _isPositive = true;
    }

    _prevYAccel = yAccel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Container(
        color: containerColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Valores del acelerómetro:',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Y: ${_stepCount.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                onPressed: () {
                  _stepCount = 0;
                },
                child: const Text('Reiniciar'),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Image.asset(
                _image,
                height: 200,
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
