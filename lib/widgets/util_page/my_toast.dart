import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "我是一个普通吐司",gravity: ToastGravity.CENTER);
              },
              child: Text("普通吐司")),

          ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "我是一个错误吐司",gravity: ToastGravity.CENTER,backgroundColor: Colors.red,);
              },
              child: Text("错误吐司"))
        ],
      ),
    );
  }
}
