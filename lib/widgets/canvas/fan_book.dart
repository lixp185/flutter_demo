import 'dart:math';

import 'package:flutter/material.dart';

// 翻页效果demo
class FanBook extends StatefulWidget {
  const FanBook({Key? key}) : super(key: key);

  @override
  _FanBookState createState() => _FanBookState();
}

class _FanBookState extends State<FanBook> with TickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
        ..addStatusListener((status) {
          // dismissed	动画在起始点停止
          // forward	动画正在正向执行
          // reverse	动画正在反向执行
          // completed	动画在终点停止
          if (status == AnimationStatus.completed) {
            _controller2.forward();
          }
        });
  late AnimationController _controller2 =
      AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
  late CurvedAnimation cure =
      CurvedAnimation(parent: _controller2, curve: Curves.easeIn);
  late Animation<double> animation4 =
      Tween(begin: 0.0, end: pi).animate(_controller2);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  PaperPoint? _paperPoint;

  // 定义上一页、当前页、下一页
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: GestureDetector(
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: _BookPainter(_controller),
          ),
          onPanDown: (d) {
            _controller.forward(from: 0);
            _paperPoint = PaperPoint(
                Point(d.localPosition.dx, d.localPosition.dy), Point(1, 1));
          },
        ));
  }
}

class _BookPainter extends CustomPainter {
  Animation<double> animation;

  _BookPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Path path = Path();
    Path path2 = Path();
    // 定义书的右下角
    path.addOval(Rect.fromCircle(center: Offset(-20, 0), radius: 50));
    path2.addOval(Rect.fromCircle(center: Offset(20, 0), radius: 50));

    canvas.drawPath(Path.combine(PathOperation.difference, path, path2),
        paint..color = Colors.yellow.shade700);
  }

  @override
  bool shouldRepaint(covariant _BookPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

class PaperPoint {
  //拉拽点
  final Point a;

  //右下角的点
  final Point f;

  //
  // //贝塞尔点(e为控制点)
   Point? c, d, b, e;
  //
  // //贝塞尔点(h为控制点)
   Point? i, j, k, h;

  //eh实际为af中垂线，g为ah和af的交点
  Point? g;

  PaperPoint(this.a, this.f) {
//每个点的计算公式
    g = Point(a.x + f.x / 2, (a.y + f.y) / 2);
  }
}
