import 'dart:math';

import 'package:flutter/material.dart';

class QiPao extends StatelessWidget {
  final String text;

  const QiPao({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(60, 60),
        painter: QiPaoPainter(text),
      ),
    );
  }
}

class QiPaoPainter extends CustomPainter {
  final String text;

  QiPaoPainter(this.text);

  @override
  void paint(Canvas canvas, Size size) {
    // 原点移到左下角
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    Path path = Path();
    // 绘制文字

    path.lineTo(0, -size.width / 2);
    // path.conicTo(33, -28, 20, 0, 1);

    path.arcToPoint(Offset(size.width / 2, 0),
        radius: Radius.circular(size.width / 2),
        largeArc: true,
        clockwise: true);
    path.close();
    var bounds = path.getBounds();
    canvas.save();
    canvas.translate(-bounds.width / 2, bounds.height / 2);
    canvas.rotate(pi * 1.2);
    canvas.drawPath(path, paint);
    canvas.restore();
    // 绘制文字
    var textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 24,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..color = Colors.white,
            )),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    canvas.translate(-size.width, -size.height / 2);
    textPainter.paint(canvas, Offset(-size.width / 2.4, size.height / 1.2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
