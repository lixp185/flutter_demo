import 'package:flutter/material.dart';
import 'package:flutter_demo/models/home_bean.dart';
import 'package:flutter_demo/utils/sliver_to_widget.dart';
import 'package:flutter_demo/widgets/util_page/open_image.dart';

import 'baseful_widget.dart';
import 'big_image.dart';
import 'util_page/my_toast.dart';

/// 工具、其他组件
class UtilWidget extends StatefulWidget {
  @override
  _UtilWidgetState createState() => _UtilWidgetState();
}

class _UtilWidgetState extends State<UtilWidget>
    with AutomaticKeepAliveClientMixin {
  var utilList = [];

  @override
  void initState() {
    super.initState();

    utilList.add(_getWidget(
        HomeBean("图片选择器", "lib/widgets/open_image.dart", OpenImage())));
    utilList.add(
        _getWidget(HomeBean("吐司工具", "lib/widgets/my_toast.dart", MyToast())));
    utilList
        .add(_getWidget(HomeBean("查看大图", "lib/widgets/big_image.dart", BigImage())));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        margin: EdgeInsets.only(left: 0, right: 0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToWidget(_getWidget(HomeBean("常用工具", "", null, type: 1))),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return utilList[index];
              }, childCount: utilList.length),
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
  }
}
