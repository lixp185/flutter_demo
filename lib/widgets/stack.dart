import 'package:flutter/material.dart';

class StackWidgetDemo extends StatefulWidget {
  const StackWidgetDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return StackState();
  }
}

class StackState extends State<StackWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: _widgets(),
        ));
  }

  List<Widget> _widgets() {
    List<Widget> list = [];

    list.add(Container(
      color: Colors.black26,
    ));

    for (int i = 1; i < 100; i++) {
      list.add(Container(
        margin: EdgeInsets.all(10.0 * i),
        color: Colors.black.withOpacity(i / 100),
      ));
    }

    list.add(const Text("default"));
    list.add(const Positioned(
      left: 10,
      child: Text("left"),
    ));
    list.add(const Positioned(
      top: 10,
      child: Text("top"),
    ));
    list.add(const Positioned(
      right: 10,
      child: Text("right"),
    ));
    list.add(
      const Positioned(
        bottom: 10,
        child: Text("bottom"),
      ),
    );

    return list;
  }
}
