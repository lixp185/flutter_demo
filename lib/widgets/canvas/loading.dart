
import 'package:flutter/material.dart';

import '../coordinate.dart';


class LoadingDemo extends StatefulWidget {
  const LoadingDemo({Key? key}) : super(key: key);

  @override
  _LoadingDemoState createState() => _LoadingDemoState();
}

class ColorRectTween extends Tween<ColorRect?> {
  ColorRectTween({super.begin, super.end});

  @override
  ColorRect lerp(double t) {
    return ColorRect(Color.lerp(begin?.color, end?.color, t) ?? Colors.white,
        Rect.lerp(begin?.rect, end?.rect, t) ?? Rect.zero);
  }
}

class StringTween extends Tween<String> {
  StringTween({super.begin, super.end});

  @override
  String lerp(double t) {
    if ((t * 100).round() % 10 < 5) {
      return "$begin${end?.substring(0, ((end!.length * t).round()))} |";
    } else {
      return "$begin${end?.substring(0, ((end!.length * t).round()))}  ";
    }
  }
}

class ColorRect {
  Color color;
  Rect rect;

  ColorRect(this.color, this.rect);
}

class _LoadingDemoState extends State<LoadingDemo>
    with SingleTickerProviderStateMixin {






  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: _LoadingPaint(),
      ),
    );
  }
}

class _LoadingPaint extends CustomPainter {



  Coordinate coordinate = Coordinate(setP: 20);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    coordinate.paintT(canvas, size);


    Paint paint = Paint()
    ..color = Colors.black87
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;


    canvas.drawCircle(Offset(0, 0), 10, paint);





  }

  @override
  bool shouldRepaint(covariant _LoadingPaint oldDelegate) {
    return false;
  }


}
