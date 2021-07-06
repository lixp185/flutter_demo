import 'package:flutter/material.dart';

class WqQp extends StatefulWidget {
  // 落子
  final List<Offset> offsetList;
  final double width; //棋盘宽
  final double height; //棋盘高
  final int qpWg; //棋盘网络路
  final double qzSize; //棋子大小

  const WqQp(
      {Key key,
      this.offsetList,
      this.width = 300,
      this.height = 300,
      this.qpWg = 15,
      this.qzSize = 8})
      : super(key: key);

  @override
  _WqQpState createState() => _WqQpState();
}

class _WqQpState extends State<WqQp> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: MyPaint(),
      foregroundPainter: Qz(widget.offsetList),
    );
  }
}

// 棋子
class Qz extends CustomPainter {
  final List<Offset> offsetList;

  Qz(this.offsetList);

  @override
  void paint(Canvas canvas, Size size) {
    Color color = Colors.black;
    for (var i = 0; i < offsetList.length; i++) {
      if (i % 2 == 0) {
        color = Colors.black;
      } else {
        color = Colors.white;
      }
      var paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offsetList[i], 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var eW = size.width / 15;
    var eH = size.height / 15;

    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eH * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= 15; ++i) {
      double dx = eW * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //是否需要重新绘制
    return false;
  }
}
