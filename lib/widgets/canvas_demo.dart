import 'package:flutter/material.dart';
import 'package:yht_meeting/widgets/wq_qp.dart';
import 'dart:math';

/// 绘制组件
class CanvasDemo extends StatefulWidget {
  @override
  _CanvasState createState() => _CanvasState();
}

class _CanvasState extends State<CanvasDemo> {
  Offset offset;
  List<Offset> offsetList = [];
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
  ];
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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 150,left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: 15,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    width: 15,
                    height: 20,
                    alignment: Alignment.center,
                    child: Text(
                      numList[numList.length - 1 - index],
                      style: TextStyle(fontSize: 10),
                    ),
                  );
                },
                itemCount: numList.length,
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    child: WqQp(
                      offsetList: offsetList,
                    ),
                    onPanDown: (e) {
                      var dx = e.localPosition.dx;
                      var dy = e.localPosition.dy;
                      for (var i = 0; i < offsetList.length; i++) {
                        var x = (offsetList[i].dx - dx).abs();
                        var y = (offsetList[i].dy - dy).abs();
                        if (sqrt(x * x + y * y) < 10) {
                          //说明这个位置已经有棋子了
                          return;
                        }
                      }
                      var eW = 300 / 15; //20
                      var eH = 300 / 15; //20
                      if (dx < eW) {
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
                      offset = Offset(dx, dy);
                      setState(() {
                        offsetList.add(offset);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 15,
                  width: 320,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 20,
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
                    child: Text("悔棋"))
              ],
            )
          ],
        ));
  }
}
