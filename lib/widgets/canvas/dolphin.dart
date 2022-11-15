import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/canvas/touch_controller.dart';
import '../coordinate.dart';
import 'dart:ui' as ui;

/// 小海豚
class Dolphin extends StatefulWidget {
  final TouchController touchController;
  final ui.Image image;

  const Dolphin({Key? key, required this.image, required this.touchController})
      : super(key: key);

  @override
  _DolphinState createState() => _DolphinState();
}

class _DolphinState extends State<Dolphin> {
  int canvasType = 0; // 0贝塞尔曲线 1直线

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // widget.touchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [],
        ),
        Expanded(
            child: Container(
                width: double.infinity,
                child: GestureDetector(
                  child: CustomPaint(
                    painter:
                        _DolphinPainter(widget.touchController, widget.image),
                  ),
                  onPanDown: (d) {
                    // 按压
                    judgeZone(d.localPosition);
                  },
                  onPanUpdate: (d) {
                    // 移动
                    if (widget.touchController.selectIndex != -1) {
                      widget.touchController.updatePoint(
                          widget.touchController.selectIndex, d.localPosition);
                    }
                  },
                )))
      ],
    );
  }

  ///判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;

  ///手指按下触发
  void judgeZone(Offset src) {
    /// 循环所有的点
    for (int i = 0; i < widget.touchController.points.length; i++) {
      // 判断手指按的位置有没有点
      if (judgeCircleArea(src, widget.touchController.points[i], 20)) {
        // 有点 不添加更新选中的点
        widget.touchController.selectIndex = i;
        return;
      }
    }
    // 无点 添加新的点 并将选中的点清空
    widget.touchController.addPoint(src);
    widget.touchController.selectIndex = -1;
  }
}

class _DolphinPainter extends CustomPainter {
  Coordinate coordinate = Coordinate(setP: 20);
  final TouchController touchController;
  final ui.Image image;

  _DolphinPainter(this.touchController, this.image)
  //
      : super(repaint: touchController);

  List<Offset>? pos; //

  @override
  void paint(Canvas canvas, Size size) {
    // 画布原点平移到屏幕中央
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);

    // ，因为手势识别的原点是左上角,所以这里将存储的点相对的原点进行偏移到跟画布一致 负值向左上角偏移
    pos = touchController.points
        .map((e) => e.translate(-size.width / 2, -size.height / 2))
        .toList();

    var paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    canvas.drawImage(image, Offset(-image.width / 2, -image.height / 2), paint);

    // 如果点小于4个 那么就只绘制点
    if (pos != null && pos!.length >= 4) {
      var path = Path();
      // 绘制起点首个贝塞尔曲线
      path.moveTo(pos![0].dx, (pos![0].dy));
      // 绘制贝塞尔曲线
      path.cubicTo(pos![1].dx, pos![1].dy, pos![2].dx, pos![2].dy, pos![3].dx,
          pos![3].dy);
      _drawHelpLine(canvas, size, paint, 0);
      canvas.drawPath(path, paint..color = Colors.purple);
      // 绘制第2个以后的曲线 以上个终点为下一个的起点
      for (int i = 1; i < (pos!.length - 1) ~/ 3; i++) {
        // 这里把绘制之前的颜色覆盖
        canvas.drawPath(path, paint..color = Colors.white);
        // 绘制辅助线
        _drawHelpLine(canvas, size, paint, i);
        path.cubicTo(
          pos![i * 3 + 1].dx,
          pos![i * 3 + 1].dy,
          pos![i * 3 + 2].dx,
          pos![i * 3 + 2].dy,
          pos![i * 3 + 3].dx,
          pos![i * 3 + 3].dy,
        );

        if (i == 8) {
          path.close();
        }
        canvas.drawPath(path, paint..color = Colors.purple);
      }

      // 绘制辅助点
      _drawHelpPoint(canvas, paint);
      // 选中点
      _drawHelpSelectPoint(canvas, size, paint);
    } else {
      // 绘制辅助点
      _drawHelpPoint(canvas, paint);
    }


    // // 画眼睛
    // canvas.drawCircle(
    //     pos!.first.translate(-50, 5),
    //     10,
    //     paint
    //       ..color = Colors.black87
    //       ..style = PaintingStyle.stroke
    //       ..strokeWidth = 2);
    // canvas.drawCircle(
    //     pos!.first.translate(-53, 5),
    //     7,
    //     paint
    //       ..color = Colors.black87
    //       ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }



  void _drawHelpPoint(Canvas canvas, Paint paint) {
    canvas.drawPoints(
        PointMode.points,
        pos ?? [],
        paint
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round
          ..color = Colors.redAccent);
  }

  void _drawHelpSelectPoint(Canvas canvas, Size size, Paint paint) {
    Offset? selectPos = touchController.selectPoint;
    selectPos = selectPos?.translate(-size.width / 2, -size.height / 2);
    if (selectPos == null) return;
    canvas.drawCircle(
        selectPos,
        10,
        paint
          ..color = Colors.green
          ..strokeWidth = 2);
  }

  void _drawHelpLine(Canvas canvas, Size size, Paint paint, int i) {
    canvas.drawLine(
        Offset(pos![i * 3].dx, pos![i * 3].dy),
        Offset(pos![i * 3 + 1].dx, pos![i * 3 + 1].dy),
        paint
          ..color = Colors.redAccent
          ..strokeWidth = 2);

    canvas.drawLine(
        Offset(pos![i * 3 + 1].dx, pos![i * 3 + 1].dy),
        Offset(pos![i * 3 + 2].dx, pos![i * 3 + 2].dy),
        paint
          ..color = Colors.redAccent
          ..strokeWidth = 2);

    canvas.drawLine(
        Offset(pos![i * 3 + 2].dx, pos![i * 3 + 2].dy),
        Offset(pos![i * 3 + 3].dx, pos![i * 3 + 3].dy),
        paint
          ..color = Colors.redAccent
          ..strokeWidth = 2);
  }
}
