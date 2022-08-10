

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


/// Hero 动画 demo
class HeroDemo extends StatefulWidget {
  const HeroDemo({Key? key}) : super(key: key);

  @override
  _HeroDemoState createState() => _HeroDemoState();
}

class _HeroDemoState extends State<HeroDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Hero(tag: "k", child: PhotoView(
          imageProvider: AssetImage("images/lbxx.png"),
          // imageProvider: NetworkImage("imageUrl"),
        ))
    );
  }
}
