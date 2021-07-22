import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';

import 'align.dart';
import 'animated.dart';
import 'baseful_widget.dart';
import 'button.dart';
import 'calendar.dart';
import 'canvas_demo.dart';
import 'check.dart';
import 'container.dart';
import 'data/padding.dart';
import 'decorated_box.dart';
import 'dialog.dart';
import 'gesture_detector.dart';
import 'icon.dart';
import 'list.dart';
import 'listener.dart';
import 'progress.dart';
import 'size_box.dart';
import 'stack.dart';
import 'text.dart';
import 'text_field.dart';
import 'theme.dart';
import 'transform.dart';
import 'wrap.dart';

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
    homeList.add(_getWidget(HomeBean(
        "装饰(DecoratedBox)", "lib/widgets/decorated_box.dart", DecoratedBoxDemo())));
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
    homeList.add(_getWidget(HomeBean(
        "绘制组件 棋盘(Canvas)", "lib/widgets/canvas_demo.dart", CanvasDemo())));
    homeList.add(_getWidget(
        HomeBean("日期组件", "lib/widgets/calendar.dart", CalendarDemo())));
    super.initState();
  }

  Widget _getWidget(HomeBean homeBean) {
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
          """${homeBean.title} ${String.fromCharCodes(Runes("\u2665"))}""",
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

  void _startAty(Widget widget, String title, String path) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext c) {
              return BaseStatefulWidget(widget, title, path);
            }));
  }
}
