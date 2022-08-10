import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/canvas/wq_qp2.dart';

/// 绘制组件
class CanvasDemo extends StatefulWidget {
  @override
  _CanvasState createState() => _CanvasState();
}

class _CanvasState extends State<CanvasDemo> {
  int qpSize = 19;
  bool isTry = false;
  bool showNum = true;
  bool isClean = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        // padding: EdgeInsets.only(top: 40, left: 100),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClean = true;
                          qpSize = 9;
                        });
                      },
                      child: Text("9路")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClean = true;
                          qpSize = 13;
                        });
                      },
                      child: Text("13路")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClean = true;
                          qpSize = 19;
                        });
                      },
                      child: Text("19路")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClean = false;
                          isTry = !isTry;
                        });
                      },
                      child: Text(isTry ? "关闭试下" : "开启试下")),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isClean = false;
                          showNum = !showNum;
                        });
                      },
                      child: Text(showNum ? "关闭手数" : "显示手数")),
                ],
              ),
            ),
            WqQp(
              size: MediaQuery.of(context).size.width,
              qpSize: qpSize,
              isOpenTry: isTry,
              isShowNum: showNum,
              isCleanQP: isClean,
            )
          ],
        ));
  }
}

// QpWidget(
//   width: MediaQuery.of(context).size.width / 1.2,
//   height: MediaQuery.of(context).size.width / 1.2,
//   qpSize: qpSize,
// ),
