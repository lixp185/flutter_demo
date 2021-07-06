import 'package:flutter/material.dart';

class SizeBoxDemo extends StatefulWidget {
  @override
  _SizeBoxDemoState createState() => _SizeBoxDemoState();
}

class _SizeBoxDemoState extends State<SizeBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, minHeight: 50),
              child: Container(
                height: 1,
                child: DecoratedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("ConstrainedBox"),
                  ),
                  decoration: BoxDecoration(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 50,
              child: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.center,
                  child: Text("SizedBox"),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 100, maxHeight: 50),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 60, maxHeight: 100),
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text("xxx"),
                ),
              ),
              ),
            )
          ],
        ));
  }
}
