import 'package:flutter/material.dart';

import 'code_page.dart';

class BaseStatefulWidget extends StatefulWidget {
  final Widget widget;
  final String title;
  final String codePath;
  final VoidCallback? onClick;

  BaseStatefulWidget(this.widget, this.title, this.codePath, {this.onClick});

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
    return  _buildWidgetDefault();
  }

  Widget _buildWidgetDefault() {
    ///使用appbar，也可直接只有 body 在 body 里自定义状态栏、标题栏
    // return _buildBody();
    return WillPopScope(
        child: Scaffold(
          // primary: false,
          appBar: widget.title.isEmpty ? null : _buildAppBar(),
          body: Container(
            // padding: EdgeInsetsDirectional.only(top: 20),
            child: _buildBody(),
          ),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    bool b = true;

    return Future.value(b);
  }

  AppBar? _buildAppBar() {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(Icons.code),
            onPressed: () {
              if (widget.onClick == null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CodePage(widget.codePath);
                }));
              } else {
                widget.onClick?.call();
              }
            }),
      ],
    );
  }

  Widget _buildBody() {
    return widget.widget;
  }
}
