import 'dart:math';

import 'package:flutter/material.dart';

import '../coordinate.dart';

import 'dart:ui' as ui;

class LoadingDemo extends StatefulWidget {
  const LoadingDemo({Key? key}) : super(key: key);

  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class ColorRectTween extends Tween<ColorRect?> {
  ColorRectTween({super.begin, super.end});

  @override
  ColorRect lerp(double t) {
    return ColorRect(Color.lerp(begin?.color, end?.color, t) ?? Colors.white,
        Rect.lerp(begin?.rect, end?.rect, t) ?? Rect.zero);
  }
}

class StringTween extends Tween<String> {
  StringTween({super.begin, super.end});

  @override
  String lerp(double t) {
    if ((t * 100).round() % 10 < 5) {
      return "$begin${end?.substring(0, ((end!.length * t).round()))} |";
    } else {
      return "$begin${end?.substring(0, ((end!.length * t).round()))}  ";
    }
  }
}

class ColorRect {
  Color color;
  Rect rect;

  ColorRect(this.color, this.rect);
}

class _LoadingDemoState extends State<LoadingDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000))
    ..repeat(reverse: true);

  // 控制器
  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  var a = ColorRect(Colors.yellow,
      Rect.fromCenter(center: Offset.zero, width: 50, height: 200));
  var b = ColorRect(Colors.red, Rect.fromLTWH(-100, 50, 200, 50));

  // late Animation<ColorRect?> _animation =
  //     ColorRectTween(begin: a, end: b).animate(_controller);

  late Animation<String> _animation =
      StringTween(begin: '', end: "相信技术，传递价值。").animate(_controller);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: _LoadingPaint(_controller),
      ),
    );
  }
}

class _LoadingPaint extends CustomPainter {
  // Animation<ColorRect?> animation;
  Animation<double?> animation;

  _LoadingPaint(this.animation);

  // Paint _paint = Paint()
  //   ..color = Colors.blue
  //   ..style = PaintingStyle.fill;

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);
    // double angle = pi / 18 * (2+3*animation.value!);
    double angle = pi / 18 * 5;
    // double side = 60;
    // 菱形边长
    double side = 30;
    // 画笔大小
    double paintWidth = side * 0.7;
    Paint paint = Paint()
      ..strokeWidth = paintWidth
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeJoin = StrokeJoin.miter
      // ..shader = ui.Gradient.linear(
      // Offset.zero, Offset(0, 100), [Colors.blue, Colors.yellow]);
      ..color = Color(0xff1E80FF).withOpacity(0.7);

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

    Point left = toTwoPoint(Point(-side * sin(angle), 0),
        Point(0, -side * cos(angle)), Point(-h2 * tan(angle), 0), Point(0, h2));
    Point right = toTwoPoint(Point(side * sin(angle), 0),
        Point(0, -side * cos(angle)), Point(h2 * tan(angle), 0), Point(0, h2));

    var a = (2*cos(angle)+0.7*0.5/sin(angle)+3);

    double h = side*(a + 0.7 * 0.5 / sin(pi - angle * 2) / sin(angle));
      side = h/(a + 0.7 * 0.5 / sin(pi - angle * 2) / sin(angle));

    double w = (right.x.toDouble() + paintWidth / 2 / sin(pi - angle * 2) * sin(angle))*2;
    print('h == $h');
    print('w == $w');

    Path pathBg = Path();
    pathBg.moveTo(0, -side * cos(angle));
    pathBg.lineTo(
        left.x.toDouble() - paintWidth / 2 / sin(pi - angle * 2) * sin(angle),
        left.y.toDouble() + paintWidth / 2 / sin(pi - angle * 2) * cos(angle));
    pathBg.lineTo(left.x.toDouble(),
        h2 + (paintWidth / 2 / sin(pi - angle * 2) / sin(angle)));
    pathBg.lineTo(right.x.toDouble(),
        h2 + (paintWidth / 2 / sin(pi - angle * 2) / sin(angle)));
    pathBg.lineTo(right.x.toDouble() + paintWidth / 2 / sin(pi - angle * 2) * sin(angle),
        right.y.toDouble() + paintWidth / 2 * cos(angle));
    pathBg.close();
    canvas.clipPath(pathBg);
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint..style = PaintingStyle.stroke);
    canvas.drawPath(path3, paint..style = PaintingStyle.stroke);

    // Paint pf = Paint()
    //   ..color = Colors.red
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.stroke;
    // // canvas.drawLine(Offset(0, side * cos(angle)), Offset(0, h1+20), pf);
    // canvas.drawPath(path3, pf);

    // Path path22 = Path();
    // path22.moveTo(-(side * cos(angle) + side) * tan(angle), 0);
    // PathMetrics pms = path2.computeMetrics();
    // pms.forEach((pm) {
    //   Tangent? tangent =
    //       pm.getTangentForOffset(pm.length * (animation.value ?? 0));
    //   if (tangent == null) return;
    //   // print("---position:-${tangent.position}-");
    //   if(tangent.position.dx > 0){
    //     path22.lineTo(0, side * cos(angle) + side);
    //   }
    //   path22.lineTo(tangent.position.dx, tangent.position.dy);
    //
    //   canvas.drawPath(path22, paint);
    // });

    // Paint p2 = Paint();
    // canvas.drawCircle(
    //     Offset(0, (side * cos(angle) + side*1.5) - (paintWidth/2 / sin(angle))), 2, p2);
    // canvas.drawCircle(
    //     Offset(0, (side * cos(angle) + side*1.5) + (paintWidth/2 / sin(angle))), 2, p2);

    Paint p3 = Paint();
    canvas.drawPath(pathBg, p3..color = Colors.black54);

    // Path path22 = Path();
    // path22.moveTo(0, -side * cos(angle));
    // path22.lineTo(160,
    //     -side * cos(angle) + 160 * ((side * cos(angle)) / (side * sin(angle))));
    // path22.relativeLineTo(0, -300);
    // path22.close();
    //
    // Path path222 = Path();
    // path222.moveTo(0, -side * cos(angle));
    // path222.lineTo(-160,
    //     -side * cos(angle) + 160 * ((side * cos(angle)) / (side * sin(angle))));
    // path222.relativeLineTo(0, -300);
    // path222.close();

    // canvas.drawPath(path22, paint..color = Colors.
    // red.withOpacity(0.2)..style = PaintingStyle.fill);

    // canvas.drawPath(path222, paint..color = Colors.red.withOpacity(0.2)..style = PaintingStyle.fill);
    // canvas.drawRect(Rect.fromLTRB(-100,_s(animation,angle,side),  100,
    //     (112 * cos(angle)+8)), paint..color = Colors.white);

    // canvas.drawRect(Rect.fromLTRB(-100,-side*cos(angle),  100,
    //    (side*3*2 * cos(angle))+(side/4)/sin(angle)), paint..color = Colors.black54);

    canvas.restore();

    // canvas.drawPath(Path.combine(PathOperation.difference, path2, path22),
    //     paint..style = PaintingStyle.fill..color = Colors.white);

    // canvas.save();
    // canvas.translate(-side * cos(angle), 0);
    // path.lineTo(side * cos(angle), -side * sin(angle));
    // canvas.drawPath(path, paint);
    // canvas.restore();
    // canvas.save();
    // canvas.translate(-side * cos(angle), 0);
    // canvas.scale(1, -1);
    // canvas.drawPath(path, paint);
    // canvas.restore();
    // canvas.save();
    // canvas.translate(side * cos(angle), 0);
    // canvas.scale(-1, 1);
    // canvas.drawPath(path, paint);
    // canvas.restore();
    // canvas.save();
    // canvas.translate(side * cos(angle), 0);
    // canvas.scale(-1, -1);
    // canvas.drawPath(path, paint);
    // canvas.restore();

    // path.addRect(Rect.fromCenter(center: Offset.zero, width: 50, height: 100));
    //
    //
    // canvas.drawPath(path, paint);
    //
    // Path pathI  = Path();
    //
    // pathI.moveTo(-25,-30);
    // pathI.cubicTo(60, -120, -70,90, 25,20);
    //
    // canvas.drawPath(pathI, paint);
  }

  @override
  bool shouldRepaint(covariant _LoadingPaint oldDelegate) {
    return false;
  }

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
