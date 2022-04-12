import 'dart:math';

import 'package:flutter/material.dart';

class CurveBoxPainter extends CustomPainter {
  final Animation<double> repaint;
  Animation<double> angleAnimation;
  final Listenable listenable;
  Paint _paint = Paint();

  CurveBoxPainter(this.repaint, this.angleAnimation, this.listenable)
      : super(repaint: listenable);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawRing(canvas, size);
    _drawRedCircle(canvas, size);
    _drawGreenCircle(canvas, size);
  }

  //绘制环
  void _drawRing(Canvas canvas, Size size) {
    final double strokeWidth = 5;
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(Offset.zero, size.width / 2 - strokeWidth, _paint);
  }

  // 绘制红球
  void _drawRedCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(angleAnimation.value * 2 * pi);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }

  // 绘制绿球
  void _drawGreenCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, repaint.value * (size.height - 10));
    _paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CurveBoxPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
