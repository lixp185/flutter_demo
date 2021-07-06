import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget {
  final int data;

  ShareDataWidget({this.data, Widget child}) : super(child: child);

  // 依赖数据调用didChangeDependencies()方法
  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  // 依赖数据不调用didChangeDependencies()方法
  static ShareDataWidget of2(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
        .widget;
  }

  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}
