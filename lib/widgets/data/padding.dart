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
            Container(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("上下内边距"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("左右内边距"),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("下内边距"),
                ))
          ],
        ),
      ),
    );
  }
}

/// 内边距
