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
  Animation<double> animation; // 动画抽象类
  AnimationController _controller; // 控制器
  CurvedAnimation cure; // 动画运行的速度轨迹

  @override
  void initState() {
    super.initState();

    //vsync TickerProvider参数 创建Ticker 为了防止动画消耗不必要的资源
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000)); //2s

    cure = CurvedAnimation(parent: _controller, curve: Curves.easeInQuart);
    // 在2s之内从0变到100采用cure的运动轨迹变化
    // Tween定义数据的起始和终点
    animation = Tween(begin: 0.0, end: 100.0).animate(cure)
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
        AnimatedLogo(
          child: FlutterLogo(),
          animation: animation,
        ),
      ],
    );
  }
}

class AnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  AnimatedLogo({this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        child: child,
        animation: animation,
        builder: (context, child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        });
  }
}
// Animation对象是Flutter动画库中的一个核心类，它生成指导动画的值。
// Animation对象知道动画的当前状态（例如，它是开始、停止还是向前或向后移动），但它不知道屏幕上显示的内容。
// AnimationController管理Animation。
// CurvedAnimation 将过程抽象为一个非线性曲线.
// Tween在正在执行动画的对象所使用的数据范围之间生成值。例如，Tween可能会生成从红到蓝之间的色值，或者从0到255。
// 使用Listeners和StatusListeners监听动画状态改变。
