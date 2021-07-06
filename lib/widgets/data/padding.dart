import 'package:flutter/material.dart';

class PaddingDemo extends StatefulWidget {
  @override
  _PaddingDemoState createState() => _PaddingDemoState();
}

class _PaddingDemoState extends State<PaddingDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("text1"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("text1"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("text1"),
            )
          ],
        ),
      ),
    );
  }
}
