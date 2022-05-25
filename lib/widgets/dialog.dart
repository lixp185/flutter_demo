import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DialogState();
  }
}

class _DialogState extends State<DialogWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context1) {
                      return AlertDialog(
                        title: Text("标题Widget"),
                        content: Text("内容Widget"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                print("lxp ${context.toString()}");
                                print("lxp ${context1.toString()}");
                              },
                              child: Text("确定")),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop("取消");
                              },
                              child: Text("取消"))
                        ],
                      );
                    });
                // Navigator.of(context).pop();
              },
              child: Text("AlertDialog")),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("标题Widget"),
                          content: Text("内容Widget"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("确定")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("取消"))
                          ],
                        );
                      });
                },
                child: Text("苹果风格AlertDialog")),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("标题Widget"),
                          children: [
                            SimpleDialogOption(
                              child: Text("选项1"),
                              onPressed: () {
                                Navigator.of(context).pop("选项1");
                                Fluttertoast.showToast(msg: "选项1");
                              },
                            ),
                            SimpleDialogOption(
                              child: Text("选项2"),
                              onPressed: () {
                                Navigator.of(context).pop("选项2");
                                Fluttertoast.showToast(msg: "选项2");
                              },
                            ),
                            SimpleDialogOption(
                              child: Text("选项3"),
                              onPressed: () {
                                Navigator.of(context).pop("选项3");
                                Fluttertoast.showToast(msg: "选项3");
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Text("SimpleDialog")),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  _showMyLoading(context);
                },
                child: Text("AboutDialog")),
          )
        ],
      ),
    );
  }

  _showMyLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AboutDialog(
            applicationName: "我要测",
            applicationVersion: "1.0.0",
            applicationLegalese: "https://www.instrument.com.cn/",
            applicationIcon: Image.asset(
              "images/logo_normal.png",
              width: 50,
              height: 50,
            ),
            children: [
              Text(
                "仪器信息网出品",
              ),
            ],
          );
        });
  }
}
