import 'dart:math';

import 'package:flutter/material.dart';

import '../coordinate.dart';

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

  Size size = Size(300, 600);

  // 定义上一页、当前页、下一页
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.blue,
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

          },
          onPanUpdate: (d){
            var down = d.localPosition.translate(-size.width / 2, -size.height / 2);

            if(down.dx>size.width/2 ||down.dy>size.height/2){
              return;
            }
            p.value = PaperPoint(Point(down.dx, down.dy),
                Point(size.width / 2, size.height / 2));
          },
          onPanEnd: (d){
            // p.value = PaperPoint(Point(size.width/2, size.height/2),
            //     Point(size.width / 2, size.height / 2));
          },
        ));
  }
}

class _BookPainter extends CustomPainter {
  Animation<double> animation;
  ValueNotifier<PaperPoint> p;

  _BookPainter(this.animation, this.p) : super(repaint: p);

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    Path mPath0 = Path();
    // 定义书的右下角
    // mPath0.addRect(Rect.fromLTRB(
    //   -size.width / 2,
    //   -size.height / 2,
    //   p.value.f.x,
    //   p.value.f.y,
    // ));


    //
    // mPath0.moveTo(p.value.c.x, p.value.c.y);
    //
    // mPath0.lineTo(p.value.c.x, p.value.c.y);
    // mPath0.lineTo(p.value.j.x, p.value.j.y);
    //
    // mPath0.moveTo(p.value.a.x, p.value.a.y);
    //
    // mPath0.lineTo(p.value.a.x, p.value.a.y);
    // mPath0.lineTo(p.value.e.x, p.value.e.y);

    mPath0.moveTo(p.value.c.x, p.value.c.y);
    mPath0.quadraticBezierTo(p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
    mPath0.lineTo(p.value.a.x, p.value.a.y);
    mPath0.lineTo(p.value.k.x, p.value.k.y);
    mPath0.quadraticBezierTo(p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
    mPath0.lineTo(p.value.f.x, p.value.f.y);
    // mPath0.lineTo(p.value.e.x, p.value.e.y);
    // mPath0.lineTo(p.value.b.x, p.value.b.y);
    // mPath0.lineTo(100, 100);
    mPath0.close();


    Path mPath1 = Path();
    mPath1.moveTo(p.value.d.x, p.value.d.y);
    mPath1.lineTo(p.value.a.x,p.value.a.y);
    mPath1.lineTo(p.value.i.x,p.value.i.y);
    mPath1.close();
    canvas.drawPath(mPath0, paint..color = Colors.red);

    // Path mPath = Path();
    // mPath.addRect(Rect.fromCenter(center: Offset.zero, width: size.width, height: size.height));
    var mPath3 = Path.combine(PathOperation.intersect, mPath0, mPath1);
    canvas.drawPath(mPath3,
        paint..color = Colors.yellow.shade700);
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

    h = Point(f.x, g.x - (pow((f.x - g.x), 2) / (f.y - g.y)));

    c = Point(e.x - (f.x - e.x) / 2, f.y);

    j = Point(f.x, h.y - (f.y - h.y) / 2);


    double k1 = towPointKb(c, j);
    double b1 = towPointKb(c, j, isK: false);

    double k2 = towPointKb(a, e);
    double b2 = towPointKb(a, e, isK: false);

    double k3 = towPointKb(a, h);
    double b3 = towPointKb(a, h, isK: false);


    b = Point((b2 - b1)/(k1 - k2) , (b2 - b1) / (k1 - k2) * k1 + b1);
    k = Point((b3 - b1)/(k1 - k3) , (b3 - b1) / (k1 - k3) * k1 + b1);
    if(k2>k1 || k.y>b.y){
      b = Point(a.x, a.y);
      k = Point(a.x, a.y);
    }


    d = Point(((c.x+b.x)/2+e.x)/2,((c.y+b.y)/2+e.y)/2 );
    i = Point(((j.x+k.x)/2+h.x)/2,((j.y+k.y)/2+h.y)/2 );


  }

  /// 两点求直线方程
  double towPointKb(Point<double> p1, Point<double> p2, {bool isK = true}) {
    /// 求得两点斜率
    double k = 0;
    double b = 0;
    k = (p1.y - p2.y) / (p1.x - p2.x);
    b = p1.y - k * p1.x;
    print("zzzz${p1.y} ${p2.y}");
    print("k $k");
    print("b $b");
    if (isK)
      return k;
    else
      return b;
  }
}
