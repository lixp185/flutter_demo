import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


/// 再次对刷新控件进行封装
class MyEasyRefresh extends StatefulWidget {
  final Widget? child;

  /// 控制器
  static final EasyRefreshController controller = EasyRefreshController();

  /// 刷新回调(null为不开启刷新)
  final OnRefreshCallback? onRefresh;

  /// 加载回调(null为不开启加载)
  final OnLoadCallback? onLoad;

  MyEasyRefresh({Key? key, required this.child, this.onRefresh, this.onLoad})
      : super(key: key);

  @override
  _MyEasyRefreshState createState() => _MyEasyRefreshState();
}

class _MyEasyRefreshState extends State<MyEasyRefresh> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      // 自己控制是否刷新或者加载完成
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      child: widget.child,
      controller: MyEasyRefresh.controller,
      onLoad: widget.onLoad,
      onRefresh: widget.onRefresh,
      header: ClassicalHeader(
          infoText: "下拉刷新",
          refreshedText: "刷新完成",
          refreshText: "下拉刷新",
          refreshingText: "刷新中...",
          refreshReadyText: "松手刷新"),
      footer: ClassicalFooter(
          infoText: "",
          loadingText: "加载中...",
          textColor: Colors.black54,
          noMoreText: "没有更多数据了~"),
    );
  }
}
