import 'package:flutter/material.dart';

class LoadingDemo extends StatefulWidget {
  const LoadingDemo({Key? key}) : super(key: key);

  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class LtCurve extends Curve {
  LtCurve._();

  @override
  double transformInternal(double t) {
    double g = 9.8;
    // h =1/2 * g * t * t
    // return g * (t * 2) * (t * 2) / 2;
    return t;
  }
}

class _LoadingDemoState extends State<LoadingDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000))
    ..repeat(); //1s;

  late CurvedAnimation cure =
      CurvedAnimation(parent: _controller, curve: LtCurve._());

  // 控制器
  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(cure);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: _LoadingPaint(animation),
      ),
    );
  }
}

class _LoadingPaint extends CustomPainter {
  Animation<double> animation;

  _LoadingPaint(this.animation) : super(repaint: animation);

  Paint _paint = Paint()
    ..color = Colors.black54
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(Offset(0, 100 * animation.value), 10, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}