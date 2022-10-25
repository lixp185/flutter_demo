import 'package:flutter/material.dart';

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
  StringTween({super.begin,super.end});
  @override
  String lerp(double t) {
    if((t*100).round() % 10 <5){
      return "$begin${end?.substring(0,((end!.length*t).round()))} |";
    }else{
      return "$begin${end?.substring(0,((end!.length*t).round()))}  ";
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
  late AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat(reverse: false);

  // 控制器
  late Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  var a = ColorRect(Colors.yellow, Rect.fromCenter(center: Offset.zero, width: 50, height: 200));
  var b = ColorRect(Colors.red,
      Rect.fromLTWH(-100,50, 200,  50));
  // late Animation<ColorRect?> _animation =
  //     ColorRectTween(begin: a, end: b).animate(_controller);

  late  Animation<String> _animation =  StringTween(begin: '',end: "相信技术，传递价值。") .animate(_controller);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: _LoadingPaint(_controller),
      ),
    );
  }
}

class _LoadingPaint extends CustomPainter {
  // Animation<ColorRect?> animation;
  Animation<double?> animation;

  _LoadingPaint( this.animation) : super(repaint: animation);

  Paint _paint = Paint()
    ..color = Colors.black54
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    // Path path = Path();
    // path.addRect(animation.value!.rect);
    // canvas.drawPath(path, _paint..color = animation.value!.color);
    // var textPainter = TextPainter(
    //     text: TextSpan(
    //         text: animation.value,
    //         style: TextStyle(
    //           fontSize: 20,
    //           foreground: Paint()
    //             ..style = PaintingStyle.fill
    //             ..color = Colors.red
    //             ..strokeWidth = 1,
    //         )),
    //     textAlign: TextAlign.left,
    //     maxLines: 2,
    //     ellipsis: "...",
    //     textDirection: TextDirection.ltr);
    // textPainter.layout();
    // // Size textSize = textPainter.size;
    // textPainter.paint(canvas, Offset(-size.width/2+100,0));

    // canvas.drawLine(Offset(textSize.width, textSize.height), Offset(0, 0), _paint);


    canvas.drawCircle(Offset(0,animation.value!*10), 5, _paint);

  }

  @override
  bool shouldRepaint(covariant _LoadingPaint oldDelegate) {
    return animation.value!=oldDelegate.animation.value;
  }
}

//    /// 0..1
//
//     if (animation.value <= 0.25) {
//       canvas.drawCircle(Offset(0, 10 + 10 * animation.value * 4), 5, _paint);
//     } else if (animation.value <= 0.5) {
//       canvas.drawCircle(
//           Offset(0, 20 - 10 * (animation.value - 0.25) * 4), 5, _paint);
//     } else if (animation.value <= 0.75) {
//       canvas.drawCircle(
//           Offset(0, 10 - 10 * (animation.value - 0.5) * 4), 5, _paint);
//     } else if (animation.value <= 1) {
//       canvas.drawCircle(
//           Offset(0, 10 * (animation.value - 0.75) * 4), 5, _paint);
//     }
//     // 1  -  0.2 - 0
//     if (animation.value <= 0.25) {
//       canvas.drawCircle(Offset(20, 10 * animation.value * 4), 5, _paint);
//     } else if (animation.value <= 0.5) {
//       canvas.drawCircle(
//           Offset(20, 10 + 10 * (animation.value - 0.25) * 4), 5, _paint);
//     } else if (animation.value <= 0.75) {
//       canvas.drawCircle(
//           Offset(20, 20 - 10 * (animation.value - 0.5) * 4), 5, _paint);
//     } else if (animation.value <= 1) {
//       canvas.drawCircle(
//           Offset(20, 10 - 10 * (animation.value - 0.75) * 4), 5, _paint);
//     }
