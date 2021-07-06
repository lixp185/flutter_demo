import 'package:flutter/material.dart';

class StackWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StackState();
  }
}

class StackState extends State<StackWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [

            Container(
              color: Colors.blue,
            ),
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.blue[800],
            ),
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.blue[700],
            ),
            Container(
              margin: EdgeInsets.all(30),
              color: Colors.blue[600],
            ),
            Container(
              margin: EdgeInsets.all(40),
              color: Colors.blue[500],
            ),
            Container(
              margin: EdgeInsets.all(50),
              color: Colors.blue[400],
            ),
            Container(
              margin: EdgeInsets.all(60),
              color: Colors.blue[300],
            ),
            Container(
              margin: EdgeInsets.all(70),
              color: Colors.blue[200],
            ),
            Text("default"),
            Positioned(
              left: 10,
              child: Text("left"),
            ),
            Positioned(
              top: 10,
              child: Text("top"),
            ),
            Positioned(
              right: 10,
              child: Text("right"),
            ),
            Positioned(
              bottom: 10,
              child: Text("bottom"),
            ),
          ],
        ));
  }
}
