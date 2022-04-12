import 'package:flutter/material.dart';

import 'canvas/curbox.dart';

class CurveBox extends StatefulWidget {
  final Color color;
  final Curve curve1;
  final Curve curve2;

  CurveBox(
      {Key? key,
      this.color = Colors.lightBlue,
      this.curve1 = Curves.linear,
      this.curve2 = Curves.bounceIn})
      : super(key: key);

  @override
  _CurveBoxState createState() => _CurveBoxState();
}

class _CurveBoxState extends State<CurveBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this);
  late Animation<double> _angleAnimation = CurveTween(curve: widget.curve1)
      .animate(_controller)
    ..addStatusListener((status) {});
  late Animation<double> repaint = CurveTween(curve: widget.curve2)
      .animate(_controller)
    ..addStatusListener((status) {});

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: CurveBoxPainter(_angleAnimation, repaint,
          Listenable.merge([_angleAnimation, repaint])),
    );
  }
}
