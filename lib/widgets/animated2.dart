import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/paint2_demo.dart';
import 'package:flutter_demo/widgets/paint_demo.dart';

/// 自定义动画
class Animated2Demo extends StatefulWidget {
  const Animated2Demo({Key? key}) : super(key: key);

  @override
  _Animated2DemoState createState() => _Animated2DemoState();
}

class _Animated2DemoState extends State<Animated2Demo>
    with TickerProviderStateMixin {
  late Animation<double> animation; // 吃豆人
  late Animation<double> animation2; // 豆
  // 动画控制器 vsync TickerProvider参数 创建Ticker 为了防止动画消耗不必要的资源
  late AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1000)); //2s
  late AnimationController _controller2 = AnimationController(
      vsync: this, duration: Duration(milliseconds: 2000)); //2s
  ValueNotifier<Color> _color = ValueNotifier<Color>(Colors.yellow.shade800);

  // 动画轨迹
  late CurvedAnimation cure = CurvedAnimation(
      parent: _controller, curve: Curves.easeIn); // 动画运行的速度轨迹 速度的变化

  @override
  void initState() {
    super.initState();
    animation = Tween(begin: 0.2, end: 1.0).animate(_controller)
      ..addStatusListener((status) {
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
        if (status == AnimationStatus.completed) {
          _controller.reverse(); //反向执行 100-0
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _color.value = Colors.redAccent.shade400;
          });
          print("xxxxcolor ");
          _controller.forward(); //正向执行 0-100
        }
      });
    animation2 = Tween(begin: 0.2, end: 1.0).animate(_controller2)
      ..addStatusListener((status) {
        // dismissed	动画在起始点停止
        // forward	动画正在正向执行
        // reverse	动画正在反向执行
        // completed	动画在终点停止
        // if (status == AnimationStatus.completed) {
        //   _controller2.forward(); //反向执行 100-0
        // } else if (status == AnimationStatus.dismissed) {
        //   _controller2.forward(); //正向执行 0-100
        // }
      });

    // 启动动画
    _controller.forward();
    _controller2.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        PaintDemo(),
        Container(
          margin: EdgeInsetsDirectional.only(top: 100, start: 100),
          child: CustomPaint(
            size: Size(100, 100),
            painter: Pain2Painter(
                _color.value,
                animation,
                animation2,
                Listenable.merge([
                  _color,
                  animation,
                  animation2,
                ])),
          ),
        )
      ],
    ));
  }
}
