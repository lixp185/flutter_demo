import 'package:flutter/material.dart';

import 'code_page.dart';

 class BaseStatefulWidget extends StatefulWidget {

  final Widget widget;
  final String title;
  final String codePath;
  BaseStatefulWidget(this.widget, this.title, this.codePath);
  @override
  State<StatefulWidget> createState() {
    return BaseWidgetState();
  }
}
 class BaseWidgetState extends State<BaseStatefulWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return _buildWidgetDefault();
  }

  Widget _buildWidgetDefault() {
    ///使用appbar，也可直接只有 body 在 body 里自定义状态栏、标题栏
    return WillPopScope(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    bool b = true;
    // if (KeyboardManager.isShowKeyboard) {
    //   KeyboardManager.hideKeyboard();
    //   b = false;
    // }
    return Future.value(b);
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CodePage(widget.codePath);
              }));
            })
      ],
    );
  }

  Widget _buildBody() {
    return widget.widget;
  }
}
