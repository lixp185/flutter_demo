import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/scheduler.dart';

class NumDemo extends StatefulWidget {
  const NumDemo({Key? key}) : super(key: key);

  @override
  _NumDemoState createState() => _NumDemoState();
}

class _NumDemoState extends State<NumDemo> {
  List<String> result = [];
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      print('elapsed --- $elapsed');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_ticker.isTicking) {
          _ticker.stop();
        } else {
          _ticker.start();
        }
      },
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
