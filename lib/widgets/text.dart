import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextWidgetState();
  }
}

class _TextWidgetState extends State<TextWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "文本属性倾斜",
            textAlign: TextAlign.left,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            "文本属性加粗",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "\n文本属性上划线",
            style: TextStyle(
              decoration: TextDecoration.overline,
            ),
          ),
          Text(
            "文本属性下划线",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            "文本属性删除线",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            "文本属性超出一行文本属性超出一行文本属性超出一行省略",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(text: "文本属性"),
            TextSpan(
                text: "展示不同效果",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.lineThrough,
                ))
          ])),
          Text.rich(TextSpan(children: [
            TextSpan(text: "github:"),
            TextSpan(
                text: "https://github.com/lixp185/flutter_demo",
                recognizer: TapGestureRecognizer()..onTap = () {
                  _launchURL("https://github.com/lixp185/flutter_demo");
                },
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ))
          ])),
        ],
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}

/// 常用text属性
/// textAlign: TextAlign.center, //文本对齐方式  居中
/// textDirection: TextDirection.ltr, //文本方向
/// softWrap: false, //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
/// overflow: TextOverflow.ellipsis, //文字超出屏幕之后的处理方式
///           TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
/// textScaleFactor: 2.0, //字体显示的赔率
/// maxLines: 10, //最大行数
/// style:TextStyle(
///   decorationColor: const Color(0xffffffff), //线的颜色
///   decoration: TextDecoration
///               .none, //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
///   decorationStyle: TextDecorationStyle
///       .solid, //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
///   wordSpacing: 0.0, //单词间隙(负值可以让单词更紧凑)
///   letterSpacing: 0.0, //字母间隙(负值可以让字母更紧凑)
///   fontStyle: FontStyle.italic, //文字样式，斜体和正常
///   fontSize: 20.0, //字体大小
///   fontWeight: FontWeight.w900, //字体粗细  粗体和正常
///   color: const Color(0xffffffff), //文字颜色
