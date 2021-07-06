import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yht_meeting/utils/sp_util.dart';

// app主题状态
class AppTheme extends ChangeNotifier {
  static const List<MaterialColor> materialColors = [
    Colors.blue,
    Colors.lightBlue,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.grey,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lightGreen,
    Colors.green,
    Colors.lime
  ];

  MaterialColor _mThemeColor;
  static MaterialColor _mThemeColor2;

  bool isDark = false;

  AppTheme(this._mThemeColor);

  MaterialColor get themeColor => _mThemeColor;

  changeDark(bool isDark) {
    this.isDark = isDark;
    notifyListeners();
  }

  // 根据 Platform 设置主题
  ThemeData get themeDate => getLightTheme();

  // 设置主题
  // void setTheme(ThemeData themeData) {
  //   themeDate = themeData;
  //   notifyListeners();
  // }

  // iOS浅色主题
  ThemeData getIOSTheme() {
    return ThemeData(
        primarySwatch: getDefaultTheme(),
        buttonColor: getDefaultTheme(),
        brightness: Brightness.dark,
        //深色主题
        accentColor: Color(0xFF888888));
  }

  ThemeData getAndroidTheme() {
    return ThemeData(
        primarySwatch: getDefaultTheme(),
        buttonColor: getDefaultTheme(),
        brightness: Brightness.light,
        //亮色主题
        accentColor: Color(0xFF888888));
  }

  // 获取默认主题
  static MaterialColor getDefaultTheme() {
    return materialColors[SpUtil.getThemeColorIndex()];
  }

  // 修改主题颜色
  void changeThemeColor(int colorIndex) {
    //   _mThemeColor = materialColors[colorIndex];
    // // 保存主题索引值
    //   SpUtil.saveThemeColorIndex(colorIndex);
    _mThemeColor2 = materialColors[colorIndex];
    notifyListeners();
    SpUtil.saveThemeColorIndex(colorIndex);
  }

  static const double normalFontSize = 15;
  static const double titleFontSize = 20;
  static const double subTitleFontSize = 18;

  static const Color lightThemeTextColor = Colors.black;
  static const Color darkThemeTextColor = Colors.white;

  static const Color cardColorLight = Colors.white;
  static const Color cardColorDark = Colors.blueGrey;

  // primarySwatch支持的主题色 可以
  static const Color materialColor = Colors.red;
  static const Color materialColor1 = Colors.pink;
  static const Color materialColor2 = Colors.purple;
  static const Color materialColor3 = Colors.deepPurple;
  static const Color materialColor4 = Colors.indigo;
  static const Color materialColor5 = Colors.blue;
  static const Color materialColor6 = Colors.lightBlue;
  static const Color materialColor7 = Colors.cyan;
  static const Color materialColor8 = Colors.teal;
  static const Color materialColor9 = Colors.green;
  static const Color materialColor10 = Colors.lightGreen;
  static const Color materialColor17 = Colors.lime;
  static const Color materialColor11 = Colors.yellow;
  static const Color materialColor12 = Colors.amber;
  static const Color materialColor13 = Colors.orange;
  static const Color materialColor14 = Colors.deepOrange;
  static const Color materialColor15 = Colors.brown;
  static const Color materialColor16 = Colors.blueGrey;

  // primarySwatch包含了 primaryColor 和 accentColor
  // （primaryColor和accentColor也可以单独设置）
  // primarySwatch实际传入的是MaterialColor，不是一个简单的color

  ThemeData getLightTheme() {
    return ThemeData(
        splashColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        highlightColor: Colors.transparent,
        //去除点击tabbar的过度效果
        brightness: isDark ? Brightness.dark : Brightness.light,
        //亮度，明亮模式
        primarySwatch: isDark ? Colors.blueGrey : _mThemeColor2,
        buttonColor: isDark ? Colors.blueGrey : _mThemeColor2,
        // primaryColor: Colors.red,
        //主要决定导航和底部bottombar颜色
        // accentColor: Colors.blue,
        //button和switch等颜色
        textTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: normalFontSize,
              color: isDark
                  ? darkThemeTextColor
                  : lightThemeTextColor), // material默认

//        可以通过Theme.of(context).textTheme.bodyText2获取
//        bodyText2:
//        headline1:
//        headline2:
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ButtonStyle(
        //         backgroundColor: MaterialStateProperty.all(Colors.blue),
        //         foregroundColor: MaterialStateProperty.all(Colors.white))),
        cardTheme: CardTheme(color: cardColorLight, elevation: 20));
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
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
                TextStyle(fontSize: normalFontSize, color: darkThemeTextColor)),
        cardTheme: CardTheme(color: cardColorDark, elevation: 20));
  }
}
