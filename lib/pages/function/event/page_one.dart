import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/function/event/event_demo.dart';
import 'package:flutter_demo/pages/function/event/page_two.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int num = 0;

  StreamSubscription<CountEvent>? listen;

  @override
  void dispose() {
    listen?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 如果 第一个页面和第三个页面共享数据 将这个数据全局处理
    listen = Event.eventBus.on<CountEvent>().listen((event) {
      print("1111111");
      setState(() {
        num = event.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text("two页面传递数据:--$num"),
        ),
        Positioned(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext c) {
                          return PageTwo();
                        }));
              },
              child: Text("跳转Two")),
          bottom: 20,
          right: 20,
        )
      ],
    );
  }
}
