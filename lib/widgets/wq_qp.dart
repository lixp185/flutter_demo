import 'package:flutter/material.dart';

class WqQp extends StatefulWidget {
  // 落子
  final List<Offset> offsetList; // 落子集合
  final Offset? offset; // 试落点位
  final double width; //棋盘宽
  final double height; //棋盘高
  final int qpWg; //棋盘网络路
  final double qzSize; //棋子大小

  const WqQp({
    Key? key,
    required this.offsetList,
    this.offset,
    this.width = 360,
    this.height = 360,
    this.qpWg = 18,
    this.qzSize = 10,
  }) : super(key: key);

  @override
  _WqQpState createState() => _WqQpState();
}

class _WqQpState extends State<WqQp> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: MyPaint(widget.qpWg),
      foregroundPainter:
          Qz(widget.offsetList, widget.offset, qzSize: widget.qzSize),
    );
  }
}

// 棋子
class Qz extends CustomPainter {
  final List<Offset> offsetList;
  final double qzSize; //棋子大小
  final Offset? offset; // 试落点位
  Qz(this.offsetList, this.offset, {required this.qzSize});

  @override
  void paint(Canvas canvas, Size size) {
    Color color;
    var paint = Paint()..style = PaintingStyle.fill;
    // 绘制棋子
    for (var i = 0; i < offsetList.length; i++) {
      if (i % 2 == 0) {
        color = Color(0xFF3A3A3A);
      } else {
        color = Colors.white;
      }
      paint
        ..color = color
       ;
      Path path = Path();
      path.addRRect(RRect.fromRectXY(
          Rect.fromCenter(
              center: offsetList[i], width: qzSize * 2, height: qzSize * 2),
          qzSize,
          qzSize));

      canvas.drawPath(path, paint);
      // canvas.drawShadow(path, Colors.black, 10, true);

      // canvas.drawCircle(offsetList[i], qzSize , paint);
    }

    if (offset != null) {
      print("xxxxxoffset");
      if (offsetList.length % 2 == 0) {
        color = Colors.black54;
      } else {
        color = Colors.white60;
      }
      paint..color = color;
      Path path = Path();
      path.addRRect(RRect.fromRectXY(
          Rect.fromCenter(
              center: offset!, width: qzSize * 2, height: qzSize * 2),
          qzSize,
          qzSize));

      canvas.drawPath(path, paint);
      // canvas.drawShadow(path, Colors.black, 10, true);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyPaint extends CustomPainter {
  final int qpWg; //棋盘网络路
  MyPaint(this.qpWg);

  @override
  void paint(Canvas canvas, Size size) {
    var eW = size.width / qpWg;
    var eH = size.height / qpWg;
    print("ew= $eW");
    print("eh= $eH");
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

    for (int i = 0; i <= qpWg; ++i) {
      double dy = eH * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (int i = 0; i <= qpWg; ++i) {
      double dx = eW * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
    var paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    List<Offset> offsetXList = [];
    if (qpWg == 18) {
      // 19 路
      // 左星位
      offsetXList.add(Offset(eW * 3, eH * 3));
      offsetXList.add(Offset(eW * 3, eH * 9));
      offsetXList.add(Offset(eW * 3, eH * 15));
      // 中间
      offsetXList.add(Offset(eW * 9, eH * 3));
      offsetXList.add(Offset(eW * 9, eH * 9)); // 天元
      offsetXList.add(Offset(eW * 9, eH * 15));
      // 右星位
      offsetXList.add(Offset(eW * 15, eH * 3));
      offsetXList.add(Offset(eW * 15, eH * 9));
      offsetXList.add(Offset(eW * 15, eH * 15));
    } else if (qpWg == 12) {
      // 13路
      offsetXList.add(Offset(eW * 3, eH * 3));
      offsetXList.add(Offset(eW * 3, eH * 9));
      offsetXList.add(Offset(eW * 6, eH * 6)); // 天元
      offsetXList.add(Offset(eW * 9, eH * 3));
      offsetXList.add(Offset(eW * 9, eH * 9));
    } else {
      //9 路
      // 左星位
      offsetXList.add(Offset(eW * 2, eH * 2));
      offsetXList.add(Offset(eW * 2, eH * 6));
      // 中间
      offsetXList.add(Offset(eW * 4, eH * 4)); // 天元
      // 右星位
      offsetXList.add(Offset(eW * 6, eH * 2));
      offsetXList.add(Offset(eW * 6, eH * 6));
    }
    for (var i = 0; i < offsetXList.length; i++) {
      canvas.drawCircle(offsetXList[i], 2.4, paint2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //是否需要重新绘制
    return false;
  }
}
