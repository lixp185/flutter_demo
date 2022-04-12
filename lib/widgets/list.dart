import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_demo/widgets/my_easy_refresh.dart';

class ListViewWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

class ListViewState extends State<ListViewWidgetDemo> {
  final lis = [];
  final lisAdd = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 20; i++) {
      lis.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyEasyRefresh(
        onRefresh: () async {
          Future.delayed(Duration(milliseconds: 1000), () {
          setState(() {
            lis.clear();
            lis.addAll(lisAdd);
            lis.addAll(lisAdd);
            MyEasyRefresh.controller.finishRefresh();
            MyEasyRefresh.controller.resetLoadState();
          });

          });
        },
        onLoad: () async {
          Future.delayed(Duration(milliseconds: 1000), () {
            setState(() {
              lis.addAll(lisAdd);
              MyEasyRefresh.controller.finishLoad();
            });

          });
        },
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: lis.length,
            itemBuilder: (context, index) {
              return _listWidget(index);
            }));
  }

  Widget _listWidget(int index) {
    Widget widget;
    if (index % 2 == 0) {
      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 100,
              height: 50,
              alignment: Alignment.center,
              // constraints: BoxConstraints.tightFor(width: 150, height: 50),
              color: Colors.blue[200],
              child: Text(
                index.toString(),
                style: TextStyle(),
              )),
        ],
      );
    } else {
      widget = Container(
          alignment: Alignment.bottomCenter,
          color: Colors.red[200],
          margin: EdgeInsets.all(10),
          child: Text(index.toString()));
    }
    return widget;
  }
}

/// listView 常用 属性

/// Axis scrollDirection = Axis.vertical,//滚动方向
/// bool reverse = false,
/// ScrollController controller, // 滚动控制 主要是控制滚动位置和监听滚动事件

/// primary 为true时 controller 必须为null，也就是不用穿参 为true时会直接使用：PrimaryScrollController
/// bool primary,
/// ScrollPhysics physics,//接收ScrollPhysics类型的对象，决定可滚动组件如何响应用户操作
/// bool shrinkWrap = false,//是否根据子组件的总长度来设置ListView的长度
/// EdgeInsetsGeometry padding,
/// 该参数如果不为null，则会强制children的高度为itemExtent的值 横向为宽度 纵向为高度
/// this.itemExtent,

/// 构造item 及其 item的个数
/// @required IndexedWidgetBuilder itemBuilder,
/// int itemCount,//如果为null，则视为无限列表
///
/// 是否将item包裹在AutomaticKeepAlive 组件中
/// bool addAutomaticKeepAlives = true,
/// 是否将item包裹在RepaintBoundary组件中
/// bool addRepaintBoundaries = true,
