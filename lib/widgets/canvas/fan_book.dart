import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../coordinate.dart';

// 翻页效果demo
class FanBook extends StatefulWidget {
  const FanBook({Key? key}) : super(key: key);

  @override
  _FanBookState createState() => _FanBookState();
}

class _FanBookState extends State<FanBook> with TickerProviderStateMixin {
  Size size = Size(300, 600);

  Point<double> currentA = Point(0, 0);
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
          print("_controller.value ${_controller.value}");

          /// 不翻页 回到原始位置
          p.value = PaperPoint(
              Point(
                currentA.x + (size.width / 2 - currentA.x) * _controller.value,
                currentA.y + (size.height / 2 - currentA.y) * _controller
                    .value,
              ),
              size);
          /// 翻页
          ///
          ///
          // p.value = PaperPoint(
          //     Point(
          //       currentA.x - (currentA.x - ) * _controller.value,
          //       currentA.y + (size.height / 2 - currentA.y) * _controller
          //           .value,
          //     ),
          //     size);



        });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      p.value = PaperPoint(Point(size.width / 2, -size.height / 2), size);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ValueNotifier<PaperPoint> p =
      ValueNotifier(PaperPoint(Point(0, 0), Size(0, 0)));

  // 定义上一页、当前页、下一页
  @override
  Widget build(BuildContext context) {
    size = Size(MediaQuery.of(context).size.width - 40, 600);
    return Container(
      // color: Colors.blue,
      // width: double.infinity,
      child: GestureDetector(
        child: CustomPaint(
          size: size,
          painter: _BookPainter(
            p,
          ),
        ),
        onPanDown: (d) {
          var down =
              d.localPosition.translate(-size.width / 2, -size.height / 2);
          p.value = PaperPoint(Point(down.dx, down.dy), size);

          currentA = Point(down.dx, down.dy);
        },
        onPanUpdate: (d) {
          var move =
              d.localPosition.translate(-size.width / 2, -size.height / 2);
          // 临界值取消更新
          if (move.dx >= size.width / 2 || move.dy >= size.height / 2) {
            return;
          }
          print("move ${move.dy}");
          currentA = Point(move.dx, move.dy);
          p.value = PaperPoint(Point(move.dx, move.dy), size);
        },
        onPanEnd: (d) {
          _controller.forward(from: 0);
          // p.value = PaperPoint(Point(size.width/2, size.height/2),
          //     Point(size.width / 2, size.height / 2));
        },
      ),
    );
  }
}

class _BookPainter extends CustomPainter {
  ValueNotifier<PaperPoint> p;

  _BookPainter(this.p) : super(repaint: p);

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // coordinate.paintT(canvas, size);

    Path mPathA = Path();
    // 定义书的右下角
    // mPath0.addRect(Rect.fromLTRB(
    //   -size.width / 2,
    //   -size.height / 2,
    //   p.value.f.x,
    //   p.value.f.y,
    // ));
    //
    // mPathA.moveTo(p.value.c.x, p.value.c.y);
    // mPathA.lineTo(p.value.j.x, p.value.j.y);
    //
    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.e.x, p.value.e.y);
    //
    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.h.x, p.value.h.y);
    //
    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.f.x, p.value.f.y);
    //
    // mPathA.moveTo(p.value.e.x, p.value.e.y);
    // mPathA.lineTo(p.value.h.x, p.value.h.y);
    //
    // mPathA.moveTo(p.value.e.x, p.value.e.y);
    // mPathA.lineTo(
    //     (p.value.c.x + p.value.b.x) / 2, (p.value.c.y + p.value.b.y) / 2);
    //
    // mPathA.moveTo(p.value.h.x, p.value.h.y);
    // mPathA.lineTo(
    //     (p.value.j.x + p.value.k.x) / 2, (p.value.j.y + p.value.k.y) / 2);
    Path mPathC;
    Path mPath = Path();
    mPath.addRect(Rect.fromCenter(
        center: Offset.zero, width: size.width, height: size.height));

    if (p.value.a != p.value.f) {
      mPathA.moveTo(p.value.c.x, p.value.c.y);
      mPathA.quadraticBezierTo(
          p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
      mPathA.lineTo(p.value.a.x, p.value.a.y);
      mPathA.lineTo(p.value.k.x, p.value.k.y);
      mPathA.quadraticBezierTo(
          p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
      mPathA.lineTo(p.value.f.x, p.value.f.y);

      mPathA.close();

      canvas.drawPath(mPathA, paint..color = Colors.yellow);

      Path mPath1 = Path();
      mPath1.moveTo(p.value.d.x, p.value.d.y);
      mPath1.lineTo(p.value.a.x, p.value.a.y);
      mPath1.lineTo(p.value.i.x, p.value.i.y);
      mPath1.close();

      mPathC = Path.combine(PathOperation.reverseDifference, mPathA, mPath);
      canvas.drawPath(mPathC, paint..color = Colors.grey);

      if (!p.value.b.x.isNaN) {
        Path mPathB = Path.combine(PathOperation.intersect, mPathA, mPath1);
        canvas.drawPath(mPathB, paint..color = Colors.yellow.shade700);
      }
    } else {

      canvas.drawPath(mPath, paint..color = Colors.grey);
    }

    // canvas.drawPath(mPathC, paint);

    //
    // canvas.drawRect(
    //     Rect.fromCenter(
    //         center: Offset.zero, width: size.width, height: size.height),
    //     paint..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant _BookPainter oldDelegate) {
    return oldDelegate.p != p;
  }
}

class PaperPoint {
  //手指拉拽点 已知
  Point<double> a;

  //右下角的点 已知
  late Point<double> f;

  //
  // //贝塞尔点(e为控制点)
  late Point<double> b, c, d, e;

  // //贝塞尔点(h为控制点)
  late Point<double> h, i, j, k;

  //eh实际为af中垂线，g为ah和af的交点
  late Point<double> g;

  late Size size;

  PaperPoint(this.a, this.size) {
    //每个点的计算公式
    f = Point(size.width / 2, size.height / 2);
    g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
    //


    e = Point(g.x - (pow(f.y - g.y, 2) / (f.x - g.x)), f.y);
    double cx = e.x - (f.x - e.x) / 2;

    if (cx <= -size.width / 2) {
      //   // 临界点
      double w0 = f.x - cx;
      double w1 = f.x - a.x;

      double w2 = size.width * w1 / w0;

      double h1 = f.y - a.y;
      double h2 = w2 * h1 / w1;

      a = Point(f.x - w2, f.y - h2);

      g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
      e = Point(g.x - (pow((f - g).y, 2) / (f - g).x), f.y);

      cx = -size.width / 2;
    }

    c = Point(cx, f.y);

    h = Point(f.x, g.y - (pow((f - g).x, 2) / (f.y - g.y)));

    j = Point(f.x, h.y - (f.y - h.y) / 2);

    double k1 = towPointKb(c, j);
    double b1 = towPointKb(c, j, isK: false);

    double k2 = towPointKb(a, e);
    double b2 = towPointKb(a, e, isK: false);

    print("k2:    $k2   ${a.x} ${a.y} ${e.x} ${a.y} ");
    double k3 = towPointKb(a, h);
    double b3 = towPointKb(a, h, isK: false);

    b = Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
    k = Point((b3 - b1) / (k1 - k3), (b3 - b1) / (k1 - k3) * k1 + b1);

    d = Point(((c.x + b.x) / 2 + e.x) / 2, ((c.y + b.y) / 2 + e.y) / 2);

    i = Point(((j.x + k.x) / 2 + h.x) / 2, ((j.y + k.y) / 2 + h.y) / 2);
  }

  /// 两点求直线方程
  double towPointKb(Point<double> p1, Point<double> p2, {bool isK = true}) {
    /// 求得两点斜率
    double k = 0;
    double b = 0;
    // 防止除数 = 0 出现的计算错误 a e x轴重合

    if (p1.x == p2.x) {
      k = (p1.y - p2.y) / (p1.x - p2.x - 1);
    } else {
      k = (p1.y - p2.y) / (p1.x - p2.x);
    }
    b = p1.y - k * p1.x;
    if (isK)
      return k;
    else
      return b;
  }
}
