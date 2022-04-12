import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/toast_util.dart';

/// toast 演示
class MyToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                ToastUtil.show("我是一个普通toast");
              },
              child: Text("普通吐司")),
          ElevatedButton(
              onPressed: () {
                ToastUtil.showError("我是一个错误toast");
              },
              child: Text("错误吐司"))
        ],
      ),
    );
  }
}
