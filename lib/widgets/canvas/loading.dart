import 'package:flutter/material.dart';

class LoadingDemo extends StatefulWidget {
  const LoadingDemo({Key? key}) : super(key: key);

  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class _LoadingDemoState extends State<LoadingDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500))
    ..repeat(reverse: true); //1s;

  // 控制器
  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

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

    /// 0..1

    canvas.drawCircle(Offset(0, 20 * animation.value), 5, _paint);

    /// 线性渐变
    /// 0.2 - 1 - 0.8 => 0..1
    //     0- 0.8 - 1

    /// 0.8 - 0 - 0.2 => 1..0

    // 1  -  0.2 - 0
    canvas.drawCircle(Offset(20, 20 * (1-animation.value)), 5, _paint);

    // else {
    //   canvas.drawCircle(Offset(20, 20 * (animation.value - 0.2)), 5, _paint);
    // }
    //
    // /// 0.4 - 1 - 0.6
    // canvas.drawCircle(Offset(40, 10 * (animation.value)), 5, _paint);
    //
    // /// 0.6 - 1 - 0.4
    // canvas.drawCircle(Offset(60, 10 * (1 - animation.value)), 5, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
