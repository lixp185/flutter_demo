import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';
import 'package:flutter_demo/widgets/animated2.dart';
import 'package:flutter_demo/widgets/baseful_widget.dart';
import 'package:flutter_demo/widgets/calendar.dart';
import 'package:flutter_demo/widgets/canvas/bw.dart';
import 'package:flutter_demo/widgets/canvas/dolphin.dart';
import 'package:flutter_demo/widgets/canvas/gestures_unlock.dart';
import 'package:flutter_demo/widgets/canvas/oval_loading.dart';
import 'package:flutter_demo/widgets/canvas/touch_controller.dart';
import 'package:flutter_demo/widgets/canvas/xin_sui.dart';
import 'package:flutter_demo/widgets/canvas_demo.dart';
import 'package:flutter_demo/widgets/hero_demo.dart';
import 'package:flutter_demo/widgets/paint_demo.dart';
import 'package:flutter_demo/widgets/polygonal_demo.dart';
import 'package:flutter_demo/widgets/scroll_navigation.dart';
import 'package:flutter_demo/widgets/tab_bar_demo.dart';
import 'package:flutter_demo/widgets/zan.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as image;

import '../widgets/autocomplete_demo.dart';
import '../widgets/canvas/fan_book.dart';
import '../widgets/canvas/joystick.dart';
import '../widgets/canvas/loading.dart';
import '../widgets/clip_widget.dart';
import '../widgets/logo.dart';
import '../widgets/world.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget>
    with AutomaticKeepAliveClientMixin {
  final _list = [];

  Future<ui.Image>? loadImageInAssets(String assetsName) async {
    return decodeImageFromList(
        (await rootBundle.load(assetsName)).buffer.asUint8List());
  }

  Future<image.Image?> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return image.decodeImage(bytes);
  }

  @override
  void initState() {
    super.initState();

    _list.add(_getWidget(
        HomeBean("多边形多角星", "lib/widgets/hero_demo.dart", const PolygonalDemo())));

    _list.add(_getWidget(
        HomeBean("围棋棋盘", "lib/widgets/canvas_demo.dart", CanvasDemo())));

    loadImageInAssets('images/lbxx.png')?.then((value) {
      loadImageFromAssets('images/lbxx.png').then((value2) {
        setState(() {
          _list.add(_getWidget(HomeBean(
              "绘制（妙笔生花）",
              "lib/widgets/paint_demo.dart",
              PaintDemo(
                image: value,
                image22: value2,
              ))));
        });
      });
    });
    _list.add(_getWidget(
        HomeBean("日期组件", "lib/widgets/calendar.dart", CalendarDemo())));
    _list.add(_getWidget(
        HomeBean("Hero动画", "lib/widgets/hero_demo.dart", const HeroDemo())));
    _list.add(_getWidget(
        HomeBean("TabBar", "lib/widgets/hero_demo.dart", const TabBarDemo())));
    _list.add(
        _getWidget(HomeBean("水波纹", "lib/widgets/hero_demo.dart", const BwDemo())));
    _list.add(_getWidget(
        HomeBean("牛顿摆", "lib/widgets/hero_demo.dart", const OvalLoading())));
    _list.add(
        _getWidget(HomeBean("心碎的感觉", "lib/widgets/hero_demo.dart", const XinSui())));
    _list.add(_getWidget(
        HomeBean("手势解锁", "lib/widgets/hero_demo.dart", const GesturesUnlock())));
    _list.add(_getWidget(HomeBean(
        "吃豆人loading", "lib/widgets/paint2_demo.dart", const Animated2Demo())));
    _list.add(
        _getWidget(HomeBean("点赞", "lib/widgets/paint2_demo.dart", const ZanDemo())));
    _list.add(_getWidget(HomeBean(
        "自定义导航条", "lib/widgets/scroll_navigation.dart", const ScrollNavigation())));
    // _list.add(_getWidget(
    //     HomeBean("HomeBean端午粽子", "lib/widgets/scroll_navigation.dart", ZongZiKePu())));
    _list
        .add(_getWidget(HomeBean("粒子运动", "lib/widgets/world.dart", const World())));
    _list.add(_getWidget(
        HomeBean("掘金logo", "lib/widgets/logo_demo.dart", const LogoDemo())));
    _list.add(_getWidget(
        HomeBean("loadingDemo", "lib/widgets/loading.dart", const LoadingDemo())));
    _list.add(_getWidget(
        HomeBean("联想词填充", "lib/widgets/loading.dart", const AutocompleteDemo())));

    _list.add(_getWidget(
        HomeBean("移动demo", "lib/widgets/move_demo.dart", const JoyStick())));
    _list.add(_getWidget(
        HomeBean("裁剪", "lib/widgets/clip_widget.dart", const ClipWidget())));
    _list.add(
        _getWidget(HomeBean("翻书demo", "lib/widgets/fan_book.dart", const FanBook())));
    var touchController = TouchController();
    loadImageInAssets('images/img_2.png')?.then((value) {
      setState(() {
        _list.add(_getWidget(
            HomeBean(
                "贝塞尔练习",
                "lib/widgets/scroll_navigation.dart",
                Dolphin(
                  touchController: touchController,
                  image: value,
                )), onRightClick: () {
          touchController.removeLast();
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: const EdgeInsets.only(left: 0, right: 0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToWidget(_getWidget(HomeBean("示例demo", "", null, type: 1))),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _list[index];
              }, childCount: _list.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5, // 左右间距
                  childAspectRatio: 1,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5 // 上下间距
                  ),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getWidget(HomeBean homeBean, {VoidCallback? onRightClick}) {
    if (homeBean.type == null) {
      return Container(
          padding: const EdgeInsets.all(2),
          width: double.infinity,
          child: ElevatedButton(
            child: Text(homeBean.title),
            onPressed: () {
              if (homeBean.title == "端午粽子") {
                _startAty(homeBean.page!, "", homeBean.path!,
                    onRightClick: onRightClick);
              } else {
                _startAty(homeBean.page!, homeBean.title, homeBean.path!,
                    onRightClick: onRightClick);
              }
            },
          ));
    } else if (homeBean.type == 1) {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Text(
          """${homeBean.title} ${String.fromCharCodes(Runes("\u2665"))}""",
          style: const TextStyle(fontSize: 14),
        ),
      );
    } else {
      return const Text("xxx");
    }
  }

  void _startAty(Widget widget, String title, String path,
      {VoidCallback? onRightClick}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext c) {
              // return ListViewWidgetDemo();

              return BaseStatefulWidget(
                widget,
                title,
                path,
                onClick: onRightClick,
              );
            }));
  }
}
