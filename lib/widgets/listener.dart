import 'package:flutter/material.dart';

class ListenerWidgetDemo extends StatefulWidget {
  @override
  _ListenerWidgetDemoState createState() => _ListenerWidgetDemoState();
}

class _ListenerWidgetDemoState extends State<ListenerWidgetDemo> {
  //定义一个状态，保存当前指针位置
  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
        width: 300.0,
        height: 150.0,
        child: Text(_event?.toString() ?? "",
            style: TextStyle(color: Colors.white)),
      ),
      onPointerDown: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerCancel: (event) {
        setState(() {
          _event = event;
        });
      },
    );
  }
}
