import 'dart:math';

import 'package:flutter/material.dart';

import 'coordinate.dart';

/// xlfLogo Loading
class XlfLogoLoading extends StatefulWidget {
  /// logo大小 内六边形对应圆半径
  final double? radius;

  const XlfLogoLoading({Key? key, required this.radius}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _XlfLogoPaintState();
}

class _XlfLogoPaintState extends State<XlfLogoLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    print("xxxx${context.findRenderObject()}");

    return Container(

      child: CustomPaint(
        size: Size((widget.radius ?? 8) * 8, (widget.radius ?? 8) * 8),
        painter: _LogoPainter(_ctrl, radius: widget.radius ?? 8),
        child: const Text('信立方'),
      ),
      alignment: Alignment.center,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}

class _LogoPainter extends CustomPainter {
  final Animation<double> progress;
  final double radius;
  Coordinate coordinate = Coordinate(setP: 20);

  _LogoPainter(this.progress, {this.radius = 8}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    int count = 6; // 正六边形
    double r0 = radius; // 内小
    double r1 = radius * 2; // 外1
    double r2 = radius * 3; // 外2
    double r3 = radius * 4; //外3

    // coordinate.paintT(canvas, size);
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path0 = Path();
    path0.moveTo(
        r0 * cos((pi * 2 / count) * 1), r0 * sin((pi * 2 / count) * 1));
    for (int i = 2; i <= count; i++) {
      path0.lineTo(r0 * cos(pi * 2 / count * i), r0 * sin(pi * 2 / count * i));
    }
    path0.close();

    Path path1 = Path();
    path1.moveTo(
        r1 * cos((pi * 2 / count) * 1), r1 * sin((pi * 2 / count) * 1));
    for (int i = 2; i <= count; i++) {
      path1.lineTo(r1 * cos(pi * 2 / count * i), r1 * sin(pi * 2 / count * i));
    }
    path1.close();

    Path path2 = Path();
    path2.moveTo(
        r2 * cos((pi * 2 / count) * 1), r2 * sin((pi * 2 / count) * 1));
    for (int i = 2; i <= count; i++) {
      path2.lineTo(r2 * cos(pi * 2 / count * i), r2 * sin(pi * 2 / count * i));
    }
    path2.close();
    Path path3 = Path();
    path3.moveTo(
        r3 * cos((pi * 2 / count) * 1), r3 * sin((pi * 2 / count) * 1));
    for (int i = 2; i <= count; i++) {
      path3.lineTo(r3 * cos(pi * 2 / count * i), r3 * sin(pi * 2 / count * i));
    }
    path3.close();
    canvas.rotate(pi * 2 / count / 2 + pi);
    var pms0 = path0.computeMetrics();
    var pm0 = pms0.first;
    canvas.drawPath(pm0.extractPath(0, progress.value * pm0.length), paint);
    // canvas.drawPath(path1, paint);
    // canvas.drawPath(path2, paint);

    var pms = path3.computeMetrics();
    var pm = pms.first;
    canvas.drawPath(
        pm.extractPath(0, progress.value * pm.length),
        paint
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);

    double w = (r1 - r0) * cos(pi * 2 - pi * 2 / count);
    double h = (r1 - r0) * sin(pi * 2 - pi * 2 / count);
    canvas.save();
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.blue);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.blue);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.blue, isPathLine: false);
    canvas.restore();
    canvas.save();
    canvas.rotate(pi * 2 / count * 2);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.red);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.red);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.red, isPathLine: false);
    canvas.restore();
    canvas.save();
    canvas.rotate(pi * 2 / count * 2 * 2);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.green);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.green);
    canvas.translate(-w, h);
    _drawLine(r0, r1, r3, count, canvas, path3, Colors.green,
        isPathLine: false);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LogoPainter oldDelegate) {
    // return progress != oldDelegate.progress;
    return false;
  }

  _drawLine(double r0, double r1, double r3, int count, Canvas canvas,
      Path path3, MaterialColor color,
      {bool isPathLine = true}) {
    Paint paint = Paint();
    // 正多变型边长
    double side3 = r3 * cos(pi * 2 / count) * 2;
    double side1 = r1 * cos(pi * 2 / count) * 2;
    Offset o1 =
        Offset(r1 * cos(pi * 2 / count * 4), r1 * sin(pi * 2 / count * 4));
    Offset o0 =
        Offset(r0 * cos(pi * 2 / count * 4), r0 * sin(pi * 2 / count * 4));
    Offset o2 =
        Offset(r0 * cos(pi * 2 / count * 3), r0 * sin(pi * 2 / count * 3));
    Path path4 = Path();
    path4.moveTo(o0.dx, o0.dy);
    path4.lineTo(o1.dx, o1.dy);
    path4.lineTo(o1.dx + side1 + 80, o1.dy);
    path4.relativeLineTo(0, (r1 - r0) * sin(pi * 2 / count));
    path4.close();

    Path p4 = Path.combine(PathOperation.intersect, path3, path4);
    if (progress.value >= 0.2 && progress.value <= 0.8) {
      canvas.save();
      canvas.clipPath(p4);
      Rect bodyRect0 = p4.getBounds();
      canvas.drawRect(
          Rect.fromLTWH(
              bodyRect0.left,
              bodyRect0.top,
              bodyRect0.width -
                  bodyRect0.width * (0.8 - progress.value) * 5 / 3,
              bodyRect0.height),
          paint
            ..color = color
            ..style = PaintingStyle.fill);
      canvas.restore();
    } else if (progress.value > 0.8) {
      canvas.drawPath(
          p4,
          paint
            ..color = color.withOpacity((1 - progress.value) * 5)
            ..style = PaintingStyle.fill);
    }

    double w = (r1 - r0) * cos(pi * 2 - pi * 2 / count);
    double h = (r1 - r0) * sin(pi * 2 - pi * 2 / count);
    Path path5 = Path();
    path5.moveTo(o0.dx, o0.dy);
    path5.lineTo(o1.dx, o1.dy);
    path5.lineTo(o2.dx - w, o2.dy + h);
    path5.lineTo(o2.dx, o2.dy);
    path5.close();

    if (progress.value <= 0.2) {
      canvas.save();
      canvas.clipPath(path5);
      Rect bodyRect = path5.getBounds();
      canvas.drawRect(
          Rect.fromPoints(
              bodyRect.bottomLeft, bodyRect.topRight * progress.value * 5),
          paint
            ..color = color.shade800
            ..style = PaintingStyle.fill);
      canvas.restore();
    } else {
      if (progress.value > 0.8) {
        canvas.drawPath(
            path5,
            paint
              ..color = color.shade800.withOpacity((1 - progress.value) * 5)
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawPath(
            path5,
            paint
              ..color = color.shade800
              ..style = PaintingStyle.fill);
      }
    }

    if (isPathLine) {
      Path pathLine = Path();
      pathLine.moveTo(o2.dx - w, o2.dy + h);
      pathLine.lineTo(o1.dx, o1.dy);
      pathLine.lineTo(o1.dx + side3, o1.dy);

      var pms = pathLine.computeMetrics();
      var pm = pms.first;
      canvas.drawPath(
          pm.extractPath(0, progress.value * pm.length * 5 / 4),
          paint
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2);
    }
  }
}
