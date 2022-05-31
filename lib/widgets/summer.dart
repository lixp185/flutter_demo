import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/xf_manage.dart';
import 'coordinate.dart';
import 'dart:ui' as ui;

/// 端午安康
class Summer extends StatefulWidget {
  final ui.Image image;
  final Animation<double> animation;
  final Animation<double> animation2;
  final Listenable listenable;

  const Summer(
      {Key? key,
      required this.image,
      required this.animation,
      required this.animation2,
      required this.listenable})
      : super(key: key);

  @override
  _SummerState createState() => _SummerState();
}

class _SummerState extends State<Summer> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        // size: Size(100, 100),
        size: Size(double.infinity, double.infinity),
        painter: _GuaPainter(widget.image, widget.animation, widget.animation2,
            widget.listenable),
      ),
    );
  }
}

class _GuaPainter extends CustomPainter {
  final Animation<double> animation;
  final Animation<double> animation2;
  final Listenable listenable;
  Coordinate coordinate = Coordinate(setP: 20);

  final ui.Image image;

  _GuaPainter(this.image, this.animation, this.animation2, this.listenable)
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // coordinate.paintT(canvas, size);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color(0xFFFEFFDD)
      ..isAntiAlias = true;

    canvas.drawImageRect(
        image,
        // src
        Rect.fromCenter(
            center: Offset(image.width / 2, image.height / 2),
            width: image.width.toDouble(),
            height: image.height.toDouble()),
        //   dec
        Rect.fromCenter(
            center: Offset.zero,
            width: size.width.toDouble(),
            height: size.height.toDouble()),
        paint);

    canvas.translate(-150, -50);

    canvas.translate(0, 20*animation2.value);

    Path path = Path();

    path.relativeQuadraticBezierTo(50, -80, 100, 0);
    path.relativeQuadraticBezierTo(90, 130, -50, 130);
    path.relativeQuadraticBezierTo(-140, 0, -50, -130);
    path.close();

    canvas.drawPath(path, paint..style = PaintingStyle.fill);

    Path path2 = Path();

    path2.relativeQuadraticBezierTo(60, 100, 190, 130);
    path2.relativeLineTo(0, 40);
    path2.relativeLineTo(-260, 0);
    path2.relativeLineTo(0, -200);
    path2.close();

    /// 左边粽叶
    Path pathStart = Path.combine(PathOperation.intersect, path, path2);
    pathStart.close();
    canvas.drawPath(
        pathStart,
        paint
          ..color = Color(0xFF2A9200)
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        pathStart,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    _canvasStartLines(canvas, pathStart, paint);

    Path path3 = Path();
    path3.moveTo(100, 0);
    path3.relativeQuadraticBezierTo(0, 50, -190, 130);
    path3.relativeLineTo(0, 60);
    path3.relativeLineTo(240, 0);
    path3.relativeLineTo(0, -200);
    path3.close();

    /// 右边粽叶
    Path pathRight = Path.combine(PathOperation.intersect, path, path3);
    canvas.drawPath(
        pathRight,
        paint
          ..color = Color(0xFF2A9200)
          ..style = PaintingStyle.fill);
    //边框
    canvas.drawPath(
        pathRight,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    _canvasRightLines(canvas, pathRight, paint);
    //
    /// 嘴巴
    Path path4 = Path();
    path4.moveTo(40, 20);
    path4.relativeCubicTo(2, 18*animation.value, 18, 18*animation.value, 20, 0);
    path4.close();
    canvas.drawPath(path4, paint..color = Colors.black87);
    //
    /// 眼睛
    Path path5 = Path();
    path5.moveTo(20, 5);
    path5.relativeCubicTo(5, -10, 15, -10, 20, 0);
    canvas.drawPath(
        path5,
        paint
          ..color = Colors.black87
          ..style = PaintingStyle.stroke);
    canvas.save();
    canvas.translate(40, 0);
    canvas.drawPath(
        path5,
        paint
          ..color = Colors.black87
          ..style = PaintingStyle.stroke);
    canvas.restore();

    /// 晒红
    Path path9 = Path();
    path9.addArc(Rect.fromCenter(center: Offset(30, 30), width: 4, height: 6),
        0, pi * 2);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.save();
    canvas.translate(6, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();
    canvas.save();
    canvas.translate(34, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();
    canvas.save();
    canvas.translate(40, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();

    ///

    ///甜

    /// 头绳

    Path path6 = Path();

    path6.moveTo(0, -50);
    path6.quadraticBezierTo(50, 10, 100, -50);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, path6),
        paint
          ..color = Colors.pink
          ..style = PaintingStyle.stroke);

    var textPainter = TextPainter(
        text: TextSpan(
            text: "甜", style: TextStyle(fontSize: 16, color: Colors.white)),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var size2 = textPainter.size;

    canvas.drawCircle(
        Offset(50, -20),
        size2.width,
        paint
          ..color = Colors.pink
          ..style = PaintingStyle.fill);
    textPainter.paint(
        canvas, Offset(-size2.width / 2, -size2.height / 2).translate(50, -20));

    canvas.drawPath(
        path,
        paint
          ..style = PaintingStyle.stroke
          ..color = Colors.black87);
    //
    ///粽叶路径
    ///左边
    var pms = pathStart.computeMetrics();
    var pmRs = pathRight.computeMetrics();
    var first = pms.first;
    var firstR = pmRs.first;
    var offsetStart = first.getTangentForOffset(first.length * 0.55)!;
    var offsetRight = firstR.getTangentForOffset(firstR.length * 0.43)!;

    /// 手
    Path path7 = Path();
    path7.moveTo(offsetStart.position.dx, offsetStart.position.dy);
    path7.relativeLineTo(-30, 20);
    path7.relativeLineTo(-5, -30);

    /// 左手
    canvas.drawPath(
        path7,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
    path7.reset();
    path7.moveTo(offsetRight.position.dx, offsetRight.position.dy);
    path7.relativeLineTo(60, 10);
    path7.relativeLineTo(0, -5);

    ///右手
    canvas.drawPath(
        path7,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    /// 脚
    var offsetRightJ1 = firstR.getTangentForOffset(firstR.length * 0.9)!;
    var offsetRightJ2 = firstR.getTangentForOffset(firstR.length * 0.7)!;

    Path path8 = Path();
    path8.moveTo(offsetRightJ1.position.dx, offsetRightJ1.position.dy);
    path8.relativeLineTo(-10, 40);
    path8.relativeLineTo(-10, 0);

    /// 左脚
    canvas.drawPath(
        path8,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
    path8.reset();
    path8.moveTo(offsetRightJ2.position.dx, offsetRightJ2.position.dy);
    path8.relativeLineTo(10, 40);
    path8.relativeLineTo(10, 0);

    ///右脚
    canvas.drawPath(
        path8,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    /// 咸甜一家人
    var textPainter2 = TextPainter(
        text: TextSpan(
            text: "咸甜一家人",
            style: TextStyle(fontSize: 26, color: Colors.black87)),
        textDirection: TextDirection.ltr);
    textPainter2.layout();
    var size3 = textPainter.size;

    textPainter2.paint(canvas,
        Offset(-size3.width / 2, -size3.height / 2).translate(100, -100));

    ///小心心
    Path path12 = Path();
    path12.moveTo(140, 0);
    path12.relativeCubicTo(-20, -8, -6, -24, 0, -14);
    path12.close();
    canvas.drawPath(
        path12,
        paint
          ..color = Colors.red
          ..style = PaintingStyle.fill);
    path12.relativeCubicTo(20, -8, 6, -24, 0, -14);
    canvas.drawPath(path12, paint..color = Colors.red);
    canvas.save();
    canvas.translate(40, -20);
    canvas.rotate(pi / 18);
    canvas.drawPath(path12, paint..color = Colors.red);
    canvas.restore();
    _canvasXZ(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _GuaPainter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }

  _canvasStartLines(Canvas canvas, Path pathStart, Paint paint) {
    for (int i = 1; i < 10; i++) {
      Path path = Path();
      path.moveTo(-8 * i.toDouble(), 8 * i.toDouble());
      path.relativeQuadraticBezierTo(60, 100, 190, 130);
      path.relativeLineTo(0, 60);
      path.relativeLineTo(-300, 0);
      path.relativeLineTo(0, -200);
      path.close();
      canvas.drawPath(
          Path.combine(PathOperation.intersect, pathStart, path),
          paint
            ..color = Colors.black
            ..style = PaintingStyle.stroke);
    }
  }

  void _canvasRightLines(Canvas canvas, Path pathRight, Paint paint) {
    for (int i = 1; i < 10; i++) {
      Path path = Path();
      path.moveTo(100 + 8 * i.toDouble(), 0 + 8 * i.toDouble());
      path.relativeQuadraticBezierTo(0, 50, -190, 130);
      path.relativeLineTo(0, 60);
      path.relativeLineTo(240, 0);
      path.relativeLineTo(0, -200);
      path.close();
      canvas.drawPath(
          Path.combine(PathOperation.intersect, pathRight, path),
          paint
            ..color = Colors.black
            ..style = PaintingStyle.stroke);
    }
  }

  void _canvasXZ(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(240, -30);
    canvas.rotate(pi * 2 - pi / 18);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color(0xFFFEFFDD)
      ..isAntiAlias = true;
    Path path = Path();

    path.relativeQuadraticBezierTo(50, -80, 100, 0);
    path.relativeQuadraticBezierTo(90, 130, -50, 130);
    path.relativeQuadraticBezierTo(-140, 0, -50, -130);
    path.close();

    canvas.drawPath(path, paint..style = PaintingStyle.fill);

    Path path2 = Path();

    path2.relativeQuadraticBezierTo(60, 100, 190, 130);
    path2.relativeLineTo(0, 40);
    path2.relativeLineTo(-260, 0);
    path2.relativeLineTo(0, -200);
    path2.close();

    /// 左边粽叶
    Path pathStart = Path.combine(PathOperation.intersect, path, path2);
    pathStart.close();

    canvas.drawPath(
        pathStart,
        paint
          ..color = Color(0xFF2A9200)
          ..style = PaintingStyle.fill);
    canvas.drawPath(
        pathStart,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    _canvasStartLines(canvas, pathStart, paint);

    Path path3 = Path();
    path3.moveTo(100, 0);
    path3.relativeQuadraticBezierTo(0, 50, -190, 130);
    path3.relativeLineTo(0, 60);
    path3.relativeLineTo(240, 0);
    path3.relativeLineTo(0, -200);
    path3.close();

    /// 右边粽叶
    Path pathRight = Path.combine(PathOperation.intersect, path, path3);
    canvas.drawPath(
        pathRight,
        paint
          ..color = Color(0xFF2A9200)
          ..style = PaintingStyle.fill);
    //边框
    canvas.drawPath(
        pathRight,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    _canvasRightLines(canvas, pathRight, paint);
    //
    /// 嘴巴
    Path path4 = Path();
    path4.moveTo(40, 20);
    path4.relativeCubicTo(2, 18, 18, 18, 20, 0);
    path4.close();
    canvas.drawPath(path4, paint..color = Colors.black87);
    //
    /// 眼睛
    Path path5 = Path();
    path5
        .addOval(Rect.fromCenter(center: Offset(26, 5), width: 15, height: 15));
    canvas.drawPath(
        path5,
        paint
          ..color = Colors.black87
          ..style = PaintingStyle.fill);

    path5.reset();
    path5.addOval(Rect.fromCenter(center: Offset(24, 5), width: 4, height: 4));
    canvas.drawPath(
        path5,
        paint
          ..color = Colors.white
          ..style = PaintingStyle.fill);
    canvas.save();
    path5.reset();
    canvas.translate(70, 0);
    path5.relativeLineTo(-10, 5);
    path5.relativeLineTo(10, 5);
    canvas.drawPath(
        path5,
        paint
          ..color = Colors.black87
          ..style = PaintingStyle.stroke);
    canvas.restore();

    /// 晒红
    Path path9 = Path();
    path9.addArc(Rect.fromCenter(center: Offset(30, 30), width: 4, height: 6),
        0, pi * 2);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.save();
    canvas.translate(6, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();
    canvas.save();
    canvas.translate(34, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();
    canvas.save();
    canvas.translate(40, 0);
    canvas.drawPath(
        path9,
        paint
          ..color = Color(0xFFFFA2AE)
          ..style = PaintingStyle.fill);
    canvas.restore();

    ///

    ///甜

    /// 头绳

    Path path6 = Path();

    path6.moveTo(0, -50);
    path6.quadraticBezierTo(50, 10, 100, -50);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, path6),
        paint
          ..color = Colors.blue
          ..style = PaintingStyle.stroke);

    var textPainter = TextPainter(
        text: TextSpan(
            text: "咸", style: TextStyle(fontSize: 16, color: Colors.white)),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var size2 = textPainter.size;

    canvas.drawCircle(
        Offset(50, -20),
        size2.width,
        paint
          ..color = Colors.blue
          ..style = PaintingStyle.fill);
    textPainter.paint(
        canvas, Offset(-size2.width / 2, -size2.height / 2).translate(50, -20));

    canvas.drawPath(
        path,
        paint
          ..style = PaintingStyle.stroke
          ..color = Colors.black87);
    //
    ///粽叶路径
    ///左边
    var pms = pathStart.computeMetrics();
    var pmRs = pathRight.computeMetrics();
    var first = pms.first;
    var firstR = pmRs.first;
    var offsetStart = first.getTangentForOffset(first.length * 0.55)!;
    var offsetRight = firstR.getTangentForOffset(firstR.length * 0.43)!;

    /// 手
    Path path7 = Path();
    path7.moveTo(offsetStart.position.dx, offsetStart.position.dy);
    path7.relativeLineTo(-60, 20);
    path7.relativeLineTo(-5, -0);

    /// 左手
    canvas.drawPath(
        path7,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
    path7.reset();
    path7.moveTo(offsetRight.position.dx, offsetRight.position.dy);
    path7.relativeLineTo(60, 10);
    path7.relativeLineTo(0, -5);

    ///右手
    canvas.drawPath(
        path7,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    /// 脚
    var offsetRightJ1 = firstR.getTangentForOffset(firstR.length * 0.9)!;
    var offsetRightJ2 = firstR.getTangentForOffset(firstR.length * 0.7)!;

    Path path8 = Path();
    path8.moveTo(offsetRightJ1.position.dx, offsetRightJ1.position.dy);
    path8.relativeLineTo(-20, 40);
    path8.relativeLineTo(-10, 0);

    /// 左脚
    canvas.drawPath(
        path8,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);
    path8.reset();
    path8.moveTo(offsetRightJ2.position.dx, offsetRightJ2.position.dy);
    path8.relativeLineTo(10, 40);
    path8.relativeLineTo(10, -20);

    ///右脚
    canvas.drawPath(
        path8,
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke);

    canvas.restore();
  }
}
