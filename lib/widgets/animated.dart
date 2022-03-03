import 'dart:math';

import 'package:flutter/material.dart';

/// 动画
class AnimateWidgetDemo extends StatefulWidget {
  @override
  _AnimateWidgetDemoState createState() => _AnimateWidgetDemoState();
}

///Animation对象本身和UI渲染没有任何关系。
///需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _AnimateWidgetDemoState extends State<AnimateWidgetDemo>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation; // 动画抽象类
  late Animation<Offset> animation2; // 动画抽象类
  late Animation<double> animation3; // 动画抽象类
  late Animation<double> animation4; // 动画抽象类
  late AnimationController _controller; // 控制器
  late CurvedAnimation cure; // 动画运行的速度轨迹 速度的变化

  @override
  void initState() {
    super.initState();

    //vsync TickerProvider参数 创建Ticker 为了防止动画消耗不必要的资源
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000)); //2s

    cure = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    // 在2s之内从0变到100采用cure的运动轨迹变化
    // Tween定义数据的起始和终点
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
        if (status == AnimationStatus.completed) {
          _controller.reverse(); //反向执行 100-0
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward(); //正向执行 0-100
        }
      });

    animation2 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0))
        .animate(cure);
    animation3 = Tween(begin: 0.0, end: 1.0).animate(cure);

    // pi 3.14
    animation4 = Tween(begin: 0.0, end: pi * 2).animate(cure);

    // 启动动画
    _controller.forward();
  }

  @override
  void dispose() {
    // 释放资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 平移
        Text("平移"),
        SlideTransitionLogo(
          child: FlutterLogo(),
          animation: animation2,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("旋转"),
            RotationTransitionLogo(
              child: FlutterLogo(),
              animation: animation3,
            ),
            Text("渐变"),
            FadeTransition(
              opacity: animation3,
              child: Container(
                width: 100,
                height: 100,
                child: FlutterLogo(),
              ),
            ),
          ],
        ),
        Text("3d旋转动画(变换组件实现)"),
        ZAnimatedLogo(animation: animation4, child: FlutterLogo()),
        Text("组合动画"),
        ZhAnimatedLogo(
          animation: animation2,
          animation2: animation3,
          child: RotationTransitionLogo(
            child: FlutterLogo(),
            animation: animation3,
          ),
        ),
        Text("缩放"),
        AnimatedLogo(
          // 缩放
          child: FlutterLogo(),
          animation: animation,
        ),
      ],
    );
  }
}

// 缩放
class AnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  AnimatedLogo({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (context, child) {
          return Container(
            width: animation.value * 100,
            height: animation.value * 100,
            child: child,
          );
        });
  }
}

// 3d旋转
class ZAnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const ZAnimatedLogo({Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (context, child) {
          return Transform(
              alignment: Alignment.center, //相对于坐标系原点的对齐方式
              transform: Matrix4.identity()
                ..rotateX(0)
                ..rotateY(animation.value),
              child: Container(width: 100, height: 100, child: child));
        });
  }
}

// 平移
class SlideTransitionLogo extends StatelessWidget {
  final Animation<Offset> animation;
  final Widget child;

  const SlideTransitionLogo(
      {Key? key, required this.animation, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideTransition(
        position: animation,
        child: Container(
          width: 100,
          height: 100,
          child: child,
        ),
      ),
    );
  }
}

// 翻转
class RotationTransitionLogo extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  RotationTransitionLogo({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RotationTransition(
        turns: animation,
        child: Container(
          width: 100,
          height: 100,
          child: child,
        ),
      ),
    );
  }
}

// 组合动画
class ZhAnimatedLogo extends StatelessWidget {
  final Animation<Offset> animation;
  final Animation<double> animation2;
  final Widget child;

  const ZhAnimatedLogo(
      {Key? key,
      required this.animation,
      required this.animation2,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideTransitionLogo(
        animation: animation,
        child: FadeTransition(
          opacity: animation2,
          child: child,
        ),
      ),
    );
  }
}

// Animation对象是Flutter动画库中的一个核心类，它生成指导动画的值。
// Animation对象知道动画的当前状态（例如，它是开始、停止还是向前或向后移动），但它不知道屏幕上显示的内容。
// AnimationController管理Animation。
// CurvedAnimation 将过程抽象为一个非线性曲线.
// Tween在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween可能会生成从红到蓝之间的色值，或者从0到255。
// 使用Listeners和StatusListeners监听动画状态改变。
