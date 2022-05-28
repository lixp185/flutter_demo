import 'package:flutter/material.dart';

import 'my_tab.dart';

/// tabBar再次封装 需要修改样式在这里增加属性
class MyTabBar extends StatefulWidget implements PreferredSizeWidget {
  // tab文字数组
  final List<String> tabsStringList;
  final TabController tabController;
  final bool isScrollable; // 是否支持滚动
  final Decoration? decoration;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? labelPadding;
  final Decoration? indicator;
  final double? indicatorWeight;
  final Color? unselectedLabelColor; // 未选中文字颜色
  final Color? labelColor; // 选中文字颜色
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final TabBarIndicatorSize? indicatorSize;
  final double tabHeight;

  const MyTabBar({
    Key? key,
    required this.tabsStringList,
    required this.tabController,
    this.isScrollable = false,
    this.decoration,
    this.color,
    this.margin,
    this.padding,
    this.labelPadding,
    this.indicator,
    this.indicatorWeight,
    this.unselectedLabelColor,
    this.labelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorSize,
    this.tabHeight = 46.0,
  }) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(44);
}

class _MyTabBarState extends State<MyTabBar> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      color: widget.color,
      margin: widget.margin,
      padding: widget.padding,
      child: TabBar(
        tabs: widget.tabsStringList
            .map((value) =>
            MyTab(
              kTabHeight: widget.tabHeight,
              text: value,
              // child: Container(
              //   color: Colors.lightBlue,
              //   child: MyText(value,fontSize: 16.sp,),)
            ))
            .toList(),
        isScrollable: widget.isScrollable,
        controller: widget.tabController,
        // 指示器宽度计算方式
        indicatorSize: widget.indicatorSize ?? TabBarIndicatorSize.label,
        // 指示器padding
        indicatorPadding: EdgeInsets.all(0),
        // 指示器高度
        indicatorWeight: widget.indicatorWeight ?? 3.0,
        indicatorColor: Color(0x3b1e87),
        labelPadding: widget.labelPadding,
        indicator: widget.indicator,
        // 选中状态
        labelColor: widget.labelColor ?? Color(0x3b1e87),
        labelStyle: widget.labelStyle ??
            TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        // 未选中的状态
        unselectedLabelColor:
        widget.unselectedLabelColor ??  Color(0x333333),
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      ),
    );
  }
}
