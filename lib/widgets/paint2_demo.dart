import 'dart:math';
import 'package:flutter/material.dart';

/// 动画绘制结合
class Pain2Painter extends CustomPainter {
  final Color color; // 颜色
  final Animation<double> angle; // 吃豆人
  final Animation<double> angle2; // 豆

  final Listenable listenable;

  Pain2Painter(this.color, this.angle, this.angle2, this.listenable)
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint();

    // 画豆豆
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width / 2 - angle2.value * size.width / 2, 0),
            width: 8,
            height: 8),
        paint..color = Colors.redAccent.shade400);
    canvas.drawOval(
        Rect.fromCenter(
            center:
                Offset(size.width / 2 - angle2.value * size.width / 2 + 20, 0),
            width: 8,
            height: 8),
        paint..color = Colors.redAccent.shade400);
    canvas.drawOval(
        Rect.fromCenter(
            center:
                Offset(size.width / 2 - angle2.value * size.width / 2 + 40, 0),
            width: 8,
            height: 8),
        paint..color = Colors.redAccent.shade400);

    //画头
    paint
      ..color = color
      ..style = PaintingStyle.fill;
    var rect = Rect.fromCenter(
        center: Offset(0, 0), width: size.width, height: size.height);

    /// 起始角度
    var a = angle.value * 40 / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a * 2, true, paint);
    //画眼睛
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(0, -size.height / 3), width: 8, height: 8),
        paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant Pain2Painter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }
}
