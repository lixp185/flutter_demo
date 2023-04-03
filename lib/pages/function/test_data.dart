import 'package:flutter/material.dart';

/// 数据共享
class CountData extends InheritedWidget {

  final Widget c;

  final int data; // 共享数据

  const CountData({
    Key? key,
    required this.c,
    required this.data,
  }) : super(key: key, child: c);

  /// 定义一个静态方法 获取数据
  static CountData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountData>();
    // return context.getElementForInheritedWidgetOfExactType<CountData>()!.widget
    //     as CountData;
  }

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(covariant CountData oldWidget) {
    return data != oldWidget.data;
    // return false;
  }
}


