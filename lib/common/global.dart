import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//全局变量
class Global {
  Global._internal();

  static Global instance = Global._internal();

  // 是否release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 打开程序初始化一些准备工作
  Future init() async {
    // if (Platform.isAndroid) {
    //   // 沉浸式
    //   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //   );
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // }
  }
}
