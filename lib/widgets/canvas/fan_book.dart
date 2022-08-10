import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/toast_util.dart';

import '../coordinate.dart';

// 翻页效果demo
class FanBook extends StatefulWidget   {
  const FanBook({Key? key}) : super(key: key);

  @override
  _FanBookState createState() => _FanBookState();
}

class _FanBookState extends State<FanBook> with TickerProviderStateMixin {
  Size size = Size(300.0, 500.0);

  Point<double> currentA = Point(0, 0);
  late AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 800))
    ..addListener(() {
      if (isNext) {
        /// 翻页
        _p.value = PaperPoint(
            Point(currentA.x - (currentA.x + size.width) * _controller.value,
                currentA.y + (size.height - currentA.y) * _controller.value),
            size);
      } else {
        /// 不翻页 回到原始位置
        _p.value = PaperPoint(
            Point(
              currentA.x + (size.width - currentA.x) * _controller.value,
              currentA.y + (size.height - currentA.y) * _controller.value,
            ),
            size);
      }
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (isNext) {
          setState(() {
            currentIndex++;
          });
        }
      }
      if (status == AnimationStatus.dismissed) {
        //起点停止
        print("起点停止");
      }
    });

  @override
  void initState() {
    super.initState();
    // build完毕初始化首页
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _p.value = PaperPoint(Point(size.width, size.height), size);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isNext = true; // 是否翻页到下一页
  // 控制点类
  ValueNotifier<PaperPoint> _p =
      ValueNotifier(PaperPoint(Point(0, 0), Size(0, 0)));

  // 定义数据
  List<String> dataList = [
    "第一页数据",
    "第二页数据",
    "第三页数据",
  ];

  // 当前页码
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - kToolbarHeight - 38 - 100);
    return Column(
      children: [
        Container(
          width: size.width,
          child: GestureDetector(
            child: Stack(
              children: [
                currentIndex == dataList.length - 1
                    ? SizedBox()
                    // 下一页
                    : ClipPath(
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.blue,
                          width: size.width,
                          height: size.height,
                          child: Text(
                            dataList[currentIndex + 1],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                // // 当前页
                ClipPath(
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    height: size.height,
                    color: Colors.blue,
                    child: Text(
                      dataList[currentIndex],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  clipper: CurrentPaperClipPath(_p),
                ),

                CustomPaint(
                  size: size,
                  painter: _BookPainter(
                    _p,
                  ),
                ),
              ],
            ),
            onPanDown: (d) {
              if (currentIndex == dataList.length - 1) {
                ToastUtil.show("最后一页了");
                return;
              }
              isNext = false;
              var down = d.localPosition;
              _p.value = PaperPoint(Point(down.dx, down.dy), size);
              currentA = Point(down.dx, down.dy);
            },
            onPanUpdate: currentIndex == dataList.length - 1
                ? null
                : (d) {
                    var move = d.localPosition;

                    // 临界值取消更新
                    if (move.dx >= size.width ||
                        move.dx < 0 ||
                        move.dy >= size.height ||
                        move.dy < 0) {
                      return;
                    }
                    currentA = Point(move.dx, move.dy);
                    _p.value = PaperPoint(Point(move.dx, move.dy), size);

                    if ((size.width - move.dx) / size.width > 1 / 3) {
                      isNext = true;
                    } else {
                      isNext = false;
                    }
                  },
            onPanEnd: currentIndex == dataList.length - 1
                ? null
                : (d) {
                    _controller.forward(
                      from: 0,
                    );
                  },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                currentA = Point(-100, size.height - 100);
                currentIndex--;
                isNext = false;
              });
              // _p.value = PaperPoint(currentA, size);
              _controller.forward(
                from: 0,
              );
            },
            child: Text("上一页"))
      ],
    );
  }
}

/// 当前页区域
class CurrentPaperClipPath extends CustomClipper<Path> {
  ValueNotifier<PaperPoint> p;

  CurrentPaperClipPath(
    this.p,
  ) : super(reclip: p);

  @override
  Path getClip(Size size) {
    ///书籍区域
    Path mPath = Path();
    mPath.addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height));

    Path mPathA = Path();
    if (p.value.a != p.value.f && p.value.a.x > -size.width) {
      print("当前页 ${p.value.a}  ${p.value.f}");
      mPathA.moveTo(p.value.c.x, p.value.c.y);
      mPathA.quadraticBezierTo(
          p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
      mPathA.lineTo(p.value.a.x, p.value.a.y);
      mPathA.lineTo(p.value.k.x, p.value.k.y);
      mPathA.quadraticBezierTo(
          p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
      mPathA.lineTo(p.value.f.x, p.value.f.y);
      mPathA.close();
      Path mPathC =
          Path.combine(PathOperation.reverseDifference, mPathA, mPath);
      return mPathC;
    }

    return mPath;
  }

  @override
  bool shouldReclip(covariant CurrentPaperClipPath oldClipper) {
    return p != oldClipper.p;
  }
}

class _BookPainter extends CustomPainter {
  ValueNotifier<PaperPoint> p;

  _BookPainter(this.p) : super(repaint: p);

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    // coordinate.paintT(canvas, size);
    canvas.restore();

    /// 辅助线
    Path mPathAB = Path();

    // 定义书的右下角

    // mPathA.moveTo(p.value.c.x, p.value.c.y);
    // mPathA.lineTo(p.value.j.x, p.value.j.y);
    //
    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.e.x, p.value.e.y);
    //
    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.h.x, p.value.h.y);

    // mPathA.moveTo(p.value.a.x, p.value.a.y);
    // mPathA.lineTo(p.value.f.x, p.value.f.y);
    //
    // mPathA.moveTo(p.value.e.x, p.value.e.y);
    // mPathA.lineTo(p.value.h.x, p.value.h.y);

    // mPathA.moveTo(p.value.e.x, p.value.e.y);
    // mPathA.lineTo(
    //     (p.value.c.x + p.value.b.x) / 2, (p.value.c.y + p.value.b.y) / 2);
    //
    // mPathA.moveTo(p.value.h.x, p.value.h.y);
    // mPathA.lineTo(
    //     (p.value.j.x + p.value.k.x) / 2, (p.value.j.y + p.value.k.y) / 2);

    // canvas.drawPath(mPathA, paint..color = Colors.red);

    ///书籍区域
    Path mPath = Path();
    mPath.addRect(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height));

    /// A区域 下一页可见区域+当前页不可见区域  af重合 不需要绘制A区域
    if (p.value.a != p.value.f) {
      if (p.value.a.y == p.value.f.y) {
        // canvas.drawPath(mPath, paint..color = Colors.yellow);
        /// 翻页完毕
      } else {
        mPathAB.moveTo(p.value.c.x, p.value.c.y);
        mPathAB.quadraticBezierTo(
            p.value.e.x, p.value.e.y, p.value.b.x, p.value.b.y);
        mPathAB.lineTo(p.value.a.x, p.value.a.y);
        mPathAB.lineTo(p.value.k.x, p.value.k.y);
        mPathAB.quadraticBezierTo(
            p.value.h.x, p.value.h.y, p.value.j.x, p.value.j.y);
        mPathAB.lineTo(p.value.f.x, p.value.f.y);

        mPathAB.close();
        Path mPath1 = Path();
        mPath1.moveTo(p.value.d.x, p.value.d.y);
        mPath1.lineTo(p.value.a.x, p.value.a.y);
        mPath1.lineTo(p.value.i.x, p.value.i.y);
        mPath1.close();

        /// C区域 当前页可见区域 与A区域重新生成新路径
        Path mPathC =
            Path.combine(PathOperation.reverseDifference, mPathAB, mPath);

        // canvas.drawPath(mPathC, paint..color = Colors.red);
        // canvas.drawPath(mPathAB, paint..color = Colors.yellow);

        /// B区域 当前页不可见区域
        if (!p.value.b.x.isNaN) {
          Path pyy1 = Path();
          Path pyy2 = Path();
          Path mPathB = Path.combine(PathOperation.intersect, mPathAB, mPath1);

          // 已知a坐标点在一条直线上，求距离该坐标点为10并和该直线相交的的坐标点。

          double m1 = (p.value.a.x - p.value.p.x);
          double n1 = (p.value.a.y - p.value.p.y);

          double mE1 = (p.value.a.x - p.value.p2.x);
          double nE1 = (p.value.a.y - p.value.p2.y);

          pyy1.moveTo(p.value.c.x - m1, p.value.c.y);
          pyy1.quadraticBezierTo(p.value.e.x - m1, p.value.e.y - n1,
              p.value.b.x - m1, p.value.b.y - n1);
          pyy1.lineTo(p.value.p.x, p.value.p.y);
          pyy1.lineTo(p.value.k.x, p.value.k.y);
          pyy1.lineTo(p.value.f.x, p.value.f.y);
          pyy1.close();

          pyy2.moveTo(
              p.value.j.x, (p.value.j.y - mE1) <= 0 ? 0 : (p.value.j.y - mE1));

          pyy2.quadraticBezierTo(p.value.i.x - mE1, p.value.i.y - nE1,
              p.value.k.x - mE1, p.value.k.y - nE1);

          pyy2.lineTo(p.value.p2.x, p.value.p2.y);
          pyy2.lineTo(p.value.b.x, p.value.b.y);
          pyy2.lineTo(p.value.f.x, p.value.f.y);

          pyy2.close();

          // canvas.drawPath(
          //     Path.combine(PathOperation.reverseDifference, mPathA, pyy2),
          //     paint
          //       ..color = Colors.green
          //       ..style = PaintingStyle.fill);

          // canvas.drawPath(
          //     pyy2,
          //     paint
          //       ..color = Colors.red
          //       ..style = PaintingStyle.stroke);
          // canvas.drawPath(
          //     mPathA,
          //     paint
          //       ..color = Colors.black
          //       ..style = PaintingStyle.stroke);

          Path startYY =
              Path.combine(PathOperation.reverseDifference, mPathAB, pyy1);
          Path endYY =
              Path.combine(PathOperation.reverseDifference, mPathAB, pyy2);

          canvas.drawPath(mPathB, paint..color = Colors.grey.shade400);

          Paint paint2 = Paint();
          // 上左

          canvas.drawPath(
              startYY,
              paint2
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    Offset(p.value.a.x, p.value.a.y),
                    Offset(p.value.p.x, p.value.p.y),
                    [Colors.black26, Colors.transparent]));

          //上右
          canvas.drawPath(
              endYY,
              paint2
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    Offset(p.value.a.x, p.value.a.y),
                    Offset(p.value.p2.x, p.value.p2.y),
                    [Colors.black26, Colors.transparent]));

          // 右下
          Path pr = Path();
          pr.moveTo(p.value.c.x, p.value.c.y);
          pr.lineTo(p.value.j.x, p.value.j.y);
          pr.lineTo(p.value.h.x, p.value.h.y);
          pr.lineTo(p.value.e.x, p.value.e.y);
          pr.close();

          Path p1 = Path.combine(PathOperation.intersect, pr, mPathAB);
          Path p2 = Path.combine(PathOperation.difference, p1, mPathB);

          Offset u = Offset(
              PaperPoint.toTwoPoint(p.value.a, p.value.f, p.value.d, p.value.i)
                  .x,
              PaperPoint.toTwoPoint(p.value.a, p.value.f, p.value.d, p.value.i)
                  .y);
          canvas.drawPath(
              p2,
              paint
                ..style = PaintingStyle.fill
                ..shader = ui.Gradient.linear(
                    u,
                    Offset(p.value.g.x, p.value.g.y),
                    [Colors.black26, Colors.transparent]));

          // canvas.drawLine(o1, o2, paint);

        }
      }
    } else {
      // canvas.drawPath(mPath, paint..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant _BookPainter oldDelegate) {
    return oldDelegate.p != p;
  }

  Path drawText(String s, Canvas canvas, Size size) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: s,
            style: TextStyle(
              fontSize: 20,
              foreground: Paint()
                ..style = PaintingStyle.fill
                ..strokeWidth = 1,
            )),
        textAlign: TextAlign.left,
        maxLines: 100,
        ellipsis: "...",
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var size2 = textPainter.size;
    textPainter.paint(
      canvas,
      Offset(-size2.width / 2, -size2.height / 2),
    );

    Path path = Path();
    path.addRect(Rect.fromCenter(
        center: Offset.zero, width: size2.width, height: size2.height));
    return path;
  }
}

class PaperPoint {
  //手指拉拽点 已知
  Point<double> a;

  //右下角的点 已知
  late Point<double> f;

  late Point<double> p;
  late Point<double> p2;

  //
  // //贝塞尔点(e为控制点)
  late Point<double> b, c, d, e;

  // //贝塞尔点(h为控制点)
  late Point<double> h, i, j, k;

  //eh实际为af中垂线，g为ah和af的交点
  late Point<double> g;

  late Size size;

  late double ahK;
  late double ahB;

  PaperPoint(this.a, this.size) {
    //每个点的计算公式
    // f = Point(size.width / 2, size.height / 2);
    f = Point(size.width, size.height);
    print("af  ${a.y}  ${f.y}");
    // if (a.y == f.y) {
    //   print("xiangdeng l");
    //   return;
    // }
    g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
    e = Point(g.x - (pow(f.y - g.y, 2) / (f.x - g.x)), f.y);
    double cx = e.x - (f.x - e.x) / 2;

    if (a.x > 0) {
      if (cx <= 0) {
        //   // 临界点
        double fc = f.x - cx;
        double fa = f.x - a.x;
        double bb1 = size.width * fa / fc;
        double fd1 = f.y - a.y;
        double fd = bb1 * fd1 / fa;
        a = Point(f.x - bb1, f.y - fd);
        g = Point((a.x + f.x) / 2, (a.y + f.y) / 2);
        e = Point(g.x - (pow((f - g).y, 2) / (f - g).x), f.y);

        cx = 0;
      }
    }
    c = Point(cx, f.y);

    print("cccccc$c");
    h = Point(f.x, g.y - (pow((f - g).x, 2) / (f.y - g.y)));

    j = Point(f.x, h.y - (f.y - h.y) / 2);

    double k1 = towPointKb(c, j);
    double b1 = towPointKb(c, j, isK: false);

    double k2 = towPointKb(a, e);
    double b2 = towPointKb(a, e, isK: false);

    double k3 = towPointKb(a, h);

    double b3 = towPointKb(a, h, isK: false);

    ahK = towPointKb(a, h);
    ahB = towPointKb(a, h, isK: false);
    b = Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
    k = Point((b3 - b1) / (k1 - k3), (b3 - b1) / (k1 - k3) * k1 + b1);
    d = Point(((c.x + b.x) / 2 + e.x) / 2, ((c.y + b.y) / 2 + e.y) / 2);

    i = Point(((j.x + k.x) / 2 + h.x) / 2, ((j.y + k.y) / 2 + h.y) / 2);

    p = toP(a, ahK, ahB, 8);
    p2 = toP(a, towPointKb(a, e), towPointKb(a, e, isK: false), 8);
  }

  Point<double> toP(Point<double> p, double k, double b, double jl) {
    double x = 0.0;
    double y = 0.0;

    if (k > 0 || a.y >= h.y) {
      x = a.x - sqrt(jl * jl / (1 + (k * k)));
      y = a.y - sqrt(jl * jl / (1 + (k * k))) * k;
    } else {
      x = a.x + sqrt(jl * jl / (1 + (k * k)));
      y = a.y + sqrt(jl * jl / (1 + (k * k))) * k;
    }

    return Point<double>(x, y);
  }

  /// 两点求直线方程
  static double towPointKb(Point<double> p1, Point<double> p2,
      {bool isK = true}) {
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

  static Point<double> toTwoPoint(
      Point<double> a, Point<double> b, Point<double> m, Point<double> n) {
    double k1 = towPointKb(a, b);
    double b1 = towPointKb(a, b, isK: false);

    double k2 = towPointKb(m, n);
    double b2 = towPointKb(m, n, isK: false);

    return Point((b2 - b1) / (k1 - k2), (b2 - b1) / (k1 - k2) * k1 + b1);
  }
}
