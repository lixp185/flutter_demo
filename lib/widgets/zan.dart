import 'dart:async';

import 'package:flutter/material.dart';

class ZanDemo extends StatefulWidget {
  const ZanDemo({Key? key}) : super(key: key);

  @override
  _ZanDemoState createState() => _ZanDemoState();
}

class _ZanDemoState extends State<ZanDemo> with TickerProviderStateMixin {
  late Animation<double> animation; // 赞
  late Animation<double> animation2; // 小圆点
  late AnimationController _controller; // 控制器
  late AnimationController _controller2; // 小圆点控制器
  late CurvedAnimation cure; // 动画运行的速度轨迹 速度的变化
  late CurvedAnimation cure2; // 动画运行的速度轨迹 速度的变化

  bool isZan = false; // 记录点赞状态 默认没点赞
  @override
  void initState() {
    super.initState();
    //vsync TickerProvider参数 创建Ticker 为了防止动画消耗不必要的资源
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500)); //1s
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000)); //1s

    cure = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    cure2 = CurvedAnimation(parent: _controller2, curve: Curves.easeOutQuint);
    // 在2s之内从0变到100采用cure的运动轨迹变化
    // Tween定义数据的起始和终点
    animation = Tween(begin: 0.0, end: 1.0).animate(cure)
      ..addStatusListener((status) {
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
        if (status == AnimationStatus.completed) {
          // 点赞正向执行结束
          print("执行结束");
        } else if (status == AnimationStatus.dismissed) {}
      });
    animation2 = Tween(begin: 0.0, end: 1.0).animate(_controller2);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
          child: Stack(
        children: [
          AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Icon(
                  isZan
                      ? Icons.thumb_up_alt_rounded
                      : Icons.thumb_up_alt_outlined,
                  color: isZan ? Colors.blue : Colors.black87,
                  size: animation.value * 50 < 0 ? 0 : animation.value * 50,
                );
              }),
          Positioned(
              top: 10,
              left: 10,
              child: AnimatedBuilder(
                  animation: animation2,
                  builder: (context, child) {
                    return Icon(
                      Icons.circle,
                      color: animation2.value > 0.8
                          ? Colors.blue
                              .withOpacity(1 - 5 * (animation2.value - 0.8))
                          : Colors.blue,
                      size: animation2.value <= 0.8
                          ? animation2.value * 10 / 8
                          : 5,
                    );
                  }))
        ],
      )),
      onTap: () {
        if (!isZan) {
          Timer(Duration(milliseconds: 100), () {
            _controller2.forward(from: 0);
          });
          _controller.forward(from: 0);

          setState(() {
            isZan = true;
          });
        } else {
          setState(() {
            isZan = false;
          });
        }
      },
    );

    // return Container(
    //   child: CustomPaint(
    //     size: Size(50, 50),
    //     painter: ZanPainter(),
    //   ),
    // );
  }
}

class Zan extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  Zan({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (context, child) {
          return Container(
            width: animation.value * 30,
            height: animation.value * 30,
            child: child,
          );
        });
  }
}

class ZanPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    // canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    canvas.drawLine(Offset(size.width / 20, size.height / 2),
        Offset(size.width / 20, size.height - size.height / 10), paint);
    path.moveTo(
      size.width / 20 + size.width * 0.15,
      size.height - size.height / 10,
    );
    path.relativeLineTo(
      size.width * 0.35,
      0,
    );
    path.relativeLineTo(
      size.width * 0.1,
      -size.height / 2.5,
    );
    path.relativeLineTo(
      -size.width * 0.25,
      0,
    );
    path.relativeQuadraticBezierTo(size.width * 0.15, -size.height * 0.3,
        -size.width * 0.05, -size.height * 0.3);
    path.relativeQuadraticBezierTo(-size.width * 0, size.height * 0.3,
        -size.width * 0.15, size.height * 0.3);
    // path.relativeQuadraticBezierTo(-5, 20, -10, 40);
    // path.relativeQuadraticBezierTo(-5, 0, -40, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
