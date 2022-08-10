import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// 棋盘大小 9路 13路 19路
class QpSize {
  static const nine = 9; //9路
  static const thirteen = 13; //13路
  static const nineteen = 19; // 19路
}

class WqQp extends StatefulWidget {
  final double size; //棋盘矩形大小
  final int qpSize; //棋盘大小
  final isShowNum; // 是否显示手数
  final isOpenTry; // 是否开启试下
  final bool isCleanQP; // 是否清除棋盘棋子
  const WqQp({
    Key? key,
    this.size = 400,
    this.qpSize = QpSize.thirteen, // 棋盘大小
    this.isShowNum,
    this.isOpenTry = false,
    this.isCleanQP = false,
  }) : super(key: key);

  @override
  _WqQpState createState() => _WqQpState();
}

class _WqQpState extends State<WqQp> {
  // 棋子数据
  final List<Offset> qzList = [];
  late ValueNotifier<List<Offset>> goList = ValueNotifier([]);

  // 试下点数据
  ValueNotifier<Offset?> tryOffset = ValueNotifier(null);

  double margin1 = 40; // 棋盘左上边距（坐标区域）
  double margin2 = 20; // 棋盘右下边距

  @override
  Widget build(BuildContext context) {
    if (widget.isCleanQP) {
      qzList.clear();
      goList.value = qzList;
    }
    late double eSide =
        (widget.size - (margin1 + margin2)) / (widget.qpSize - 1); // 格子边长
    return Column(
      children: [
        GestureDetector(
          child: CustomPaint(
            size: Size(
                // MediaQuery.of(context).size.width, MediaQuery.of(context)
                // .size.width),
                widget.size,
                widget.size),
            painter: __QpPainter(widget.qpSize, margin1, margin2),
            foregroundPainter: _QzPainter(
              goList,
              tryOffset,
              Listenable.merge([
                goList,
                tryOffset,
              ]),
              margin1,
              widget.isShowNum,
              qzSize: eSide * 1,
              eSide: eSide,
            ),
          ),
          onPanDown: (e) {
            double dx = e.localPosition.dx;
            double dy = e.localPosition.dy;
            if (dx < margin1 - eSide / 2 ||
                dy < margin1 - eSide / 2 ||
                dx - (margin1 + ((widget.qpSize - 1) * eSide) + eSide / 2) >
                    0 ||
                dy - (margin1 + ((widget.qpSize - 1) * eSide) + eSide / 2) >
                    0) {
              return;
            }
            print("边长：$eSide ");
            dx = dx - (margin1 - eSide / 2);
            dy = dy - (margin1 - eSide / 2);
            print("点击坐标：dx= $dx dy= $dy");
            dx = dx - dx % eSide;
            dy = dy - dy % eSide;
            print("点击最终坐标：dx= $dx dy= $dy");
            for (var i = 0; i < qzList.length; i++) {
              double x = goList.value[i].dx;
              double y = goList.value[i].dy;
              if (dx == x && dy == y) {
                //说明这个位置已经有棋子 return
                return;
              }
            }
            if (widget.isOpenTry) {
              tryOffset.value = Offset(dx, dy);
            } else {
              qzList.add(Offset(dx, dy));
              List<Offset> qList = [];
              qList.addAll(qzList);
              goList.value = qList;
              print("添加坐标：dx= $dx dy= $dy");
            }
          },
        ),
        Visibility(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (tryOffset.value != null) {
                      qzList.add(tryOffset.value!);
                      List<Offset> qList = [];
                      qList.addAll(qzList);
                      goList.value = qList;
                      tryOffset.value = null;
                    }
                  },
                  child: Text("确定")),
            ],
          ),
          visible: widget.isOpenTry,
        ),
      ],
    );
  }
}

class __QpPainter extends CustomPainter {
  int qpSize;
  double margin1; // 棋盘左上边距（坐标区域）
  double margin2; // 棋盘右下边距
  __QpPainter(this.qpSize, this.margin1, this.margin2);

  @override
  void paint(Canvas canvas, Size size) {
    /// 棋盘背景
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    /// 棋盘网络线
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xff333333)
      ..strokeWidth = 1.0;

    // 棋盘除了网格还有坐标 所以真实的棋盘区域是要比我们设置Size的要小一点 留出区域绘制坐标
    double eSide = (size.width - margin1 - margin2) / (qpSize - 1); //格子边长
    // double eSide = (size.width ) / qpWg; //格子边长

    print("xxxx 格子边长= $eSide");

    /// 竖线 横向 坐标
    _drawColumnLines(canvas, paint, Size(size.width, size.height), eSide);
    _drawRowLines(
      canvas,
      paint,
      size,
      eSide,
    );

    /// 星位 不同路棋盘星位有些许差别 所以这里区分保存坐标
    List<Offset> offsetXList = [];
    if (qpSize == 19) {
      // 19 路
      // 左星位
      offsetXList.add(Offset(eSide * 3, eSide * 3));
      offsetXList.add(Offset(eSide * 3, eSide * 9));
      offsetXList.add(Offset(eSide * 3, eSide * 15));
      // 中间
      offsetXList.add(Offset(eSide * 9, eSide * 3));
      offsetXList.add(Offset(eSide * 9, eSide * 9)); // 天元
      offsetXList.add(Offset(eSide * 9, eSide * 15));
      // 右星位
      offsetXList.add(Offset(eSide * 15, eSide * 3));
      offsetXList.add(Offset(eSide * 15, eSide * 9));
      offsetXList.add(Offset(eSide * 15, eSide * 15));
    } else if (qpSize == 13) {
      // 13路
      offsetXList.add(Offset(eSide * 3, eSide * 3));
      offsetXList.add(Offset(eSide * 3, eSide * 9));

      offsetXList.add(Offset(eSide * 6, eSide * 6)); // 天元

      offsetXList.add(Offset(eSide * 9, eSide * 3));
      offsetXList.add(Offset(eSide * 9, eSide * 9));
    } else if (qpSize == 9) {
      //9 路
      // 左星位
      offsetXList.add(Offset(eSide * 2, eSide * 2));
      offsetXList.add(Offset(eSide * 2, eSide * 6));
      // 中间
      offsetXList.add(Offset(eSide * 4, eSide * 4)); // 天元
      // 右星位
      offsetXList.add(Offset(eSide * 6, eSide * 2));
      offsetXList.add(Offset(eSide * 6, eSide * 6));
    }
    canvas.save();
    canvas.translate(margin1, margin1);

    for (var i = 0; i < offsetXList.length; i++) {
      canvas.drawCircle(offsetXList[i], 3, paint..style = PaintingStyle.fill);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  /// 绘制竖线
  void _drawColumnLines(
    Canvas canvas,
    Paint paint,
    Size size,
    double eSide,
  ) {
    for (int i = 0; i < qpSize; i++) {
      // 横轴坐标
      final List<String> zmList = [
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
        "T"
      ];

      canvas.save();
      canvas.translate(eSide * i, 0);
      if (i == 0 || i == qpSize - 1) {
        paint..strokeWidth = 2;
      } else {
        paint..strokeWidth = 1;
      }
      canvas.drawLine(Offset(margin1, margin1),
          Offset(margin1, size.height - margin2), paint..color = Colors.black);
      canvas.restore();
      //
      canvas.save();
      var textPainter = TextPainter(
          text: TextSpan(
              text: zmList[i],
              style: TextStyle(
                  fontSize: 14,
                  foreground: Paint()..style = PaintingStyle.fill)),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      textPainter.layout();
      var textSize = textPainter.size;

      canvas.translate(margin1 + eSide * i, margin1 - 20);
      textPainter.paint(
          canvas, Offset(-textSize.width / 2, -textSize.height / 2));
      canvas.restore();
    }
  }

  /// 绘制横线
  void _drawRowLines(Canvas canvas, Paint paint, Size size, double eSide) {
    for (int i = 0; i < qpSize; i++) {
      if (i == 0 || i == qpSize - 1) {
        paint..strokeWidth = 2;
      } else {
        paint..strokeWidth = 1;
      }
      canvas.save();
      canvas.translate(0, eSide * i);
      canvas.drawLine(Offset(margin1, margin1),
          Offset(size.width - margin2, margin1), paint..color = Colors.black);
      canvas.restore();

      canvas.save();
      var textPainter = TextPainter(
          text: TextSpan(
              text: (i + 1).toString(),
              style: TextStyle(
                  fontSize: 16,
                  foreground: Paint()..style = PaintingStyle.fill)),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      textPainter.layout();
      var textSize = textPainter.size;

      canvas.translate(margin1 - margin2, (size.height - margin2) - eSide * i);

      textPainter.paint(
          canvas, Offset(-textSize.width / 2, -textSize.height / 2));

      canvas.restore();
    }
  }
}

enum QzType {
  black,
  white,
}

/// 绘制棋子
class _QzPainter extends CustomPainter {
  final ValueNotifier<List<Offset>> goList;
  final ValueNotifier<Offset?> tryOffset; // 试落点位
  final double qzSize;
  final double eSide;
  final double margin1;
  final Listenable listenable;
  final bool isShowNum;

  _QzPainter(
    this.goList,
    this.tryOffset,
    this.listenable,
    this.margin1,
    this.isShowNum, {
    required this.qzSize,
    required this.eSide,
  }) : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制棋子
    for (var i = 0; i < goList.value.length; i++) {
      if (i % 2 == 0) {
        // 黑棋先行
        _drawQz(
            QzType.black,
            Offset(
              goList.value[i].dx + margin1,
              goList.value[i].dy + margin1,
            ),
            canvas);
        _drawNum(
          QzType.black,
          Offset(
            goList.value[i].dx + margin1,
            goList.value[i].dy + margin1,
          ),
          i + 1,
          canvas,
        );
      } else {
        //   // 绘制白子
        _drawQz(
            QzType.white,
            Offset(
              goList.value[i].dx + margin1,
              goList.value[i].dy + margin1,
            ),
            canvas);
        // 手数
        _drawNum(
          QzType.white,
          Offset(
            goList.value[i].dx + margin1,
            goList.value[i].dy + margin1,
          ),
          i + 1,
          canvas,
        );
      }
      // 最后落子做标记
      Path currentPath = Path();
      if (i == goList.value.length - 1) {
        currentPath.moveTo(goList.value[i].dx + margin1,
            goList.value[i].dy + margin1 + qzSize / 2);
        currentPath.relativeLineTo(qzSize * 0.3, -qzSize * 0.3);
        currentPath.relativeLineTo(-qzSize * 0.6, 0);
        currentPath.close();
        Paint paint2 = Paint();
        canvas.drawPath(
            currentPath,
            paint2
              ..color = Colors.red
              ..style = PaintingStyle.fill);
      }
    }

    if (tryOffset.value != null) {
      if (goList.value.length % 2 == 0) {
        // 黑棋试下
        _drawQz(
            QzType.black,
            Offset(
              tryOffset.value!.dx + margin1,
              tryOffset.value!.dy + margin1,
            ),
            canvas,
            isTry: true);
      } else {
        _drawQz(
            QzType.white,
            Offset(
              tryOffset.value!.dx + margin1,
              tryOffset.value!.dy + margin1,
            ),
            canvas,
            isTry: true);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QzPainter oldDelegate) {
    return listenable != oldDelegate.listenable;
  }

  void _drawQz(QzType qzType, Offset centerOffset, Canvas canvas,
      {bool isTry = false}) {
    print("centerOffset $centerOffset");

    // 棋子颜色
    List<Color> qzColors;
    if (qzType == QzType.black) {
      if (isTry) {
        qzColors = [
          Color(0xFFa5a5a5).withOpacity(0.6),
          Color(0xFF333333).withOpacity(0.6)
        ];
      } else {
        qzColors = [Color(0xFFa5a5a5), Color(0xFF333333)];
      }
    } else {
      if (isTry) {
        qzColors = [
          Color(0xFFa5a5a5).withOpacity(0.6),
          Color(0xFFF3F3F3).withOpacity(0.6)
        ];
      } else {
        qzColors = [Color(0xFFa5a5a5), Color(0xFFF3F3F3)];
      }
    }
    var paint = Paint()..style = PaintingStyle.fill;
    Path path = Path();
    path.addOval(
        Rect.fromCenter(center: centerOffset, width: qzSize, height: qzSize));
    path.close();
    canvas.drawPath(
        path,
        paint
          ..shader = ui.Gradient.linear(
            Offset(centerOffset.dx - eSide, centerOffset.dy - eSide),
            Offset(centerOffset.dx + qzSize / 2 / 2 / 2,
                centerOffset.dy + qzSize / 2 / 2 / 2),
            qzColors,
          )
          ..style = PaintingStyle.fill);

    // 手数
  }

  void _drawNum(QzType qzType, Offset centerOffset, int num, Canvas canvas) {
    if (!isShowNum) {
      return;
    }
    // 手数颜色
    Color color =
        qzType == QzType.black ? Color(0xFFF3F3F3) : Color(0xFF333333);
    var textPainter = TextPainter(
        text: TextSpan(
            text: num.toString(),
            style: TextStyle(
              fontSize: qzSize * 0.4,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = color
                ..strokeWidth = 1,
            )),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    Size textSize = textPainter.size;
    canvas.save();
    canvas.translate(centerOffset.dx, centerOffset.dy);
    textPainter.paint(canvas,
        Offset.zero.translate(-textSize.width / 2, -textSize.height / 2));
    canvas.restore();
  }
}
