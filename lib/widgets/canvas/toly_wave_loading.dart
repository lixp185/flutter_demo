import 'package:flutter/material.dart';

class TolyWaveLoading extends StatefulWidget {
  // 波高
  final double waveHeight;

  // 进度
  final double progress;

  // 颜色
  final Color color;

  // 尺寸
  final Size size;

  // 底波透明度
  final int secondAlpha;

  // 边线宽
  final double strokeWidth;

  // 圆角半径
  final double borderRadius;

  // 是否是椭圆
  final bool isOval;

  // 动画时长
  final Duration duration;

  // 动画曲线
  final Curve curve;

  const TolyWaveLoading(
      {Key? key,
      this.waveHeight = 5,
      this.progress = 0.5,
      this.color = Colors.red,
      this.size = const Size(60, 60),
      this.secondAlpha = 33,
      this.strokeWidth = 2,
      this.borderRadius = 20,
      this.isOval = false,
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.linear})
      : super(key: key);

  @override
  _TolyWaveLoadingState createState() => _TolyWaveLoadingState();
}

class _TolyWaveLoadingState extends State<TolyWaveLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: PaperPainter(
          waveHeight: widget.waveHeight,
          secondAlpha: widget.secondAlpha,
          color: widget.color,
          borderRadius: widget.borderRadius,
          isOval: widget.isOval,
          progress: widget.progress,
          strokeWidth: widget.strokeWidth,
          repaint: CurveTween(curve: widget.curve).animate(_controller)),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Animation<double> repaint;

  PaperPainter({
    required this.repaint,
    required this.waveHeight,
    required this.color,
    required this.progress,
    required this.secondAlpha,
    required this.borderRadius,
    required this.isOval,
    required this.strokeWidth,
  }) : super(repaint: repaint);

  final double waveHeight;
  final double progress;
  final Color color;
  final double strokeWidth;
  final int secondAlpha;
  final double borderRadius;
  final bool isOval;

  Paint _mainPaint = Paint();
  Path _mainPath = Path();
  double waveWidth = 0;
  double wrapHeight = 0;

  @override
  void paint(Canvas canvas, Size size) {
    _mainPath.reset();
    waveWidth = size.width / 2;
    wrapHeight = size.height;
    _mainPaint
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..color = color;
    Path path = Path();
    if (!isOval) {
      path.addRRect(
          RRect.fromRectXY(Offset(0, 0) & size, borderRadius, borderRadius));
      canvas.clipPath(path);
      canvas.drawPath(path, _mainPaint);
    }
    if (isOval) {
      path.addOval(Offset(0, 0) & size);
      canvas.clipPath(path);
      canvas.drawPath(path, _mainPaint);
    }

    canvas.translate(0, wrapHeight + waveHeight);
    canvas.translate(-4 * waveWidth + 2 * waveWidth * repaint.value, 0);
    drawWave(canvas);
    canvas.drawPath(
        _mainPath,
        _mainPaint
          ..style = PaintingStyle.fill
          ..color = color);

    canvas.translate(2 * waveWidth * repaint.value, 0);
    drawWave(canvas);
    canvas.drawPath(_mainPath, _mainPaint..color = color.withAlpha(88));
  }

  void drawWave(Canvas canvas) {


    _mainPath.moveTo(0, 0);
    _mainPath.relativeLineTo(0, -wrapHeight * progress);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    _mainPath.relativeQuadraticBezierTo(
        waveWidth / 2, waveHeight * 2, waveWidth, 0);
    _mainPath.relativeLineTo(0, wrapHeight);
    _mainPath.relativeLineTo(-waveWidth * 3 * 2.0, 0);
  }



  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint ||
      oldDelegate.waveHeight != waveHeight ||
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.isOval != isOval ||
      oldDelegate.secondAlpha != secondAlpha ||
      oldDelegate.borderRadius != borderRadius;
}
