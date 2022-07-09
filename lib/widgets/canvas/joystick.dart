import 'dart:math';

import 'package:flutter/material.dart';

import '../coordinate.dart';

class JoyStick extends StatefulWidget {
  const JoyStick({Key? key}) : super(key: key);

  @override
  _JoyStickState createState() => _JoyStickState();
}

class _JoyStickState extends State<JoyStick> {
  ValueNotifier<Offset> _offsetCenter = ValueNotifier(Offset.zero);
  ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  late Size size;
  late double bgR = 40; // 底圆半径

  @override
  Widget build(BuildContext context) {
    size = Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height / 2,
    );
    return GestureDetector(
      child: CustomPaint(
        size: size,
        painter: JoyStickPainter(
            offset: _offset,
            offsetCenter: _offsetCenter,
            listenable: Listenable.merge([_offset, _offsetCenter])),
      ),
      // 移动
      onPanDown: down,
      onPanUpdate: update,
      onPanEnd: reset,
    );
  }

  down(DragDownDetails details) {
    Offset offset = details.localPosition;

    if (offset.dx > size.width - bgR) {
      offset = Offset(size.width - bgR, offset.dy);
    }
    if (offset.dx < bgR) {
      offset = Offset(bgR, offset.dy);
    }
    if (offset.dy > size.height - bgR) {
      offset = Offset(offset.dx, size.height - bgR);
    }
    if (offset.dy < bgR) {
      offset = Offset(offset.dx, bgR);
    }
    _offsetCenter.value = offset.translate(-size.width / 2, -size.height / 2);
    _offset.value = offset.translate(-size.width / 2, -size.height / 2);
  }

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
    _offsetCenter.value = Offset.zero;
  }

  update(DragUpdateDetails details) {
    final offset = details.localPosition;
    _offset.value = Offset(offset.dx, offset.dy)
        .translate(-size.width / 2, -size.height / 2);
  }
}

class JoyStickPainter extends CustomPainter {
  late Paint _paint;
  final double setP = 20; // 小格边长
  final double strokeWidth = 1; // 线宽
  final Color color = Colors.blue; // 线色值

  double d = 2.6; //复刻的像素边长
  final ValueNotifier<Offset> offsetCenter;
  final ValueNotifier<Offset> offset;
  late double bgR = 40; // 底圆半径

  JoyStickPainter({
    required this.offset,
    required this.offsetCenter,
    required Listenable listenable,
  }) : super(repaint: listenable) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;
  }

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);

    /// 手指移动坐标
    var offsetTranslate = offset.value;

    /// 操纵杆圆心坐标
    var offsetTranslateCenter = offsetCenter.value;

    /// 计算当前位置坐标点 左半区域 X为负数
    double x = offsetTranslateCenter.dx - offsetTranslate.dx;

    /// y轴 下半区域 Y为负数
    double y = offsetTranslateCenter.dy - offsetTranslate.dy;

    /// 反正切函数 通过此函数可以计算出此坐标旋转的弧度 为正 代表X轴逆时针旋转的角度 为负 顺时针旋转角度
    /// 范围 [-pi] - [pi]
    double ata = atan2(y, x);
    // print(
    //     "downCenter dx ${offsetTranslateCenter.dx} down dy ${offsetTranslateCenter.dy}");
    // print("down dx $x down dy $y");
    /// 默认坐标系范围为-pi - pi  顺时针旋转坐标系180度 变为 0 - 2*pi;
    var thta = ata + pi;
    print("angle ${(180 / pi * ata).toInt()}");


    // print("angle $thta");
    // print("angle $ata");
    /// 半径长度
    var r = sqrt(pow(x, 2) + pow(y, 2));
    if (r > bgR) {
      var dx = bgR * cos(thta) + offsetTranslateCenter.dx; // 求边长 cos
      var dy = bgR * sin(thta) + offsetTranslateCenter.dy; // 求边长
      offsetTranslate = Offset(dx, dy);
    }
    // 底圆
    canvas.drawCircle(
        offsetTranslateCenter,
        bgR,
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.2));
    _paint.color = color;
    _paint.style = PaintingStyle.stroke;

    /// 手势小圆
    canvas.drawCircle(
        offsetTranslate,
        bgR / 3,
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.6));
  }

  @override
  bool shouldRepaint(covariant JoyStickPainter oldDelegate) {
    return oldDelegate.offset != offset ||
        oldDelegate.offsetCenter != offsetCenter;
  }
}
