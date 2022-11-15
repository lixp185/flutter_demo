


import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/canvas/jue_jin_logo.dart';

class LogoDemo extends StatefulWidget {
  const LogoDemo({Key? key}) : super(key: key);

  @override
  State<LogoDemo> createState() => _LogoDemoState();
}

class _LogoDemoState extends State<LogoDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20,start: 20),
      padding: EdgeInsetsDirectional.all(10),
      // color: Colors.white,
      child: JueJinLogo(
        height: 60,
      ),
    );
  }
}
