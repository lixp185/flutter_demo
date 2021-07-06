import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeCommon with ChangeNotifier {

  static const double normalFontSize = 15;
  static const double titleFontSize = 20;
  static const double subTitleFontSize = 18;

  static final Color lightThemeTextColor = Colors.black;
  static final Color darkThemeTextColor = Colors.white;

  static final Color cardColorLight = Colors.white;
  static final Color cardColorDark = Colors.blueGrey;

  // primarySwatch支持的主题色
  static final Color materialColor = Colors.red;
  static final Color materialColor1 = Colors.pink;
  static final Color materialColor2 = Colors.purple;
  static final Color materialColor3 = Colors.deepPurple;
  static final Color materialColor4 = Colors.indigo;
  static final Color materialColor5 = Colors.blue;
  static final Color materialColor6 = Colors.lightBlue;
  static final Color materialColor7 = Colors.cyan;
  static final Color materialColor8 = Colors.teal;
  static final Color materialColor9 = Colors.green;
  static final Color materialColor10 = Colors.lightGreen;
  static final Color materialColor17 = Colors.lime;
  static final Color materialColor11 = Colors.yellow;
  static final Color materialColor12 = Colors.amber;
  static final Color materialColor13 = Colors.orange;
  static final Color materialColor14 = Colors.deepOrange;
  static final Color materialColor15 = Colors.brown;
  static final Color materialColor16 = Colors.blueGrey;

  // primarySwatch包含了 primaryColor 和 accentColor
  // （primaryColor和accentColor也可以单独设置）
  // primarySwatch实际传入的是MaterialColor，不是一个简单的color
  static ThemeData lightTheme = ThemeData(
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      highlightColor: Colors.transparent,
      //去除点击tabbar的过度效果
      brightness: Brightness.light,
      //亮度，明亮模式
      primarySwatch: Colors.blue,
      // primaryColor: Colors.red,//主要决定导航和底部bottombar颜色
      //   accentColor: Colors.blue,//button和switch等颜色
      textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: normalFontSize, color: lightThemeTextColor), // material默认
        //可以通过Theme.of(context).textTheme.bodyText2获取
        // bodyText2:
        // headline1:
        // headline2:
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white))),
      cardTheme: CardTheme(color: cardColorLight, elevation: 20));

  static ThemeData darkTheme = ThemeData(
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      highlightColor: Colors.transparent,
      //去除点击tabbar的过度效果
      brightness: Brightness.dark,
      //亮度，暗黑模式（）
      primarySwatch: Colors.blueGrey,
      // primaryColor: Colors.blueGrey,//主要决定导航和底部bottombar颜色
      // accentColor: Colors.blue,//button和switch等颜色
      textTheme: TextTheme(
          bodyText1:
              TextStyle(fontSize: normalFontSize, color: darkThemeTextColor)
          //可以通过Theme.of(context).textTheme.bodyText2获取
          // bodyText2:
          // headline1:
          // headline2:
          ),
      buttonTheme: ButtonThemeData(height: 25, minWidth: 10),
      cardTheme: CardTheme(color: cardColorDark, elevation: 20));
}
