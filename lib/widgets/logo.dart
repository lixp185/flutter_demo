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
      margin: const EdgeInsetsDirectional.only(top: 20, start: 20),
      padding: const EdgeInsetsDirectional.all(30),
      color: Colors.yellow,
      child: const JueJinLogo(
        height: 60,
      ),
    );
  }
}
