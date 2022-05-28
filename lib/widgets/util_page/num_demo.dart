import 'package:flutter/material.dart';
import 'dart:math';

class NumDemo extends StatefulWidget {
  const NumDemo({Key? key}) : super(key: key);

  @override
  _NumDemoState createState() => _NumDemoState();
}

class _NumDemoState extends State<NumDemo> {
  List<String> result = [];

  @override
  void initState() {
    super.initState();
    var a = -11;
    var b = 3;

    setState(() {
      result.add((a % b).toString());
      result.add((a ~/ b).toString());
      result.add(1.2.round().toString());
      result.add("${(3 / 2).floor().toString()}");
      result.add("${asin(1)}");
      result.add("${num.tryParse("123www")}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Text(result[index]);
        },
        itemCount: result.length,
      ),
    );
  }
}
