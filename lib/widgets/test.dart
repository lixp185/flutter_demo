import 'package:flutter/material.dart';

// 定义一个Hello函数 相当于原生接口中的函数
typedef Hello = void Function(String, String);

class Test extends StatefulWidget {
  final Hello? hello;

  const Test({Key? key, this.hello}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    //调用
    getName();
  }

  dynamic getName() {
    // 具体实现函数的地方
    widget.hello?.call("老李", "李云龙");
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
