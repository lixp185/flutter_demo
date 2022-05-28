import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:ui' as ui;

class ZanDemo extends StatefulWidget {
  const ZanDemo({Key? key}) : super(key: key);

  @override
  _ZanDemoState createState() => _ZanDemoState();
}

class _ZanDemoState extends State<ZanDemo> with TickerProviderStateMixin {
  late Animation<double> animation; // 赞
  late Animation<double> animation2; // 小圆点
  ValueNotifier<bool> isZan = ValueNotifier(false); // 记录点赞状态 默认没点赞
  ValueNotifier<int> zanNum = ValueNotifier(0); // 记录点赞数量 默认0点赞

  late AnimationController _controller; // 控制器
  late AnimationController _controller2; // 小圆点控制器
  late CurvedAnimation cure; // 动画运行的速度轨迹 速度的变化
  late CurvedAnimation cure2; // 动画运行的速度轨迹 速度的变化

  int time = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500)); //1s
    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800)); //1s

    cure = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    cure2 = CurvedAnimation(parent: _controller2, curve: Curves.easeOutQuint);
    animation = Tween(begin: 0.0, end: 1.0).animate(cure);
    animation2 = Tween(begin: 0.0, end: 1.0).animate(_controller2);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: CustomPaint(
          size: Size(50, 50),
          painter: _ZanPainter(animation, animation2, isZan, zanNum,
              Listenable.merge([animation, animation2, isZan, zanNum])),
        ),
      ),
      onTap: () {
        if (!isZan.value && !_isDoubleClick()) {
          _controller.forward(from: 0);
          Timer(Duration(milliseconds: 300), () {
            isZan.value = true;
            _controller2.forward(from: 0);
          });
          Vibrate.feedback(FeedbackType.success);
          zanNum.value++;
        } else if (isZan.value) {
          Vibrate.feedback(FeedbackType.success);
          isZan.value = false;
          zanNum.value--;
        }
      },
    );
  }

  bool _isDoubleClick() {
    if (time == 0) {
      time = DateTime.now().microsecondsSinceEpoch;
      return false;
    } else {
      if (DateTime.now().microsecondsSinceEpoch - time < 800 * 1000) {
        return true;
      } else {
        time = DateTime.now().microsecondsSinceEpoch;
        return false;
      }
    }
  }
}

class _ZanPainter extends CustomPainter {
  Animation<double> animation;
  Animation<double> animation2;
  ValueNotifier<bool> isZan;
  ValueNotifier<int> zanNum;
  Listenable listenable;

  _ZanPainter(
      this.animation, this.animation2, this.isZan, this.zanNum, this.listenable)
      : super(repaint: listenable);

  Paint _paint = Paint()..color = Colors.blue;
  List<Offset> points = [];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    // 赞
    final icon =
        isZan.value ? Icons.thumb_up_alt_rounded : Icons.thumb_up_alt_outlined;
    // 通过TextPainter可以获取图标的尺寸
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: String.fromCharCode(icon.codePoint),
            style: TextStyle(
                fontSize: animation.value < 0 ? 0 : animation.value * 30,
                fontFamily: icon.fontFamily,
                color: isZan.value ? Colors.blue : Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    Size size2 = textPainter.size; // 尺寸必须在布局后获取
    //将图标偏移到画布中央
    textPainter.paint(canvas, Offset(-size2.width / 2, -size2.height / 2));

    var r = size.width / 2 - 15; // 半径
    var d = 4; // 偏移量

    canvas.drawPoints(
        ui.PointMode.points,
        [
          Offset((r + d * animation2.value) * cos(pi - pi / 18 * 2),
              (r + d * animation2.value) * sin(pi - pi / 18 * 2)),
          Offset((r + d * animation2.value) * cos(pi + pi / 18 * 2),
              (r + d * animation2.value) * sin(pi + pi / 18 * 2)),
          Offset((r + d * animation2.value) * cos(pi * 1.5 - pi / 18 * 1),
              (r + d * animation2.value) * sin(pi * 1.5 - pi / 18 * 1)),
          Offset((r + d * animation2.value) * cos(pi * 1.5 + pi / 18 * 5),
              (r + d * animation2.value) * sin(pi * 1.5 + pi / 18 * 5)),
        ],
        _paint
          ..strokeWidth = animation2.value <= 0.5
              ? (5 * animation2.value) / 0.5
              : 5 * (1 - animation2.value) / 0.5
          ..color = Colors.blue
          ..strokeCap = StrokeCap.round);

    TextPainter textPainter2 = TextPainter(
        text: TextSpan(
            text: zanNum.value == 0 ? "赞" : zanNum.value.toString(),
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: isZan.value ? Colors.blue : Colors.black87)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter2.layout(); // 进行布局
    // 向右上进行偏移在小手上面
    textPainter2.paint(canvas, Offset(size.width / 9, -size.height / 2 + 5));
  }

  @override
  bool shouldRepaint(covariant _ZanPainter oldDelegate) {
    return oldDelegate.listenable != listenable;
  }
}
