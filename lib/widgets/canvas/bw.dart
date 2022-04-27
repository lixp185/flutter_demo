import 'package:flutter/material.dart';

import '../coordinate.dart';

class BwDemo extends StatefulWidget {
  const BwDemo({Key? key}) : super(key: key);

  @override
  _BwDemoState createState() => _BwDemoState();
}

class _BwDemoState extends State<BwDemo> with SingleTickerProviderStateMixin {
  // late Animation<double> animation;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        size: Size(60,60),
        painter: _BwPainter(_controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _BwPainter extends CustomPainter {
  Coordinate coordinate = Coordinate(setP: 20);
  double waveWidth = 50; //波的宽度
  double waveHeight = 6; //波的高度
  double wrapHeight = 80; //包裹

  final Animation<double> repaint;

  _BwPainter(this.repaint) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);
    canvas.clipRect(Offset.zero & size);
    // canvas.clipRect(Rect.fromCenter(center: Offset(waveWidth, 0), width: waveWidth * 2, height: 160));
    // canvas.clipPath(Path()..addOval(Rect.fromCenter(center: Offset(waveWidth,
    //     0), width: waveWidth * 2, height: waveWidth * 2)));
    canvas.clipPath(Path()
      ..addOval(Rect.fromCenter(
          center: Offset(waveWidth, 0),
          width: waveWidth * 2,
          height: waveWidth * 2)));
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(-waveWidth * 3, 0);
    Path path = getWavePath();
    path.close();

    canvas.translate(0, (wrapHeight / 2 + waveHeight)*0.6);

    canvas.translate(waveWidth * 2 * repaint.value - waveWidth, 0);
    canvas.drawPath(path, paint..color = Colors.orange.withOpacity(0.4));
    canvas.translate(waveWidth * 2 * repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange);

    canvas.restore();

    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(waveWidth, 0),
            width: waveWidth * 2-2,
            height: waveWidth * 2-2),
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth =2
          ..color = Colors.orange);
  }

  Path getWavePath() {
    Path path = Path();
    path.moveTo(0, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);

    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);

    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);

    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);

    path.relativeLineTo(0, wrapHeight * 2);
    path.relativeLineTo(-waveWidth * 3 * 2.0, 0);
    return path;
  }

  @override
  bool shouldRepaint(covariant _BwPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
