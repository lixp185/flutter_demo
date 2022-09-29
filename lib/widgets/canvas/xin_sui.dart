import 'dart:math';

import 'package:flutter/material.dart';

/// 心碎的感觉
class XinSui extends StatefulWidget {
  const XinSui({Key? key}) : super(key: key);

  @override
  _XinSuiState createState() => _XinSuiState();
}

class _XinSuiState extends State<XinSui> with SingleTickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 4000))
        ..repeat();
  late CurvedAnimation cure =
      CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(cure);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: _XinSuiPainter(animation),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _XinSuiPainter extends CustomPainter {
  Animation<double> animation;

  _XinSuiPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.black87;
    Path path = Path();
    path.moveTo(0, 0);
    path.cubicTo(-200, -80, -60, -240, 0, -140);
    path.relativeLineTo(-10, 30);
    path.relativeLineTo(20, 5);
    path.relativeLineTo(-20, 30);
    path.relativeLineTo(20, 20);
    path.relativeLineTo(-10, 20);
    path.relativeLineTo(10, 10);
    path.close();
    Path path2 = Path();
    canvas.save();
    canvas.rotate(-pi / 4 * animation.value);
    canvas.drawPath(
        path,
        paint
          ..color = Colors.red
          ..color = Color.fromRGBO(
              255 - (86 * animation.value).toInt(),
              (animation.value * 169).toInt(),
              (animation.value * 169).toInt(),
              1)
          ..style = PaintingStyle.fill);
    canvas.restore();
    path2.cubicTo(200, -80, 60, -240, 0, -140);
    path2.relativeLineTo(-10, 30);
    path2.relativeLineTo(20, 5);
    path2.relativeLineTo(-20, 30);
    path2.relativeLineTo(20, 20);
    path2.relativeLineTo(-10, 20);
    path2.relativeLineTo(10, 10);
    path2.close();
    canvas.rotate(pi / 4 * animation.value);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant _XinSuiPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}
