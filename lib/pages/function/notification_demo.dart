import 'package:flutter/material.dart';

/// 作者： lixp
/// 创建时间： 2022/9/27 16:25
/// 类介绍： 通知
class NotificationDemo extends StatefulWidget {
  const NotificationDemo({Key? key}) : super(key: key);

  @override
  State<NotificationDemo> createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<MyNotificationData>(
        onNotification: (res) {
          setState(() {
            num = res.data;
          });
          // true 不想上传递 false 向上传递
          return true;
        },
        child: Stack(
          children: [
            Center(
              child: Text("接受到数据$num"),
            ),
            const Positioned(
              child: BtWidget(),
              bottom: 20,
              right: 20,
            )
          ],
        ));
  }
}

class MyNotificationData extends Notification {
  int data = 0;

  MyNotificationData(this.data);
}

class BtWidget extends StatefulWidget {
  const BtWidget({Key? key}) : super(key: key);

  @override
  State<BtWidget> createState() => _BtWidgetState();
}

class _BtWidgetState extends State<BtWidget> {
  int num = 0;



  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          MyNotificationData(num++).dispatch(context);
        },
        child: Text("发送通知"));
  }
}
