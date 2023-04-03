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
  late Animation<Color?> animation5; // 动画抽象类
  late Animation<Size?> animation6; // 动画抽象类
  late AnimationController _controller; // 控制器
  late CurvedAnimation cure; // 动画运行的速度轨迹 速度的变化

  @override
  void initState() {
    super.initState();
    //vsync TickerProvider参数 创建Ticker 为了防止动画消耗不必要的资源
    _controller = AnimationController(
      vsync: this,
      //设置Ticker 动画帧的回调函数
      duration: const Duration(milliseconds: 2000),
      // 正向动画时长 //2s
      reverseDuration: const Duration(milliseconds: 2000),
      // 反向动画时长 //2s
      lowerBound: 0,
      // 开始动画数值
      upperBound: 1.0,
      // 结束动画数值
      animationBehavior: AnimationBehavior.normal,
      // 动画器行为 是否重复动画 两个枚举值
      debugLabel: "缩放动画", // 调试标签 toString时显示
    );

    cure = CurvedAnimation(parent: _controller, curve: MyCurve());
    // 在2s之内从0变到100采用cure的运动轨迹变化
    // Tween定义数据的起始和终点

    animation = Tween(begin: 0.0, end: 1.0).animate(cure);

    animation2 = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0))
        .animate(cure);
    animation3 = Tween(begin: 0.0, end: 1.0).animate(cure);

    // pi 3.14
    animation4 = Tween(begin: 0.0, end: pi * 2).animate(cure);
    // animation5 = Tween<Color>(begin: Colors.red.shade900, end:Colors.yellow.shade900).animate(cure);
    animation5 = ColorTween(begin: Colors.red, end:Colors.yellow).animate(cure);
    animation6 = SizeTween(begin: Size(100,50), end:Size(50,100)).animate(cure);

    // _controller.addStatusListener((status) {
    //   // dismissed	动画在起始点停止
    //   // forward	动画正在正向执行
    //   // reverse	动画正在反向执行
    //   // completed	动画在终点停止
    //   if (status == AnimationStatus.completed) {
    //     _controller.reverse(); //反向执行 100-0
    //   } else if (status == AnimationStatus.dismissed) {
    //     _controller.forward(); //正向执行 0-100
    //   }
    // });

    // 启动动画
    // _controller.forward();//正向开始动画
    // _controller.reverse();//反向开始动画
    _controller.repeat(reverse: true); // 无限循环开始动画
  }

  @override
  void dispose() {
    // 释放资源
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
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

          Text("缩放"),
          ScaleTransition(
            child:   Container(
              width: 100,
              height: 100,
              child: FlutterLogo(),
            ),
            scale: animation,
          ),

          Text("组合动画"),
          // // 平移
          SlideTransitionLogo(
            animation: animation2,
            // 渐变
            child: FadeTransition(
              opacity: animation3,
              // 二维旋转
              child:  RotationTransitionLogo(
                // 缩放
                child: ScaleTransition(
                  // 3D旋转
                  child: AnimatedBuilder(
                      child:  FlutterLogo(),
                      animation: animation4,
                      builder: (context, child) {
                        return Transform(
                            alignment: Alignment.center, //相对于坐标系原点的对齐方式
                            transform: Matrix4.identity()
                              ..rotateX(0)
                              ..rotateY(animation4.value),
                            child: Container(width: 100, height: 100, child: child));
                      }),
                  scale: animation,
                ),

                animation: animation3,
              ),
            ),
          ),




          // Text("Size 大小渐变"),
          // AnimatedBuilder(
          //     animation: animation6,
          //     builder: (context, child) {
          //       return Container(
          //         width: animation6.value?.width,
          //         height:  animation6.value?.height ,
          //         decoration: BoxDecoration(
          //             border: Border.all(width: 1,color: Colors.black)
          //         ),
          //         child: child,
          //       );
          //     }),

        ],
      ),
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
    return ScaleTransition(
      child: child,
      scale: animation,
    );
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

  const RotationTransitionLogo({super.key, required this.animation, required this.child});

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
      // 平移
      child: SlideTransitionLogo(
        animation: animation,
        // 渐变
        child: FadeTransition(
          opacity: animation2,
          child: child,
        ),
      ),
    );
  }
}

class MyCurve extends Curve {
  @override
  double transformInternal(double x) {
    // 自定义变化曲线
    // y = x的立方。这里可以理解为定义方程 x可以理解为0-1的变化过程 y即是返回0-1的位置，无需关系中间是如何计算的。
    // return x * x * x;

    return x;
  }
}
