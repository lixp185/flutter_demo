import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformDemo extends StatefulWidget {
  @override
  _TransformDemoState createState() => _TransformDemoState();
}

class _TransformDemoState extends State<TransformDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Transform(
              alignment: Alignment.topLeft, //相对于坐标系原点的对齐方式
              transform: Matrix4.skewY(-0.2), //沿Y轴倾斜0.2弧度
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Text("Apartment for rent!"),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(50),
            color: Colors.blue,
            child: Transform(
              alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
              transform: Matrix4.skewY(0.2), //沿Y轴倾斜0.2弧度
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(10),
                child: Text("Apartment for rent!"),
              ),
            ),
          ),
          Container(
              color: Colors.blue,
              child: Transform.translate(
                offset: Offset(-10, -10), // x,y轴 左上角0,0 跟屏幕坐标轴一样
                child: Text("平移"),
              )),
          Container(
              margin: EdgeInsets.all(20),
              color: Colors.blue,
              child: Transform.rotate(
                angle: math.pi * 1.5, // 旋转270
                child: Text("旋转"),
              )),
          Container(
              margin: EdgeInsets.all(20),
              color: Colors.blue,
              child: Transform.scale(
                scale: 1.2,
                child: Text("缩放 放大1.2倍"),
              )),

          Row(
            children: [
              
            ],
          )
        ],
      ),
    );
  }
}
