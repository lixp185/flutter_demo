import 'dart:math';

import 'package:flutter/material.dart';

class JueJinLogo extends StatelessWidget {
  final double height; // 组件高度
  final double angle; // 菱形上下角度1/2

  const JueJinLogo({Key? key, this.height = 140, this.angle = pi / 18 * 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double m = 0.7; // 折线线宽相对菱形边长倍数
    double n = 1.5; // 折线之间线宽相对菱形边长倍数
    var a = (2 * cos(angle) + m * 0.5 / sin(angle) + 3);
    double side = height / (a + m * 0.5 / sin(pi - angle * 2) / sin(angle));
    double paintWidth = m * side;
    double h2 =
        side * cos(angle) + side * n + (paintWidth / 2 / sin(angle) + side * n);
    Point right = PointUtil.toTwoPoint(Point(side * sin(angle), 0),
        Point(0, -side * cos(angle)), Point(h2 * tan(angle), 0), Point(0, h2));
    double width = (right.x.toDouble() +
            paintWidth / 2 / sin(pi - angle * 2) * sin(angle)) * 2;

    return CustomPaint(
      size: Size(width, height),
      painter: _JueJinLogoPaint(side, angle),
    );
  }
}

class _JueJinLogoPaint extends CustomPainter {
  double side;
  double angle;

  _JueJinLogoPaint(this.side, this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    double paintWidth = side * 0.7;
    Paint paint = Paint()
      ..strokeWidth = paintWidth
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.miter
      // ..shader = ui.Gradient.linear(
      // Offset.zero, Offset(0, 100), [Colors.blue, Colors.yellow]);
      ..color = Color(0xff1E80FF);

    canvas.save();

    // canvas.clipRect(Rect.fromLTRB(-100,-side*cos(angle),  100,
    //     (side*3*2 * cos(angle))+(side/4)/sin(angle)));
    // canvas
    Path path = Path();
    path.moveTo(-side * sin(angle), 0);
    path.lineTo(0, -side * cos(angle));
    path.lineTo(side * sin(angle), 0);
    path.lineTo(0, side * cos(angle));
    path.close();

    Path path2 = Path();
    double h1 = side * cos(angle) + side * 1.5;
    path2.moveTo(-h1 * tan(angle), 0);
    path2.lineTo(0, h1);
    path2.lineTo(h1 * tan(angle), 0);

    Path path3 = Path();
    double h2 = h1 + (paintWidth / 2 / sin(angle) + side * 1.5);
    path3.moveTo(-h2 * tan(angle), 0);
    path3.lineTo(0, h2);
    path3.lineTo(h2 * tan(angle), 0);

    canvas.translate(
        0,
        side * cos(angle) -
            (h2 + (paintWidth / 2 / sin(angle)) + side * cos(angle)) / 2);

    Point left = PointUtil.toTwoPoint(Point(-side * sin(angle), 0),
        Point(0, -side * cos(angle)), Point(-h2 * tan(angle), 0), Point(0, h2));
    Point right = PointUtil.toTwoPoint(Point(side * sin(angle), 0),
        Point(0, -side * cos(angle)), Point(h2 * tan(angle), 0), Point(0, h2));

    // double =
    Path pathBg = Path();
    pathBg.moveTo(0, -side * cos(angle));
    pathBg.lineTo(
        left.x.toDouble() - paintWidth / 2 / sin(pi - angle * 2) * sin(angle),
        left.y.toDouble() + paintWidth / 2 / sin(pi - angle * 2) * cos(angle));
    pathBg.lineTo(left.x.toDouble(),
        h2 + (paintWidth / 2 / sin(pi - angle * 2) / sin(angle)));
    pathBg.lineTo(right.x.toDouble(),
        h2 + (paintWidth / 2 / sin(pi - angle * 2) / sin(angle)));
    pathBg.lineTo(right.x.toDouble() + paintWidth / 2 * sin(angle),
        right.y.toDouble() + paintWidth / 2 * cos(angle));
    pathBg.close();
    canvas.clipPath(pathBg);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint..style = PaintingStyle.stroke);
    canvas.drawPath(path3, paint..style = PaintingStyle.stroke);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _JueJinLogoPaint oldDelegate) {
    return false;
  }
}

class PointUtil {
  /// 两点求直线方程
  static double towPointKb(Point<double> p1, Point<double> p2,
      {bool isK = true}) {
    /// 求得两点斜率
    double k = 0;
    double b = 0;
    // 防止除数 = 0 出现的计算错误 a e x轴重合
    if (p1.x == p2.x) {
      k = (p1.y - p2.y) / (p1.x - p2.x - 1);
    } else {
      k = (p1.y - p2.y) / (p1.x - p2.x);
    }
    b = p1.y - k * p1.x;
    if (isK)
      return k;
    else
      return b;
  }

  static Point<double> toTwoPoint(
      Point<double> a, Point<double> b, Point<double> m, Point<double> n) {
    double k1 = towPointKb(a, b);
    double b1 = towPointKb(a, b, isK: false);

    double k2 = towPointKb(m, n);
    double b2 = towPointKb(m, n, isK: false);

    return Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
  }
}
