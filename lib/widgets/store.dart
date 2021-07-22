
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_demo/common/theme_common.dart';

class Store{
  /// 单例
  Store._internal();

  /// 全局初始化
  static init(Widget child) {
    //多个Provider
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AppTheme(ThemeCommon.lightTheme)),
      ],
      child: child,
    );
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  //获取值 of(context)  这个会引起页面的整体刷新，如果全局是页面级别的
  static T of<T>(BuildContext context, {bool listen = true}) {
    return Provider.of<T>(context, listen: listen);
  }

  // 不会引起页面的刷新，只刷新了 Consumer 的部分，极大地缩小你的控件刷新范围
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}