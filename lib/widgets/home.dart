import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';
import 'package:flutter_demo/widgets/canvas/gestures_unlock.dart';
import 'package:flutter_demo/widgets/canvas/touch_controller.dart';
import 'package:flutter_demo/widgets/canvas/xin_sui.dart';

import 'package:flutter_demo/widgets/table_demo.dart';
import 'package:flutter_demo/widgets/zan.dart';
import 'dart:ui' as ui;
import 'align.dart';
import 'animated.dart';
import 'animated2.dart';
import 'baseful_widget.dart';
import 'button.dart';
import 'calendar.dart';
import 'canvas/bw.dart';
import 'canvas/dolphin.dart';
import 'canvas/fan_book.dart';
import 'canvas/joystick.dart';
import 'canvas/oval_loading.dart';
import 'canvas_demo.dart';
import 'check.dart';
import 'clip_widget.dart';
import 'container.dart';
import 'flex_demo.dart';
import 'hero_demo.dart';
import 'move_damo.dart';
import 'padding.dart';
import 'decorated_box.dart';
import 'dialog.dart';
import 'gesture_detector.dart';
import 'icon.dart';
import 'list.dart';
import 'listener.dart';
import 'paint2_demo.dart';
import 'paint_demo.dart';
import 'polygonal.dart';
import 'progress.dart';
import 'scroll_navigation.dart';
import 'size_box.dart';
import 'stack.dart';
import 'summer.dart';
import 'tab_bar_demo.dart';
import 'test.dart';
import 'text.dart';
import 'text_field.dart';
import 'theme.dart';
import 'transform.dart';
import 'wrap.dart';
import 'package:image/image.dart' as image;

import 'yy_text_demo.dart';
import 'zong_zI_ke_pu.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget>
    with AutomaticKeepAliveClientMixin {
  var gifts = new Map();

  var homeList = [];

  //状态保持实现方法 返回true保持页面状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    homeList.add(_getWidget(
        HomeBean("布局demo", "lib/widgets/hero_demo.dart", FlexDemo())));
    homeList.add(_getWidget(
        HomeBean("移动demo", "lib/widgets/move_demo.dart", JoyStick())));
    homeList.add(_getWidget(
        HomeBean("裁剪", "lib/widgets/clip_widget.dart", ClipWidget())));
    homeList.add(_getWidget(
        HomeBean("翻书demo", "lib/widgets/fan_book.dart", FanBook())));
    homeList.add(_getWidget(
        HomeBean("表格组件demo", "lib/widgets/table_demo.dart", TableDemo())));
    homeList.add(_getWidget(
        HomeBean("主题(状态)", "lib/widgets/theme.dart", ThemeWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("文本(Text)", "lib/widgets/text.dart", TextWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("按钮(Button)", "lib/widgets/button.dart", ButtonWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("图片(Image/Icon)", "lib/widgets/icon.dart", IconWidgetDemo())));
    homeList.add(_getWidget(HomeBean(
        "单选复选框(CheckBox)", "lib/widgets/check.dart", CheckBoxWidgetDemo())));
    homeList.add(_getWidget(HomeBean("输入框表单(TextField)",
        "lib/widgets/text_field.dart", TextFieldWidgetDemo())));
    homeList.add(_getWidget(HomeBean(
        "进度条(progress)", "lib/widgets/progress.dart", ProgressWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("弹窗(dialog)", "lib/widgets/dialog.dart", DialogWidgetDemo())));
    homeList.add(_getWidget(HomeBean(
        "列表(ListView)", "lib/widgets/list.dart", ListViewWidgetDemo())));

    homeList.add(_getWidget(
        HomeBean("自适应(Wrap)", "lib/widgets/wrap.dart", WrapWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("帧布局(Stack)", "lib/widgets/stack.dart", StackWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("相对位置控制(Align)", "lib/widgets/align.dart", AlignDemo())));
    homeList.add(_getWidget(
        HomeBean("边距控制(Padding)", "lib/widgets/padding.dart", PaddingDemo())));
    homeList.add(_getWidget(
        HomeBean("尺寸限制类容器", "lib/widgets/size_box.dart", SizeBoxDemo())));
    homeList.add(_getWidget(HomeBean("装饰(DecoratedBox)",
        "lib/widgets/decorated_box.dart", DecoratedBoxDemo())));
    homeList.add(_getWidget(HomeBean(
        "Transform(变换)", "lib/widgets/transform.dart", TransformDemo())));
    homeList.add(_getWidget(HomeBean(
        "包裹(Container)", "lib/widgets/container.dart", ContainerDemo())));
    homeList.add(_getWidget(HomeBean(
        "手势监听(Listener)", "lib/widgets/listener.dart", ListenerWidgetDemo())));

    homeList.add(_getWidget(HomeBean("手势识别(GestureDetector)",
        "lib/widgets/gesture_detector.dart", GestureDetectorDemo())));

    homeList.add(_getWidget(HomeBean(
        "Animated(动画)", "lib/widgets/animated.dart", AnimateWidgetDemo())));

    homeList.add(_getWidget(
        HomeBean("日期组件", "lib/widgets/calendar.dart", CalendarDemo())));
    homeList.add(_getWidget(
        HomeBean("Hero动画", "lib/widgets/hero_demo.dart", HeroDemo())));
    homeList.add(_getWidget(
        HomeBean("TabBar", "lib/widgets/hero_demo.dart", TabBarDemo())));
    homeList.add(
        _getWidget(HomeBean("水波纹", "lib/widgets/hero_demo.dart", BwDemo())));
    homeList.add(_getWidget(
        HomeBean("牛顿摆", "lib/widgets/hero_demo.dart", OvalLoading())));
    homeList.add(
        _getWidget(HomeBean("心碎的感觉", "lib/widgets/hero_demo.dart", XinSui())));
    homeList.add(_getWidget(
        HomeBean("手势解锁", "lib/widgets/hero_demo.dart", GesturesUnlock())));

    homeList.add(_getWidget(
        HomeBean("多边形多角星", "lib/widgets/hero_demo.dart", Polygonal())));

    homeList.add(_getWidget(HomeBean(
        "围棋棋盘", "lib/widgets/canvas_demo.dart", CanvasDemo())));
    loadImageInAssets('images/lbxx.png')?.then((value) {
      loadImageFromAssets('images/lbxx.png').then((value2) {
        setState(() {
          homeList.add(_getWidget(HomeBean(
              "绘制（妙笔生花）",
              "lib/widgets/paint_demo.dart",
              PaintDemo(
                image: value,
                image22: value2,
              ))));
        });
      });
    });
    homeList.add(_getWidget(HomeBean(
        "吃豆人loading", "lib/widgets/paint2_demo.dart", Animated2Demo())));
    homeList.add(
        _getWidget(HomeBean("点赞", "lib/widgets/paint2_demo.dart", ZanDemo())));
    homeList.add(_getWidget(HomeBean(
        "自定义导航条", "lib/widgets/scroll_navigation.dart", ScrollNavigation())));
    homeList.add(_getWidget(
        HomeBean("端午粽子", "lib/widgets/scroll_navigation.dart", ZongZiKePu())));

    // homeList.add(_getWidget(
    //     HomeBean("语音识别", "lib/widgets/yy_text_demo.dart", YYTextDemo())));
    // loadImageInAssets('images/duanwu.webp')?.then((value) {
    //   setState(() {
    //     homeList.add(_getWidget(
    //         HomeBean(
    //             "粽子",
    //             "lib/widgets/summer.dart",
    //             Summer(
    //               image: value,
    //             )),));
    //   });
    // });

    var touchController = TouchController();
    loadImageInAssets('images/ht.png')?.then((value) {
      setState(() {
        homeList.add(_getWidget(
            HomeBean(
                "贝塞尔",
                "lib/widgets/scroll_navigation.dart",
                Dolphin(
                  touchController: touchController,
                  image: value,
                )), onRightClick: () {
          touchController.removeLast();
        }));
      });
    });

    super.initState();
  }

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

  ui.Image? _image;

  Widget _getWidget(HomeBean homeBean, {VoidCallback? onRightClick}) {
    if (homeBean.type == null) {
      return Container(
          padding: EdgeInsets.all(2),
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
        margin: EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Text(
          """${homeBean.title} ${String.fromCharCodes(Runes("\u2665;"))}""",
          style: TextStyle(fontSize: 14),
        ),
      );
    } else {
      return Text("xxx");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(left: 0, right: 0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToWidget(_getWidget(HomeBean("基础组件", "", null, type: 1))),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return homeList[index];
                  }, childCount: homeList.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5, // 左右间距
                      childAspectRatio: 1,
                      crossAxisCount: 3,
                      mainAxisSpacing: 5 // 上下间距
                      ),
                ),
              ],
            )));
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
