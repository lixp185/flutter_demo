import 'dart:math';
import 'package:flutter/material.dart';

/// 牛顿摆
class OvalLoading extends StatefulWidget {
  const OvalLoading({Key? key}) : super(key: key);

  @override
  _OvalLoadingState createState() => _OvalLoadingState();
}

class _OvalLoadingState extends State<OvalLoading>
    with TickerProviderStateMixin {


  // 左边小球
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse(); //反向执行 100-0
          } else if (status == AnimationStatus.dismissed) {
            _controller2.forward();
          }
        })..forward();

  // 右边小球
  late AnimationController _controller2 =
  AnimationController(vsync: this, duration: Duration(milliseconds: 300))
    ..addStatusListener((status) {
      // dismissed	动画在起始点停止
      // forward	动画正在正向执行
      // reverse	动画正在反向执行
      // completed	动画在终点停止
      if (status == AnimationStatus.completed) {
        _controller2.reverse(); //反向执行 1-0
      } else if (status == AnimationStatus.dismissed) {
        // 反向执行完毕
        _controller.forward();
      }
    });
  late var cure =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  late var cure2 =
      CurvedAnimation(parent: _controller2, curve: Curves.easeOutCubic);

  late Animation<double> animation = Tween(begin: 0.0, end: 1.0).animate(cure);

  late Animation<double> animation2 =
      Tween(begin: 0.0, end: 1.0).animate(cure2);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 300, start: 150),
      child: CustomPaint(
        size: Size(100, 100),
        painter: _OvalLoadingPainter(
            animation, animation2, Listenable.merge([animation, animation2])),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }
}

class _OvalLoadingPainter extends CustomPainter {
  double radius = 6;
  final Animation<double> animation;
  final Animation<double> animation2;
  final Listenable listenable;

  late Offset offset; // 左边小球圆心
  late Offset offset2; // 右边小球圆心

  final double lineLength = 60; // 线长

  _OvalLoadingPainter(this.animation, this.animation2, this.listenable)
      : super(repaint: listenable) {

    offset = Offset(20, lineLength);
    offset2 = Offset(20 * radius * 8, lineLength);
  }

  // 摆动角度
  double angle = pi / 180 * 30; // 30°

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2;

    // 左边小球 默认坐标 下方是90度 需要+pi/2
    var dx = 20 + 60 * cos(pi / 2 + angle * animation.value);
    var dy = 60 * sin(pi / 2 + angle * animation.value);
    // 右边小球
    var dx2 = 20 + radius * 8 - 60 * cos(pi / 2 + angle * animation2.value);
    var dy2 = 60 * sin(pi / 2 + angle * animation2.value);

    offset = Offset(dx, dy);
    offset2 = Offset(dx2, dy2);

    /// 绘制线
    //   canvas.drawLine(Offset.zero, Offset(90, 0), paint);
    // canvas.drawLine(Offset(20, 0), offset, paint);
    // canvas.drawLine(
    //     Offset(20 + radius * 2, 0), Offset(20 + radius * 2, 60), paint);
    // canvas.drawLine(
    //     Offset(20 + radius * 4, 0), Offset(20 + radius * 4, 60), paint);
    // canvas.drawLine(
    //     Offset(20 + radius * 6, 0), Offset(20 + radius * 6, 60), paint);
    // canvas.drawLine(Offset(20 + radius * 8, 0), offset2, paint);

    /// 绘制球
    canvas.drawCircle(offset, radius, paint);
    canvas.drawCircle(
        Offset(20 + radius * 2, 60),
        radius,
        paint);

    canvas.drawCircle(Offset(20 + radius * 4, 60), radius, paint);
    canvas.drawCircle(Offset(20 + radius * 6, 60), radius, paint);
    canvas.drawCircle(offset2, radius, paint);
  }
  @override
  bool shouldRepaint(covariant _OvalLoadingPainter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }
}
