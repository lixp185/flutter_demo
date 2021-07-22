import 'package:flutter/material.dart';

class ContainerDemo extends StatefulWidget {
  @override
  _ContainerDemoState createState() => _ContainerDemoState();
}

class _ContainerDemoState extends State<ContainerDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Text("最常用的组件 包裹布局"),
    );
  }
}
