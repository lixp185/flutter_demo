import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ListViewWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

class ListViewState extends State<ListViewWidgetDemo> {
  List<NewsListBean> lis = <NewsListBean>[];

  late ScrollController _scrollController = ScrollController();
  String imageUrl =
      "https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";

  GlobalKey _globalKey = GlobalKey();

  double angle = 0;
  double bannerHeight = 200;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        double appBarHeight = 56;
        double stateHeight = MediaQuery.of(context).padding.top == 0
            ? 36
            : MediaQuery.of(context).padding.top;
        double h = MediaQuery.of(context).size.height; //屏幕高度

        RenderBox? renderBox =
            _globalKey.currentContext?.findRenderObject() as RenderBox?;
        double? dy = renderBox?.localToGlobal(Offset.zero).dy;
        // 56 AppBar 高度
        if (dy != null) {
          // 广告距离AppBar Y轴距离
          var bannerY = dy - appBarHeight - stateHeight;
          // 主内容区域高度
          var contentHeight = h - appBarHeight - stateHeight;
          if (bannerY + bannerHeight < contentHeight && bannerY > 0) {
            setState(() {
              //滑动的距离
              angle = pi *
                  ((contentHeight - bannerHeight - bannerY) /
                      (contentHeight - bannerHeight));
              // 前半部分 0-90 后半部分 270-360
              if (angle >= (pi / 2)) {
                angle = angle + pi;
              }
            });
          }
        }
      });

      print(
          'stateHeight22:${WidgetsBinding.instance!.window.padding.top / WidgetsBinding.instance!.window.devicePixelRatio}');
      print(
          'stateHeight22:${MediaQueryData.fromWindow(window).padding.top}');
    });

    super.initState();
    for (int i = 0; i < 40; i++) {
      lis.add(NewsListBean(
        i.isEven ? 0 : 1,
        "资讯标题$i",
        imageUrl,
      ));
    }
    // 插入广告
    lis.insert(12, NewsListBean(2, "广告", imageUrl));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: lis.length,
        itemBuilder: (context, index) {
          return _listWidget(lis[index]);
        });
  }

  Widget _listWidget(NewsListBean bean) {
    late Widget widget;
    switch (bean.type) {
      case 0:
        widget = Container(
            height: 50,
            padding: EdgeInsetsDirectional.only(start: 20),
            alignment: Alignment.centerLeft,
            color: Colors.blue[200],
            child: Text(
              bean.title,
              style: TextStyle(),
            ));
        break;
      case 1:
        widget = Row(
          children: [
            Expanded(
              child: Container(
                  height: 80,
                  alignment: Alignment.center,
                  color: Colors.red[200],
                  margin: EdgeInsets.all(10),
                  child: Text(bean.title)),
            ),
            Image.network(
              bean.image,
              width: 40,
              height: 40,
            )
          ],
        );
        break;
      case 2:
        widget = Container(
            padding: EdgeInsetsDirectional.only(
                start: 20, end: 20, top: 30, bottom: 30),
            height: bannerHeight,
            key: _globalKey,
            child: Transform(
              alignment: Alignment.center, //相对于坐标系原点的对齐方式
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(0)
                ..rotateZ(pi / 2)
                ..rotateY(angle),
              child: Image.asset(
                "images/img.png",
                fit: BoxFit.fill,
              ),
            ));
        break;
      default:
        widget = SizedBox();
        break;
    }
    return widget;
  }
}

class NewsListBean {
  //资讯类型 0:资讯无图 1:资讯有图 2：3d广告
  final int type;
  final bool isFirst;
  final String title;
  final String image;

  NewsListBean(this.type, this.title, this.image, {this.isFirst = false});
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
