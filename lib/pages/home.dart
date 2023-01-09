
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';
import 'package:flutter_demo/widgets/autocomplete_demo.dart';
import 'package:flutter_demo/widgets/canvas/gestures_unlock.dart';
import 'package:flutter_demo/widgets/canvas/loading.dart';
import 'package:flutter_demo/widgets/canvas/touch_controller.dart';
import 'package:flutter_demo/widgets/canvas/world.dart';
import 'package:flutter_demo/widgets/canvas/xin_sui.dart';
import 'package:flutter_demo/widgets/table_demo.dart';

import '../widgets/align.dart';
import '../widgets/animated.dart';
import '../widgets/baseful_widget.dart';
import '../widgets/button.dart';
import '../widgets/calendar.dart';
import '../widgets/canvas/bw.dart';
import '../widgets/canvas/dolphin.dart';
import '../widgets/canvas/fan_book.dart';
import '../widgets/canvas/joystick.dart';
import '../widgets/canvas/oval_loading.dart';
import '../widgets/check.dart';
import '../widgets/clip_widget.dart';
import '../widgets/container.dart';
import '../widgets/decorated_box.dart';
import '../widgets/dialog.dart';
import '../widgets/flex_demo.dart';
import '../widgets/gesture_detector.dart';
import '../widgets/hero_demo.dart';
import '../widgets/icon.dart';
import '../widgets/list.dart';
import '../widgets/listener.dart';
import '../widgets/logo.dart';
import '../widgets/padding.dart';
import '../widgets/progress.dart';
import '../widgets/size_box.dart';
import '../widgets/stack.dart';
import '../widgets/tab_bar_demo.dart';
import '../widgets/text.dart';
import '../widgets/text_field.dart';
import '../widgets/theme.dart';
import '../widgets/transform.dart';
import '../widgets/wrap.dart';


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
        HomeBean("粒子运动", "lib/widgets/world.dart", World())));
    homeList.add(_getWidget(
        HomeBean("掘金logo", "lib/widgets/logo_demo.dart", LogoDemo())));
  homeList.add(_getWidget(
        HomeBean("loadingDemo", "lib/widgets/loading.dart", LoadingDemo())));
    homeList.add(_getWidget(
        HomeBean("联想词填充", "lib/widgets/loading.dart", AutocompleteDemo())));
    homeList.add(_getWidget(
        HomeBean("布局demo", "lib/widgets/hero_demo.dart", FlexDemo())));
    homeList.add(_getWidget(
        HomeBean("移动demo", "lib/widgets/move_demo.dart", JoyStick())));
    homeList.add(_getWidget(
        HomeBean("裁剪", "lib/widgets/clip_widget.dart", ClipWidget())));
    homeList.add(
        _getWidget(HomeBean("翻书demo", "lib/widgets/fan_book.dart", FanBook())));
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



    super.initState();
  }



  Widget _getWidget(HomeBean homeBean,) {
    if (homeBean.type == null) {
      return Container(
          padding: EdgeInsets.all(2),
          width: double.infinity,
          child: ElevatedButton(
            child: Text(homeBean.title),
            onPressed: () {
              _startAty(homeBean.page!, homeBean.title, homeBean.path!);
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
