import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yht_meeting/widgets/qp_widget.dart';

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
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qoSize = QpSize.nine;
                      });
                    },
                    child: Text("9路")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qoSize = QpSize.thirteen;
                      });
                    },
                    child: Text("13路")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        qoSize = QpSize.nineteen;
                      });
                    },
                    child: Text("19路"))
              ],
            )
          ],
        ));
  }
}
