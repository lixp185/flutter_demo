import 'package:flutter/material.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/pages/function/event/page_one.dart';
import 'package:flutter_demo/states/bloc/bloc_demo/view.dart';
import 'package:flutter_demo/states/getx/jump_page/jump_one/view.dart';
import 'package:flutter_demo/states/getx/num/view.dart';
import 'package:flutter_demo/states/provider/p_num/view.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';
import 'package:flutter_demo/widgets/baseful_widget.dart';
import 'package:get/get.dart';

import 'function/inherited_demo.dart';
import 'function/notification_demo.dart';

/// 作者： lixp
/// 创建时间： 2022/9/27 11:23
/// 类介绍： 功能性组件
class FunctionWidget extends StatefulWidget {
  const FunctionWidget({Key? key}) : super(key: key);

  @override
  State<FunctionWidget> createState() => _FunctionWidgetState();
}

class _FunctionWidgetState extends State<FunctionWidget>
    with AutomaticKeepAliveClientMixin {
  var _list = [];

  @override
  void initState() {
    super.initState();
    _list.add(_getWidget(HomeBean(
        "数据共享", "lib/widgets/open_image.dart", InheritedWidgetDemo())));
    _list.add(_getWidget(
        HomeBean("通知", "lib/widgets/open_image.dart", NotificationDemo())));
    _list.add(_getWidget(
        HomeBean("跨组件通信", "lib/widgets/open_image.dart", PageOne())));

    _list.add(_getWidget(
        HomeBean("provider", "lib/widgets/open_image.dart", PNumPage())));

    _list.add(_getWidget(
        HomeBean("bloc", "lib/widgets/open_image.dart", BlocNumPage())));

    _list.add(_getWidget(
        HomeBean("get", "lib/widgets/open_image.dart", GetNumPage())));
    _list.add(_getWidget(HomeBean(
        "get跨页面-one", "lib/widgets/open_image.dart", GetJumpOnePage())));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToWidget(_getWidget(HomeBean("功能组件", "", null, type: 1))),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _list[index];
              }, childCount: _list.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

  void _startAty(Widget widget, String title, String path) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext c) {
              return BaseStatefulWidget(widget, title, path);
            }));

    // Get.to(GetCounterEasyPage());
  }
}
