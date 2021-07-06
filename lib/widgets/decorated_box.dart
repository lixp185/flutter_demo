import 'package:flutter/material.dart';

class DecoratedBoxDemo extends StatefulWidget {
  @override
  _DecoratedBoxState createState() => _DecoratedBoxState();
}

class _DecoratedBoxState extends State<DecoratedBoxDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: DecoratedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Text(
                    "but",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue, Colors.blue[200]]),
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(1.0, 2.0),
                          blurRadius: 4)
                    ])),
          )
        ],
      ),
    );
  }
}
//  BoxDecoration({
//   Color color, //颜色
//   DecorationImage image,//图片
//   BoxBorder border, //边框
//   BorderRadiusGeometry borderRadius, //圆角
//   List<BoxShadow> boxShadow, //阴影,可以指定多个
//   Gradient gradient, //渐变
//   BlendMode backgroundBlendMode, //背景混合模式
//   BoxShape shape = BoxShape.rectangle, //形状
// })
