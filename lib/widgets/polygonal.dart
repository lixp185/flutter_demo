import 'dart:math';
import 'package:flutter/material.dart';
enum Type {
  angle, // 角
  side, // 边
  all, // 都有
}

/// 角 边 型
class Polygonal extends StatelessWidget {
  final double size; // 组件大小
  final double? bigR; // 大圆半径
  final double? smallR; // 小圆半径
  final int count; // 几边形
  final Type type; // 五角星or五边形
  final bool isFill; // 是否填充
  final Color color; // 颜色

  const Polygonal(
      {Key? key,
      this.size = 80,
      this.bigR,
      this.smallR,
      this.count = 3,
      this.type = Type.angle,
      this.isFill = false,
      this.color = Colors.black87})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _PolygonalPainter(bigR, smallR,
          color: color, count: count, type: type, isFill: isFill),
    );
  }
}

class _PolygonalPainter extends CustomPainter {
  final double? bigR;
  final double? smallR;
  final int count; // 几边形
  final Type type; // 五角星or五边形
  final bool isFill; // 是否填充
  final Color color; // 颜色
  _PolygonalPainter(this.bigR, this.smallR,
      {required this.count,
      required this.type,
      required this.isFill,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint2 = Paint()
      ..color = color
      ..strokeJoin = StrokeJoin.round
      ..style = isFill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2;
    double r = bigR ?? size.width / 2 / 2;
    double r2 = smallR ?? size.width / 2 / 2 - 12;
    // 将圆等分
    Path path = Path();
    canvas.rotate(pi / count + pi / 2 * 3);
    path.moveTo(r * cos(pi / count), r * sin(pi / count));

    /// 绘制角
    if (type == Type.angle || type == Type.all) {
      for (int i = 2; i <= count * 2; i++) {
        if (i.isEven) {
          path.lineTo(r2 * cos(pi / count * i), r2 * sin(pi / count * i));
        } else {
          path.lineTo(r * cos(pi / count * i), r * sin(pi / count * i));
        }
      }
      path.close();
      canvas.drawPath(path, paint2);
    }

    /// 绘制边
    if (type == Type.side || type == Type.all) {
      path.reset();
      path.moveTo(r * cos(pi / count), r * sin(pi / count));
      for (int i = 2; i <= count * 2; i++) {
        if (i.isOdd) {
          path.lineTo(r * cos(pi / count * i), r * sin(pi / count * i));
        }
      }
      path.close();
      canvas.drawPath(path, paint2);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
