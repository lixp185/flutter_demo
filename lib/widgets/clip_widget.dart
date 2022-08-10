

import 'package:flutter/material.dart';

/// 作者： lixp
/// 创建时间： 2022/7/25 10:19
/// 类介绍：裁剪demo
class ClipWidget extends StatefulWidget {
  const ClipWidget({Key? key}) : super(key: key);

  @override
  _ClipWidgetState createState() => _ClipWidgetState();
}

class _ClipWidgetState extends State<ClipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ClipPath(
            clipper: MyClipPath(),
            child: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Text("aaaaaaaa"),
            ),
          ),
          ClipPath(
            clipper: MyClipPath2(),
            child: Container(
              color: Colors.green,
              width: 300,
              height: 400,

              child: Text("bbbbbbb"),
            ),
          ),
        ],
      )
    );
  }
}


class MyClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(100, 100,100,10);
    path.lineTo(100,10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return false;
  }
}
class MyClipPath2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(100, 50,100,10);
    path.lineTo(100,10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return false;
  }
}
