import 'package:flutter/material.dart';

/// 坐标系

class Coordinate {
  final double setP;
  final Paint? paint;

// 定义成员变量
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  Coordinate({this.setP = 20, this.paint});

  paintT(Canvas canvas, Size size) {
    // 网格
    var gridPaint = paint ?? Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path _gridPath = Path();
    for (int i = 0; i < size.width / 2 / setP; i++) {
      _gridPath.moveTo(setP * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
      _gridPath.moveTo(-setP * i, -size.height / 2);
      _gridPath.relativeLineTo(0, size.height);
    }
    for (int i = 0; i < size.height / 2 / setP; i++) {
      _gridPath.moveTo(-size.width / 2, setP * i);
      _gridPath.relativeLineTo(size.width, 0);
      _gridPath.moveTo(
        -size.width / 2,
        -setP * i,
      );
      _gridPath.relativeLineTo(size.width, 0);
    }
    canvas.drawPath(_gridPath, gridPaint);

    // 坐标轴
    var _paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);

    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(
        Offset(size.width / 2 - 10, 10), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(size.width / 2 - 10, -10), Offset(size.width / 2, 0), _paint);

    // 刻度 Y>0
    canvas.save();
    for (int i = 0; i < size.height / 2 / setP; i++) {
      if (setP < 30 && i.isOdd || i == 0) {
        canvas.translate(0, setP);
        continue;
      } else {
        var index = (i * setP).toInt().toString();
        _drawAxisText(canvas, index);
      }
      canvas.translate(0, setP);
    }
    canvas.restore();
    // 刻度 Y<0
    canvas.save();
    for (int i = 0; i < size.height / 2 / setP; i++) {
      if (setP < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -setP);
        continue;
      } else {
        var index = (-i * setP).toInt().toString();
        _drawAxisText(canvas, index);
      }
      canvas.translate(0, -setP);
    }
    canvas.restore();
    // X>0
    canvas.save();
    for (int i = 0; i < size.width / 2 / setP; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "O", color: Colors.black87, x: null);
        canvas.translate(setP, 0);
        continue;
      }
      if (setP < 30 && i.isOdd) {
        canvas.translate(setP, 0);
        continue;
      } else {
        var index = (i * setP).toInt().toString();
        _drawAxisText(canvas, index, x: true);
      }
      canvas.translate(setP, 0);
    }
    canvas.restore();
    // X<0
    canvas.save();
    for (int i = 0; i < size.width / 2 / setP; i++) {
      // if (i == 0) {
      //   _drawAxisText(canvas, "O", x: null);
      //   canvas.translate(setP, 0);
      //   continue;
      // }
      if (setP < 30 && i.isOdd || i == 0) {
        canvas.translate(-setP, 0);
        continue;
      } else {
        var index = (-i * setP).toInt().toString();
        _drawAxisText(canvas, index, x: true);
      }
      canvas.translate(-setP, 0);
    }
    canvas.restore();
  }

  _drawAxisText(Canvas canvas, String index,
      {Color color = Colors.blue, bool? x = false}) {
    TextSpan text = TextSpan(
        text: index,
        style: TextStyle(
          fontSize: 10,
          color: color,
        ));
    _textPainter.text = text;
    _textPainter.layout();
    Size size = _textPainter.size; // 获取文字所占区域
    Offset offset = Offset.zero;
    if (x == null) {
      offset = Offset(-10, 4);
    } else if (x) {
      offset = Offset(-size.width / 2, size.height / 2);
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }
    _textPainter.paint(canvas, offset);
  }
}
