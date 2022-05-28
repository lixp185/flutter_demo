import 'package:flutter/material.dart';

import 'coordinate.dart';

/// 夏天 吃瓜群众
class Summer extends StatefulWidget {
  const Summer({Key? key}) : super(key: key);

  @override
  _SummerState createState() => _SummerState();
}

class _SummerState extends State<Summer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        // size: Size(100, 100),
        size: Size(double.infinity,double.infinity),
        painter: _GuaPainter(),
      ),
    );
  }
}

class _GuaPainter extends CustomPainter {

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..isAntiAlias = true;

    Path path = Path();

    path.cubicTo(100, 100, 100, 200, 50, 50);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
