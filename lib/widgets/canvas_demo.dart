
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/qp_widget.dart';

/// 绘制组件
class CanvasDemo extends StatefulWidget {
  @override
  _CanvasState createState() => _CanvasState();
}

class _CanvasState extends State<CanvasDemo> {
  var qoSize = QpSize.thirteen;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        padding: EdgeInsets.only(top: 50, left: 0),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            QpWidget(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 1.2,
              qpSize: qoSize,
            ),
          ],
        ));
  }
}
