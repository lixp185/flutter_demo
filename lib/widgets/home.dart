import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yht_meeting/models/app_theme.dart';
import 'package:yht_meeting/models/home_bean.dart';
import 'package:yht_meeting/utils/status.dart';
import 'package:yht_meeting/widgets/align.dart';
import 'package:yht_meeting/widgets/animated.dart';
import 'package:yht_meeting/widgets/baseful_widget.dart';
import 'package:yht_meeting/widgets/check.dart';
import 'package:yht_meeting/widgets/icon.dart';
import 'package:yht_meeting/widgets/progress.dart';
import 'package:yht_meeting/widgets/size_box.dart';
import 'package:yht_meeting/widgets/stack.dart';
import 'package:yht_meeting/widgets/text.dart';
import 'package:yht_meeting/widgets/text_field.dart';
import 'package:yht_meeting/widgets/theme.dart';
import 'package:yht_meeting/widgets/transform.dart';
import 'package:yht_meeting/widgets/wrap.dart';

import 'button.dart';
import 'calendar.dart';
import 'canvas_demo.dart';
import 'container.dart';
import 'data/padding.dart';
import 'decorated_box.dart';
import 'dialog.dart';
import 'gesture_detector.dart';
import 'list.dart';
import 'listener.dart';

class HomeWidget extends StatefulWidget {
  final title;

  HomeWidget({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  var gifts = new Map();

  var homeList = [];

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
    homeList.add(_getWidget(
        HomeBean("ListView", "lib/widgets/list.dart", ListViewWidgetDemo())));

    homeList.add(_getWidget(
        HomeBean("Wrap", "lib/widgets/wrap.dart", WrapWidgetDemo())));
    homeList.add(_getWidget(
        HomeBean("Stack帧布局", "lib/widgets/stack.dart", StackWidgetDemo())));
    homeList.add(_getWidget(HomeBean("容器类组件", "", null, type: 1)));
    homeList.add(
        _getWidget(HomeBean("Align", "lib/widgets/align.dart", AlignDemo())));
    homeList.add(_getWidget(
        HomeBean("Padding", "lib/widgets/align.dart", PaddingDemo())));
    homeList.add(_getWidget(
        HomeBean("尺寸限制类容器", "lib/widgets/align.dart", SizeBoxDemo())));
    homeList.add(_getWidget(
        HomeBean("装饰类容器", "lib/widgets/align.dart", DecoratedBoxDemo())));
    homeList.add(_getWidget(
        HomeBean("Transform(变换)", "lib/widgets/align.dart", TransformDemo())));
    homeList.add(_getWidget(
        HomeBean("Container", "lib/widgets/align.dart", ContainerDemo())));
    homeList.add(_getWidget(
        HomeBean("Listener", "lib/widgets/align.dart", ListenerWidgetDemo())));

    homeList.add(_getWidget(HomeBean("GestureDetector(手势识别)",
        "lib/widgets/align.dart", GestureDetectorDemo())));

    homeList.add(_getWidget(HomeBean("Animated(动画)",
        "lib/widgets/animated.dart", AnimateWidgetDemo())));
    homeList.add(_getWidget(HomeBean("绘制组件",
        "lib/widgets/canvas_demo.dart", CanvasDemo())));
    homeList.add(_getWidget(HomeBean("日期组件",
        "lib/widgets/animated.dart", CalendarDemo())));

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
              _startAty(homeBean.page, homeBean.title, homeBean.path);
            },
          ));
    } else if (homeBean.type == 1) {
      return Container(
        alignment: Alignment.center,
        child: Text(
            """${homeBean.title} ${String.fromCharCodes(Runes("\u2665"))}"""),
      );
    } else {
      return Text("xxx");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AppBar"),
          centerTitle: true,
          elevation: 1,
          leading: Icon(Icons.arrow_back),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
                icon: Icon(Icons.wb_sunny),
                tooltip: "search", //辅助显示
                onPressed: () {
                  // 设置主题
                  if (Status.value<AppTheme>(context).isDark) {
                    Status.value<AppTheme>(context).changeDark(false);
                  } else {
                    Status.value<AppTheme>(context).changeDark(true);
                  }
                }),
            Container(
                margin: EdgeInsets.only(left: 0),
                child: IconButton(icon: Icon(Icons.add), onPressed: () {}))
          ],
        ),
        body: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return homeList[index];
              },
              itemCount: homeList.length,
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
