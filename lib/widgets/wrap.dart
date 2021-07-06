import 'package:flutter/material.dart';

/// 自适应组件
class WrapWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WrapState();
  }
}

class WrapState extends State<WrapWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text("色谱", style: TextStyle(color: Colors.blue)),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("气相色谱", style: TextStyle(color: Colors.blue)),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("仪器信息网", style: TextStyle(color: Colors.blue)),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("我要测", style: TextStyle(color: Colors.blue)),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("更多标签xx", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
    );
  }
}
