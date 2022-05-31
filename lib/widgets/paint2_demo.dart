import 'dart:math';
import 'package:flutter/material.dart';

/// 动画绘制结合
class Pain2Painter extends CustomPainter {
  final ValueNotifier<Color> color; // 吃豆人的颜色
  final ValueNotifier<Color> color2; // 豆子的的颜色
  final Animation<double> angle; // 吃豆人
  final Animation<double> angle2; // 豆
  final Listenable listenable;
  final double ddSize; // 豆豆大小


  Pain2Painter(
      this.color, this.color2, this.angle, this.angle2, this.listenable,
      {this.ddSize = 6})
      : super(repaint: listenable);
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    // 画豆豆
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(
                size.width / 2 +
                    ddSize -
                    angle2.value * (size.width / 2 + ddSize),
                0),
            width: ddSize,
            height: ddSize),
        _paint..color = color2.value);
    //画头
    _paint
      ..color = color.value
      ..style = PaintingStyle.fill;

    var rect = Rect.fromCenter(
        center: Offset(0, 0), width: size.width, height: size.height);

    /// 起始角度
    /// angle.value 动画控制器的值 0.2~1 0是完全闭合就是 起始0~360° 1是完全张开 起始 40°~ 280° 顺时针
    var a = angle.value * 40 / 180 * pi;
    // 绘制圆弧
    canvas.drawArc(rect, a, 2 * pi - a * 2, true, _paint);
    //画眼睛
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(0, -size.height / 3), width: 8, height: 8),
        _paint..color = Colors.black87);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(-1.5, -size.height / 3 - 1.5), width: 3, height: 3),
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant Pain2Painter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }
}
