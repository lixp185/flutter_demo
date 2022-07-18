import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/canvas/joystick.dart';

/// 作者： lixp
/// 创建时间： 2022/7/7 15:41
/// 类介绍：操作移动demo
class MoveDemo extends StatefulWidget {
  const MoveDemo({Key? key}) : super(key: key);

  @override
  _MoveDemoState createState() => _MoveDemoState();
}

class _MoveDemoState extends State<MoveDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: JoyStick(),
    );
  }
}
