import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/coordinate.dart';
import 'package:image/image.dart' as image2;

class PaintDemo extends StatefulWidget {
  final ui.Image? image;
  final image2.Image? image22;

  const PaintDemo({Key? key, this.image, this.image22}) : super(key: key);

  @override
  _PaintDemoState createState() => _PaintDemoState();
}

class _PaintDemoState extends State<PaintDemo> {
  ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  void initState() {
    double d = -0.22222;

    super.initState();
    print("${2.isNegative}");
    print("0.2 ${d.isNegative}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,

        /// 显示绘制的结果
        child: GestureDetector(
          child: CustomPaint(
            // size: Size(80,80),
            painter:
                PaperPainter(widget.image, widget.image22, offset: _offset),
          ),
          // 移动
          // onPanUpdate: parser,
          // onPanEnd: reset,
        ));
  }

  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
  }

  parser(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx;
    dy = offset.dy;
    _offset.value = Offset(dx, dy);
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;
  final double setP = 20; // 小格边长
  final double strokeWidth = 1; // 线宽
  final Color color = Colors.blue; // 线色值
  final ui.Image? _image;
  final image2.Image? image22;
  List<Ball> balls = [];
  double d = 2.6; //复刻的像素边长
  final ValueNotifier<Offset> offset;

  PaperPainter(this._image, this.image22, {required this.offset})
      : super(repaint: offset) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;
  }

  Coordinate coordinate = Coordinate(setP: 20);

  @override
  bool shouldRepaint(PaperPainter oldDelegate) {
    return oldDelegate.offset != offset;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 平移画布 中心点
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);
    // 网格
    // _drawBottomRight(canvas, size);
    // _drawGird(canvas, size);
    // _drawDot(canvas, size);
    // _drawCir(canvas, size);
    // drawLine(canvas, size);
    // _drawPoint(canvas, size);
    /// 绘制矩形
    // _drawRect(canvas, size);
    // _drawDRRect(canvas, size);
    // _drawColor(canvas, size);
    // _drawImage(canvas, size);
    // _drawText(canvas, size);
    // _drawPath(canvas, size);
    // _drawColor(canvas, size);
    // _drawCDR(canvas, size);
    // _drawShouShi(canvas, size);
    // _drawSyr(canvas, size);
    // _drawHt(canvas, size);
    // _drawXiaoA(canvas, size);
    // _drawZan(canvas, size);
    // _drawPath2(canvas, size);
    _drawLt(canvas, size);

  }

  void _drawShouShi(Canvas canvas, Size size) {
    var offsetTranslate =
        offset.value.translate(-size.width / 2, -size.height / 2);

    print("dx ${offsetTranslate.dx} dy${offsetTranslate.dy}");
    var ata = atan2(offsetTranslate.dx, offsetTranslate.dy);
    var thta = ata - pi / 2; //旋转坐标系90度
    var d = sqrt(offsetTranslate.dx * offsetTranslate.dx +
        offsetTranslate.dy * offsetTranslate.dy);
    if (d > 60) {
      var dx = 60 * cos(thta); // 求边长
      var dy = -60 * sin(thta); // 求边长
      offsetTranslate = Offset(dx, dy);
    }

    canvas.drawCircle(
        Offset.zero,
        60,
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue.withOpacity(0.2));
    _paint.color = color;
    _paint.style = PaintingStyle.stroke;
    if (offset.value == Offset.zero) {
      canvas.drawCircle(
          offset.value,
          20,
          _paint
            ..style = PaintingStyle.fill
            ..color = Colors.blue.withOpacity(0.6));

      canvas.drawLine(Offset.zero, offset.value, _paint);
    } else {
      canvas.drawCircle(
          offsetTranslate,
          20,
          _paint
            ..style = PaintingStyle.fill
            ..color = Colors.blue.withOpacity(0.6));

      canvas.drawLine(Offset.zero, offsetTranslate, _paint);
    }

    // canvas.drawCircle(
    //     Offset.zero,
    //     20,
    //     _paint
    //       ..style = PaintingStyle.fill
    //       ..color = Colors.blue.withOpacity(0.6));
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    // 保存画布状态
    canvas.save();
    // 画横线
    for (int i = 0; i < size.height / 2 / setP; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _paint);
      // 平移画布
      canvas.translate(0, setP);
    }
    // 恢复画布状态
    canvas.restore();
    // 保存画布状态
    canvas.save();
    // 画纵线
    for (int i = 0; i < size.width / 2 / setP; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _paint);
      // 平移画布
      canvas.translate(setP, 0);
    }
    // 恢复画布状态
    canvas.restore();
  }

  void _drawGird(Canvas canvas, Size size) {
    /// X轴镜像
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    /// Y轴镜像
    canvas.save();
    canvas.scale(-1, 1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    /// 原点镜像
    canvas.save();
    canvas.scale(-1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawDot(Canvas canvas, Size size) {
    int count = 12;
    var paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    canvas.save();
    for (int i = 0; i < count; i++) {
      var setp = 2 * pi / count;
      canvas.drawLine(Offset(80, 0), Offset(100, 0), paint);
      canvas.rotate(setp);
    }
    canvas.restore();
  }

  void _drawCir(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    canvas.save();
    canvas.translate(0, -size.height / 2 + 66);
    canvas.drawCircle(Offset(0, 0), 60, paint);
    canvas.restore();

    canvas.save();
    canvas.translate(0, -size.height / 2 + 186);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 60), paint);
    canvas.restore();
    canvas.drawArc(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100),
        pi / 6,
        pi / 18 * 30, // 270度 pi = 180度
        true,
        paint);

    canvas.drawCircle(Offset(20, 0), 5, paint..color = Colors.red);
    canvas.drawCircle(Offset(40, 0), 5, paint..color = Colors.red);
    canvas.drawCircle(Offset(60, 0), 5, paint..color = Colors.red);
  }

  void drawLine(Canvas canvas, Size size) {
    _paint
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
  }

  void _drawPoint(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(-120, -20),
      Offset(-80, -80),
      Offset(-40, -40),
      Offset(0, -100),
      Offset(40, -140),
      Offset(80, -160),
      Offset(120, -100),
    ];

    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(
        PointMode.polygon,
        points,
        _paint
          ..color = Colors.blue
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round);
    canvas.drawPoints(
        PointMode.points,
        points,
        _paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round);

    _paint
      ..color = Colors.green
      ..strokeWidth = 2;

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
  }

  void _drawRect(Canvas canvas, Size size) {
    _paint
      ..color = Colors.green
      ..strokeWidth = 2;

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

    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    /// 矩形中心构造
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    canvas.drawRect(rect, _paint);

    /// 左上右下 构造
    canvas.drawRect(Rect.fromLTRB(70, 50, 50, 70), _paint..color = Colors.red);

    /// 圆角矩形
    canvas.drawRRect(RRect.fromLTRBR(90, 70, 70, 90, Radius.circular(5)),
        _paint..color = Colors.red);

    /// 左上宽高构造
    canvas.drawRect(
        Rect.fromLTWH(-70, -70, 20, 20), _paint..color = Colors.orange);

    canvas.drawRRect(RRect.fromLTRBXY(-70, -70, -90, -90, 5, 5),
        _paint..color = Colors.orange);

    /// 矩形内切圆构造
    canvas.drawRect(Rect.fromCircle(center: Offset(-60, 60), radius: 10),
        _paint..color = Colors.green);
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(-90, 90, -70, 70,
            bottomLeft: Radius.circular(5)),
        _paint..color = Colors.green);

    /// 两点一个矩形
    canvas.drawRect(Rect.fromPoints(Offset(50, -50), Offset(70, -70)),
        _paint..color = Colors.deepPurple);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromPoints(Offset(70, -70), Offset(90, -90)),
            Radius.circular(5)),
        _paint);
  }

  void _drawDRRect(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    var outer = RRect.fromLTRBR(-100, -100, 100, 100, Radius.circular(20));
    var inner = RRect.fromLTRBR(-60, -60, 60, 60, Radius.circular(20));

    canvas.drawDRRect(outer, inner, _paint);
    var outer2 = RRect.fromLTRBR(-50, -50, 50, 50, Radius.circular(10));
    var inner2 = RRect.fromLTRBR(-40, -40, 40, 40, Radius.circular(10));
    canvas.drawDRRect(outer2, inner2, _paint..color = Colors.green);
  }

  final List<Color> colors = List<Color>.generate(
      256, (index) => Color.fromARGB(255 - index, 0, 255, 0));

  var colors2 = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  void _drawColor(Canvas canvas, Size size) {
    // canvas.drawColor(Colors.blue, BlendMode.lighten);
    // canvas.drawPaint(_paint
    //   ..color = Colors.red
    //   ..blendMode = BlendMode.lighten
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2);
    //
    // var path = Path();
    // path.lineTo(80, 80);
    // path.lineTo(-80, 80);
    // path.close();
    // // canvas.drawPath(path, _paint);
    // canvas.drawShadow(path, Colors.black87, 2, false);

    /// color 上 绘制颜色矩阵
    // Paint paint = Paint();
    // canvas.save();
    // canvas.translate(-20 * 8, -20 * 8); //平移画布
    // colors.asMap().forEach((key, value) {
    //   int line = key % 16; // 行 取余
    //   int row = key ~/ 16; //列
    //   var topLeft = Offset(20.0 * line, 20.0 * row);
    //   var rect = Rect.fromPoints(topLeft, topLeft.translate(20, 20));
    //   canvas.drawRect(rect, paint..color = value);
    // });
    // canvas.restore();

    /// 绘制图片像素
    // for (int i = 0; i < image22.width; i++) {
    //   for (int j = 0; j < image22.height; j++) {
    //     Ball ball = Ball();
    //     ball.x = i * d + d / 2;
    //     ball.y = j * d + d / 2;
    //     ball.r = d / 2;
    //     var color = Color(image22.getPixel(i, j));
    //     ball.color =
    //         Color.fromARGB(color.alpha, color.blue, color.green, color.red);
    //     balls.add(ball);
    //   }
    // }
    // print("color ${balls.length}");
    // canvas.translate(-size.width / 2 + 0, -size.height / 2 + 100);
    // balls.forEach((Ball ball) {
    //   canvas.drawCircle(
    //       Offset(ball.x, ball.y),
    //       ball.r,
    //       _paint
    //         ..color = ball.color
    //         ..style = PaintingStyle.fill);
    // });

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    /// color 下 着色器
    Paint paint = Paint();
    // paint
    //   ..style = PaintingStyle.stroke
    //   ..color = Colors.blue
    //   ..strokeJoin = StrokeJoin.miter // 衔接类型
    //   ..strokeWidth = 40
    //   ..shader = ui.Gradient.linear(Offset(0, 0), Offset(100, 0), colors2, pos,
    //       TileMode.repeated, Matrix4.rotationZ(pi / 3).storage);

    // canvas.drawLine(Offset(0, 0), Offset(200, 0), paint);

    /// 径向渐变
    // paint
    //   ..style = PaintingStyle.fill
    //   ..shader = ui.Gradient.radial(Offset.zero, 25, colors2,pos,TileMode
    //     .repeated,null,Offset(10,12),2);
    //
    // canvas.drawCircle(Offset(0, 0), 50, paint);

    /// 扫描渐变
    // paint
    //   ..style = PaintingStyle.fill
    //   ..shader = ui.Gradient.sweep(
    //       Offset.zero, colors2, pos, TileMode.mirror, pi / 2, pi);
    // // Coordinate coordinate = Coordinate(setP: 20, paint: paint);
    // // coordinate.paintT(canvas, size);
    //
    // canvas.drawCircle(Offset.zero, 50, paint);

    /// 图片着色器

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 40
      ..shader = ImageShader(
          _image!,
          TileMode.repeated,
          TileMode.repeated,
          Float64List.fromList([
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          ]));

// canvas.drawCircle(Offset(00,00), 140, paint);

    /// 滤色器

    paint.colorFilter = ColorFilter.mode(Colors.blueAccent, BlendMode.lighten);

    canvas.translate(-_image!.width / 2 - 100, -_image!.height / 2);
    canvas.save();

    //1
    _drawColorImage(canvas, paint);

    canvas.translate(200, 0);
    paint.colorFilter =
        ColorFilter.mode(Colors.redAccent, BlendMode.difference);
    _drawColorImage(canvas, paint);

    canvas.translate(0, -200);

    paint.colorFilter = ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      66,
      0,
      1,
      0,
      0,
      66,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      211,
    ]);

    _drawColorImage(canvas, paint);
    canvas.translate(-200, 0);
    paint.colorFilter = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    _drawColorImage(canvas, paint);
    canvas.restore();

    canvas.translate(0, 200);
    paint.colorFilter = ColorFilter.matrix(<double>[
      -1,
      0,
      0,
      0,
      90,
      0,
      1,
      0,
      0,
      90,
      0,
      0,
      1,
      0,
      90,
      0,
      0,
      0,
      1,
      0,
    ]);
    _drawColorImage(canvas, paint);
    canvas.translate(200, 0);
    paint.colorFilter = ColorFilter.matrix(<double>[
      -1,
      0,
      0,
      0,
      90,
      0,
      0.2,
      0.8,
      0,
      90,
      -0.5,
      -0.2,
      -0.3,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ]);
    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 20);
    paint.imageFilter = ui.ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6);
    paint.filterQuality = FilterQuality.high;
    _drawColorImage(canvas, paint);
  }

  _drawColorImage(Canvas canvas, Paint paint) {
    canvas.drawImageRect(
        _image!,
        Rect.fromLTRB(
            0, 0, _image!.width.toDouble(), _image!.height.toDouble()),
        Rect.fromLTRB(0, 0, _image!.width / 1, _image!.height / 1),
        paint);
  }

  void _drawImage(Canvas canvas, Size size) {
    // offset 左上角
    // canvas.drawImage(
    //     _image, Offset(-_image.width / 2, -_image.height / 2), _paint);
    // canvas.drawImageRect(
    //     _image,
    //     Rect.fromCenter(
    //         center: Offset(_image.width / 2, _image.height / 2),
    //         width: 20,
    //         height: 20),
    //     Rect.fromCenter(center: Offset(100, 0), width: 20, height: 20)
    //         .translate(20, -20),
    //     _paint);

    canvas.drawImageRect(
        _image!,
        Rect.fromCenter(
            center: Offset(_image!.width / 2, _image!.height / 2),
            width: 60,
            height: 60),
        Rect.fromLTRB(0, 0, 100, 100).translate(0, 200),
        _paint);
  }

  void _drawText(Canvas canvas, Size size) {
    // var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
    //     textAlign: TextAlign.center,
    //     fontSize: 20,
    //     textDirection: TextDirection.ltr,
    //     maxLines: 1))
    //   ..pushStyle(ui.TextStyle(color: Colors.black87))
    //   ..addText("Flutter Text");
    // ui.Paragraph paragraph = builder.build();
    // paragraph.layout(ui.ParagraphConstraints(width: 140));
    // canvas.drawParagraph(paragraph, Offset(0, 0));

    var textPainter = TextPainter(
        text: TextSpan(
            text: "Flutter Text",
            style: TextStyle(
              fontSize: 40,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1,
            )),
        textAlign: TextAlign.left,
        maxLines: 1,
        ellipsis: "...",
        textDirection: TextDirection.ltr);
    textPainter.layout();
    var size2 = textPainter.size;
    textPainter.paint(canvas, Offset(-size2.width / 2, -size2.height / 2));
    // textPainter.paint(canvas, Offset.zero);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size2.width, size2.height)
            .translate(-size2.width / 2, -size2.height / 2),
        _paint
          ..color = Colors.blue.withAlpha(33)
          ..style = PaintingStyle.fill);
  }

  /// path 绘制
  void _drawPath(Canvas canvas, Size size) {
    /// 坐标移动
    Path path = Path();
    // path
    //   ..moveTo(0, 0)
    //   ..lineTo(60, 60)
    //   ..lineTo(60, -60)
    //   ..lineTo(0, -120)
    //   ..close(); // 闭合路径 首尾相连
    // canvas.drawPath(path, _paint..style = PaintingStyle.fill);
    //
    // path
    //   ..moveTo(0, 0)
    //   ..lineTo(-60, 60)
    //   ..lineTo(-60, -60)
    //   ..lineTo(0, -120);
    // canvas.drawPath(path, _paint..style = PaintingStyle.stroke);

    /// 相对坐标移动
    // path
    //   ..relativeMoveTo(0, 0)
    //   ..relativeLineTo(100, 120)
    //   ..relativeLineTo(-10, -60)
    //   ..relativeLineTo(60, -10)
    //   ..close();
    //
    // canvas.drawPath(path, _paint..style = PaintingStyle.fill);

    // 圆弧 顺时针
    // path.lineTo(30, 30);
    // path.arcTo(Rect.fromCenter(center: Offset.zero, width: 200, height: 200),
    //     pi * 1.5, pi / 2, true);
    //
    // canvas.drawPath(path, _paint);

    /// 定点圆弧
    // Paint paint = Paint()
    //   ..color = Colors.purpleAccent
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.fill;
    //
    // path.lineTo(0, -20);
    // path.arcToPoint(Offset(20, 0),
    //     radius: Radius.circular(20), largeArc: true, clockwise: true);
    // path.close();
    // var bounds = path.getBounds();
    // canvas.save();
    // canvas.translate(-bounds.width / 2, bounds.height / 2);
    // canvas.drawPath(path, paint);
    // canvas.restore();

    // path.reset();
    // canvas.translate(0, -160);
    // path.lineTo(40, -40);
    // path.relativeArcToPoint(Offset(-40, 40),
    //     radius: Radius.circular(30), largeArc: true, clockwise: false);
    // path.close();
    // canvas.drawPath(path, paint);

    /// 圆锥曲线
    // path.conicTo(80, -100, 160, 0, 3);
    //
    // canvas.drawPoints(
    //   PointMode.points,
    //   [Offset(80, -100)],
    //   _paint
    //     ..strokeWidth = 10
    //     ..strokeCap = StrokeCap.round,
    // );
    //
    // canvas.drawPath(path, _paint);

    /// 贝塞尔曲线
    // final Offset p1 = Offset(100, -100);
    // final Offset p2 = Offset(160, 50);
    //
    // path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    //
    // canvas.drawLine(Offset.zero, p1, _paint);
    // canvas.drawLine(p1, p2, _paint);
    // canvas.drawPath(path, _paint..color = Colors.red);

    /// 为路径添加已有形状
    // var rect = Rect.fromPoints(Offset(-100, -100), Offset(-160, -160));
    //
    // path
    //   ..lineTo(-100, -100)
    //   ..addRect(rect)
    //   ..relativeLineTo(100, -100)
    //   ..addRRect(RRect.fromRectXY(rect.translate(100, -100), 10, 10));
    // canvas.drawPath(path, _paint);

    // path
    //   ..moveTo(0, -200)
    //   ..relativeCubicTo(100, 60, 20, 120, 40, 200)
    // ..moveTo(40,-160)..relativeLineTo(40, -40);
    //
    // canvas.drawPath(path, _paint);

    /// path 下

    // path
    //   ..relativeMoveTo(0, 10)
    //   ..relativeLineTo(-30, 120)
    //   ..relativeLineTo(30, -30)
    //   ..relativeLineTo(30, 30)
    //   ..close();
    // canvas.drawPath(path, _paint);

    // print("是否在path区域内：${path.contains(Offset(20, 20))}");
    // print(path.contains(Offset(0, 20)));
    // var bounds = path.getBounds();
    // canvas.drawRect(bounds, _paint);

    // for (int i = 0; i < 8; i++) {
    //   canvas.drawPath(
    //       path.transform(Matrix4.rotationZ(i * pi / 4).storage), _paint);
    // }

    /// 路径联合

    var pathOval = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60));
    path
      ..relativeMoveTo(0, 10)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close()
      ..addPath(pathOval, Offset.zero);
    // canvas.drawPath(Path.combine(PathOperation.union, path, pathOval),
    //     _paint..style = PaintingStyle.fill);
    canvas.drawPath(path, _paint..color = Colors.green);
    var pms = path.computeMetrics();

    pms.forEach((pm) {
      var tangent = pm.getTangentForOffset(pm.length * 1);
      print(
          "---position:-${tangent?.position}----angle:-${tangent?.angle}----vector:-${tangent?.vector}----");

      canvas.drawCircle(tangent!.position, 5, _paint..color = Colors.red);
    });
  }

  late Animation<double> animation;

  void _drawCDR(Canvas canvas, Size size) {
    //画头
    Paint paint = Paint()
      ..color = Colors.yellow.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    var rect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);

    /// 起始角度
    var a = pi / 6;
    // canvas.drawArc(rect, a, 2 * pi - a * 2, true, paint);
    Path path = Path();
    path.quadraticBezierTo(100, 100, 100, -30);
    canvas.drawPath(path, paint);

    //画眼睛

    // canvas.drawOval(
    //     Rect.fromCenter(
    //         center: Offset(0, -size.height / 3), width: 8, height: 8),
    //     paint..color = Colors.white);

    // 画豆豆
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width / 2.4, 0), width: 8, height: 8),
        paint..color = Colors.blue);
  }

  void _drawSyr(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1;

    canvas.drawCircle(Offset(0, -80), 20, paint);
    canvas.drawLine(Offset(0, -60), Offset(0, 0), paint);
    canvas.drawLine(Offset(0, -40), Offset(-40, -40), paint);
    canvas.drawLine(Offset(0, -40), Offset(40, -40), paint);
    canvas.drawLine(Offset(0, 0), Offset(-40, 40), paint);
    canvas.drawLine(Offset(0, 0), Offset(-40, 40), paint);
    Path path = Path();
    // path.relativeQuadraticBezierTo(x1, y1, x2, y2)
  }

  // 小海豚
  void _drawHt(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var path = Path();
    path.relativeCubicTo(-20, -80, -200, -100, -120, 100);
    canvas.drawPath(path, paint);
    var bounds = path.getBounds();
    canvas.drawRect(bounds, paint);
    canvas.save();
    path.relativeQuadraticBezierTo(-30, 10, -20, 40);
    canvas.drawPath(path, paint);
    canvas.restore();
    path.relativeQuadraticBezierTo(-30, 10, -20, 40);
    canvas.drawPath(path, paint);
  }

  void _drawXiaoA(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.green.shade800;

    canvas.drawRect(
        Rect.fromCenter(center: Offset(0, 0), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(4, 4), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(6, 6), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(8, 8), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(10, 10), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(12, 12), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(14, 14), width: 4, height: 20), paint);
    canvas.drawRect(
        Rect.fromCenter(center: Offset(16, 20), width: 4, height: 20), paint);
  }

  void _drawZan(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    canvas.drawLine(Offset(0, -20), Offset(0, 20), paint);

    path.moveTo(10, -20);
    path.relativeQuadraticBezierTo(10, -4, 14, -30);
    path.relativeQuadraticBezierTo(20, 5, 6, 30);
    path.relativeQuadraticBezierTo(10, 0, 30, 0);
    path.relativeQuadraticBezierTo(-5, 20, -10, 40);
    path.relativeQuadraticBezierTo(-5, 0, -40, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  List<Offset> points = [];
  final double step = 60;
  final double min = -160;
  final double max = 160;

  void initPoints() {
    for (double x = min; x < max; x += step) {
      points.add(Offset(x, f(x)));
    }

    points.add(Offset(max, f(max)));

    // points.add(Offset(max, f(max)));
  }

  double f(double x) {
    double y = -x * x / 200 + 100;
    return y;
  }

  void _drawPath2(Canvas canvas, Size size) {
    initPoints();
    Offset p1 = points[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);

    for (var i = 1; i < points.length - 1; i++) {
      // 终点
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;

      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }

    var computeMetrics = path.computeMetrics();
    computeMetrics.forEach((element) {
      var tangentForOffset = element.getTangentForOffset(element.length * 0.5);
      canvas.drawCircle(tangentForOffset!.position, 5, _paint);
    });

    canvas.drawPath(path, _paint);
  }

  void _drawLt(Canvas canvas, Size size) {
    Path path = Path();

    path.lineTo(-40, 120);
    path.moveTo(0, 0);
    path.lineTo(40, 120);

    path.quadraticBezierTo(0, 140, -40, 120);

    canvas.rotate(pi);

    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.fill
          ..color = Colors.black
          ..shader = ui.Gradient.radial(
              Offset(-40, 120), 140, [Colors.white, Colors.black87]));

    // canvas.drawArc(
    //     Rect.fromCenter(center: Offset(0, 60), width: 80, height: 120),
    //     0,
    //     pi,
    //     false,
    //     _paint);
  }
}

class Ball {
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r; // 半径

  Ball({this.x = 0, this.y = 0, this.color = Colors.black, this.r = 5});
}
