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

  ValueNotifier<PaperPoint> p = ValueNotifier(PaperPoint(
    Point(0, 0),
    Point(200, 200),
  ));

  Size size = Size(300, 400);

  // 定义上一页、当前页、下一页
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
        // width: double.infinity,
        child: GestureDetector(
          child: CustomPaint(
            size: size,
            painter: _BookPainter(
              _controller,
              p,
            ),
          ),
          onPanDown: (d) {
            // _controller.forward(from: 0);
            var down =
                d.localPosition.translate(-size.width / 2, -size.height / 2);

            p.value = PaperPoint(Point(down.dx, down.dy),
                Point(size.width / 2, size.height / 2));

            print("xxxxx${down.dx}  ${down.dy}");
            print("eeeee ${p.value.e.x}  ${p.value.e.y}");
          },
        ));
  }
}

class _BookPainter extends CustomPainter {
  Animation<double> animation;
  ValueNotifier<PaperPoint> p;

  _BookPainter(this.animation, this.p) : super(repaint: p);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path mPath0 = Path();
    // 定义书的右下角
    // mPath0.addRect(Rect.fromLTRB(
    //   -size.width / 2,
    //   -size.height / 2,
    //   p.value.f.x,
    //   p.value.f.y,
    // ));

    mPath0.lineTo(p.value.e.x, p.value.e.y);
    mPath0.lineTo(p.value.c.x, p.value.c.y);
    // mPath0.quadTo(hx, hy, kx, ky);
    // mPath0.lineTo(ax, ay);
    // mPath0.lineTo(bx, by);
    // mPath0.quadTo(ex, ey, cx, cy);
    // mPath0.lineTo(fx, fy);
    mPath0.close();

    canvas.drawPath(mPath0, paint);

    // canvas.drawPath(Path.combine(PathOperation.difference, path, path2),
    //     paint..color = Colors.yellow.shade700);
  }

  @override
  bool shouldRepaint(covariant _BookPainter oldDelegate) {
    return oldDelegate.p != p;
  }
}

class PaperPoint {
  //手指拉拽点 已知
  final Point<double> a;

  //右下角的点 已知
  final Point<double> f;

  //
  // //贝塞尔点(e为控制点)
  late Point<double> b, c, d, e;

  // //贝塞尔点(h为控制点)
  late Point<double> h, i, j, k;

  //eh实际为af中垂线，g为ah和af的交点
  late Point<double> g;

  PaperPoint(this.a, this.f) {
    //每个点的计算公式
    g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
    //
    e = Point(g.x - (pow((f.y - g.y), 2) / (f.x - g.x)), f.y);

    c = Point(e.x - (f.x - e.x) / 2, f.y);


  }
}
