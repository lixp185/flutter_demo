import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/paint2_demo.dart';

/// 自定义动画
class Animated2Demo extends StatefulWidget {
  const Animated2Demo({Key? key}) : super(key: key);

  @override
  _Animated2DemoState createState() => _Animated2DemoState();
}

class _Animated2DemoState extends State<Animated2Demo>
    with TickerProviderStateMixin {
  late Animation<double> animation; // 吃豆人
  late Animation<double> animation2; // 豆豆
  late AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 500)); //1s
  late AnimationController _controller2 = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1000)); //2s

  //初始化吃豆人、豆豆颜色
  ValueNotifier<Color> _color = ValueNotifier<Color>(Colors.yellow.shade800);
  ValueNotifier<Color> _color2 =
      ValueNotifier<Color>(Colors.redAccent.shade400);

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
          _color.value = _color2.value;
          // 获取一个随机彩虹色
          _color2.value = getRandomColor();
          _controller.forward(); //正向执行 0-100
          // 豆子已经被吃了 从新加载豆子动画
          _controller2.forward(from: 0); //正向执行 0-100
        }
      });
    animation2 = Tween(begin: 0.2, end: 1.0).animate(_controller2);
    // 启动动画 正向执行
    _controller.forward();
    // 启动动画 0-1循环执行
    _controller2.forward();
    // 这里这样重复调用会导致两次动画执行时间不一致 时间长了就不对应了
    // _controller2.repeat();
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
        child: CustomPaint(
      size: Size(40, 40),
      painter: Pain2Painter(
          _color,
          _color2,
          animation,
          animation2,
          Listenable.merge([
            animation,
            animation2,
            _color,
          ]),
          ddSize: 8),
    ));
  }

  // 获取一个随机颜色
  Color getRandomColor() {
    Random random = Random.secure();
    int randomInt = random.nextInt(6);
    var colors = <Color>[
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    Color color = colors[randomInt];
    while (color == _color2.value) {
      // 重复再选一个
      color = colors[random.nextInt(6)];
    }
    return color;
  }
}
