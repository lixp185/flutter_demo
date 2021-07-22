import 'package:flutter/material.dart';

import 'wq_qp.dart';

/// 棋盘
class QpWidget extends StatefulWidget {
  // 落子
  final QpSize qpSize; //  9路 19路棋盘
  final double width; //棋盘宽
  final double height; //棋盘高
  const QpWidget(
      {Key? key, this.qpSize = QpSize.nineteen, required this.width, required this.height})
      : super(key: key);

  @override
  _QpWidgetState createState() => _QpWidgetState();
}

enum QpSize {
  nine, //9路
  thirteen, //13路
  nineteen // 19路
}

class _QpWidgetState extends State<QpWidget> {
  late Offset offset; // 坐标系
  List<Offset> offsetList = [];

  // 横轴坐标
  List<String> zmList = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "R",
    "S",
    "T",
  ];

  // 纵轴坐标
  List<String> numList = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
  ];

  late int qpWg; //棋盘网络路
  late double qzSize; //棋子大小
  @override
  void initState() {
    super.initState();
    if (widget.qpSize == QpSize.nine) {
      // 9路
      qpWg = 8;
      qzSize = 15;
    } else if (widget.qpSize == QpSize.thirteen) {
      // 13路
      qpWg = 12;
      qzSize = 10;
    } else if (widget.qpSize == QpSize.nineteen) {
      // 19路
      qpWg = 18;
      qzSize = 7;
    }

    for (var i = qpWg + 1; i < 19; i++) {
      numList.removeLast();
      zmList.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 1.3,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: widget.height + widget.height / qpWg,
              width: 15,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    height: widget.height / qpWg, //纵轴坐标大小
                    alignment: Alignment.topCenter,
                    child: Text(
                      numList[numList.length - 1 - index],
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
                itemCount: numList.length,
              ),
            ),
            left: 10,
          ),
          Positioned(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: GestureDetector(
                    child: WqQp(
                      width: widget.width,
                      height: widget.height,
                      qpWg: qpWg,
                      qzSize: qzSize,
                      offsetList: offsetList,
                    ),
                    onPanDown: (e) {
                      var dx = e.localPosition.dx;
                      var dy = e.localPosition.dy;
                      var eW = widget.width / qpWg; // 横轴坐标
                      var eH = widget.height / qpWg; // 纵轴坐标
                      if (dx < eW) {
                        //点击横轴小于最小横轴坐标
                        dx = 0;
                      } else {
                        if (dx % eW < eW / 2) {
                          dx = dx - dx % eW;
                        } else {
                          dx = dx + (eW - (dx % eW));
                        }
                      }
                      if (dy < eH) {
                        dy = 0;
                      } else {
                        if (dy % eW < eH / 2) {
                          dy = dy - dy % eH;
                        } else {
                          dy = dy + (eH - (dy % eH));
                        }
                      }
                      for (var i = 0; i < offsetList.length; i++) {
                        var x = offsetList[i].dx;
                        var y = offsetList[i].dy;
                        if (dx == x && dy == y) {
                          //说明这个位置已经有棋子了 return
                          return;
                        }
                      }
                      offset = Offset(dx, dy);
                      print("坐标值：dx= $dx dy= $dy");
                      setState(() {
                        //更新棋子 五子棋需要判断胜负
                        offsetList.add(offset);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 15,
                  width: widget.width + widget.height / qpWg,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: widget.width / qpWg,
                        height: 15,
                        alignment: Alignment.center,
                        child: Text(
                          zmList[index],
                          style: TextStyle(fontSize: 10),
                        ),
                      );
                    },
                    itemCount: zmList.length,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (offsetList.length > 0) {
                        setState(() {
                          offsetList.removeLast();
                        });
                      }
                    },
                    child: Text("悔一手"))
              ],
            ),
            left: 10,
            right: 10,
          )
        ],
      ),
    );
  }
}
