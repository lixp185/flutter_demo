import 'dart:math';

import 'package:flutter/material.dart';

class ShowYou extends StatefulWidget {
  final double size;
  final double handleRadius;

  const ShowYou({Key? key, this.size = 60, this.handleRadius = 30})
      : super(key: key);

  @override
  _ShowYouState createState() => _ShowYouState();
}

class _ShowYouState extends State<ShowYou> {
  ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanEnd: reset,
        onPanUpdate: parser,
        child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _HandlePainter(
                color: Colors.green,
                handleR: widget.handleRadius,
                offset: _offset)));
  }

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
  }

  parser(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    var rad = atan2(dx, dy);
    if (dx < 0) {
      rad += 2 * pi;
    }
    var bgR = widget.size / 2 - widget.handleRadius;
    var thta = rad - pi / 2; //旋转坐标系90度
    var d = sqrt(dx * dx + dy * dy);// 开平方根
    if (d > bgR) {// 如果边长大于
      dx = bgR * cos(thta);// 知道斜边、角度求边长
      dy = -bgR * sin(thta);
    }
    _offset.value = Offset(dx, dy);
  }
}

class _HandlePainter extends CustomPainter {
  var _paint = Paint();
  final ValueNotifier<Offset> offset;
  final Color color;
  var handleR;

  _HandlePainter({this.handleR, required this.offset, this.color = Colors.blue})
      : super(repaint: offset) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant _HandlePainter oldDelegate) {
    return oldDelegate.handleR != handleR;
  }
}
