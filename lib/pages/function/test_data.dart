import 'package:flutter/material.dart';

/// 数据共享
class TestData extends InheritedWidget {
  final Widget child;

  final int data; // 共享数据

  // 构造
  const TestData({
    Key? key,
    required this.child,
    required this.data,
  }) : super(key: key, child: child);

  /// 定义一个静态方法 获取数据
  static TestData? of(BuildContext context) {
    // return context.dependOnInheritedWidgetOfExactType<TestData>();
    return context.getElementForInheritedWidgetOfExactType<TestData>()!.widget
        as TestData;
  }

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(covariant TestData oldWidget) {
    return data != oldWidget.data;
    // return false;
  }
}


