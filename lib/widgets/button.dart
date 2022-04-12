import 'package:flutter/material.dart';

class ButtonWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ButtonState();
  }
}

class _ButtonState extends State<ButtonWidgetDemo> {
  var isZan;

  @override
  void initState() {
    super.initState();
    isZan = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("3个button 属性用法完全一致（ButtonStyle）"),
          TextButton(onPressed: () {}, child: Text("TextButton")),
          OutlinedButton(onPressed: () {}, child: Text("OutlinedButton")),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "ElevatedButton",
              )),
          ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0)),
                  minimumSize: MaterialStateProperty.all(Size(0, 0)) // 按钮本身最小尺寸
                  ),
              onPressed: () {},
              child: Text(
                "ElevatedButton去边距",
                style: TextStyle(
                  fontSize: 20,
                   ),
              )),
          ElevatedButton(

              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(ContinuousRectangleBorder()),
                  elevation: MaterialStateProperty.all(1)),
              onPressed: () {},
              child: Text(
                "ElevatedButton去圆角",
              )),
          ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  elevation: MaterialStateProperty.all(1)),
              onPressed: () {},
              child: Text(
                "椭圆按钮",
              )),
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(20),
                overlayColor: MaterialStateProperty.all(Colors.white10), //点击效果
              ),
              onPressed: () {},
              child: Text(
                "ElevatedButton阴影",
              )),
          ElevatedButton(
            style: ButtonStyle(),
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info),
                Text(
                  "带图标button",
                )
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.thumb_up,
                color: isZan ? Colors.red : Colors.black,
              ),
              onPressed: () {
                setState(() {
                  if (isZan) {
                    isZan = false;
                  } else {
                    isZan = true;
                  }
                });
              })
        ],
      ),
    );
  }
}

/// 常用button属性
///   const ButtonStyle({
///   this.textStyle, //字体
///   this.backgroundColor, //背景色
///   this.foregroundColor, //前景色
///   this.overlayColor, // 高亮色，按钮处于focused, hovered, or pressed时的颜色
///   this.shadowColor, // 阴影颜色
///   this.elevation, // 阴影值
///   this.padding, // padding
///   this.minimumSize, //最小尺寸
///   this.side, //边框
///   this.shape, //形状
///   this.mouseCursor, //鼠标指针的光标进入或悬停在此按钮的[InkWell]上时。
///   this.visualDensity, // 按钮布局的紧凑程度
///   this.tapTargetSize, // 响应触摸的区域
///   this.animationDuration, //[shape]和[elevation]的动画更改的持续时间。
///   this.enableFeedback, // 检测到的手势是否应提供声音和/或触觉反馈。例如，在Android上
///   ，点击会产生咔哒声，启用反馈后，长按会产生短暂的振动。通常，组件默认值为true。
/// });
