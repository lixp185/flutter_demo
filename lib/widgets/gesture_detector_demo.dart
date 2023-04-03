import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class GestureDetectorDemo2 extends StatefulWidget {
  const GestureDetectorDemo2({Key? key}) : super(key: key);

  @override
  State<GestureDetectorDemo2> createState() => _GestureDetectorDemo2State();
}

class _GestureDetectorDemo2State extends State<GestureDetectorDemo2> {
  final StampData stampData = StampData();

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        TapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                () => TapGestureRecognizer(), (instance) {
          instance.onTap = _tap;
        })
      },
    );

    // return GestureDetector(
    //   onTapDown: _onTabDown,
    //   onTapUp: _onTapUp,
    //   onTapCancel: _onTabCancel,
    //   child: Container(
    //     width: 300,
    //     height: 300,
    //     child: CustomPaint(
    //       size: const Size(300, 300),
    //       foregroundPainter: _StampPainter(stampData),
    //       painter: _StampBgPainter(3),
    //     ),
    //   ),
    // );
  }

  void _onTabDown(TapDownDetails details) {
    /// 手指点击坐标
    var localPosition = details.localPosition;

    stampData.push(
        Stamp(color: Colors.grey, radius: 30, center: details.localPosition));
  }

  void _onTapUp(TapUpDetails details) {}

  void _onTabCancel() {
    GHandler<TapGestureRecognizer>(() => TapGestureRecognizer(), (t) {
      // t.onTap
    });
  }

  void _tap() {}
}

typedef GetT<T> = T Function();
typedef SetT<T> = void Function(T t);

class GHandler<T extends GestureRecognizer>
    extends GestureRecognizerFactory<T> {
  final GetT<T> getT;
  final SetT<T> setT;

  GHandler(this.getT, this.setT);

  @override
  T constructor() => getT();

  @override
  void initializer(T instance) => setT(instance);
}

// 背景
class _StampBgPainter extends CustomPainter {
  final int count;

  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  static const List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4)
  ];
  static const List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];

  _StampBgPainter(this.count);

  @override
  void paint(Canvas canvas, Size size) {
    // 裁剪画布
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    // 颜色渐变
    _pathPaint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        colors,
        pos,
        TileMode.mirror,
        pi / 2,
        pi);
    canvas.save();
    // 横线
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(0, size.height / count);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
    }
    canvas.restore();

    canvas.save();
    // 竖线
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(size.width / count, 0);
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _StampPainter extends CustomPainter {
  final StampData stampData;

  _StampPainter(this.stampData) : super(repaint: stampData);
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in stampData.stamps) {
      canvas.drawCircle(
          element.center,
          element.radius,
          _paint
            ..color = element.color
            ..style = PaintingStyle.fill);
      canvas.drawPath(
          element.path,
          _paint
            ..color = Colors.white
            ..strokeWidth = 3
            ..style = PaintingStyle.stroke);
      canvas.drawCircle(
          element.center,
          element.radius + 2,
          _paint
            ..color = element.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3);
    }
  }

  @override
  bool shouldRepaint(covariant _StampPainter oldDelegate) {
    return oldDelegate.stampData != stampData;
  }
}

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];

  push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }
}

/// 图章数据
class Stamp {
  final Color color;
  final double radius;
  final Offset center;

  Stamp({required this.color, required this.radius, required this.center});

  Path? _path;

  Path get path {
    if (_path == null) {
      _path = Path();
      double rad = 30 / 180 * pi;
      double r = radius;
      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(r * cos(rad), -r * sin(rad));
      _path!.relativeLineTo(-2 * r * cos(rad), 0);
      _path!.relativeLineTo(r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(r * cos(rad), -(r + r * sin(rad)));

      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(0, -r);
      _path!.relativeLineTo(-r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(2 * r * cos(rad), 0);
      _path!.relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));
    }
    return _path!;
  }
}
