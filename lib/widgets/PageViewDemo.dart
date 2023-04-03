import 'package:flutter/material.dart';

class PageViewDemo extends StatefulWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  State<PageViewDemo> createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  static const int _kIndexOffset = 10000; // 初始索引偏移量
  int _realIndex = 0; // 真实索引
  late PageController pageController;

  List<Widget> l = [Text('1'), Text('2'), Text('3')];

  int get initOffsetIndex => (_kIndexOffset ~/ l.length) * l.length;

  @override
  void initState() {
    super.initState();
    _realIndex = initOffsetIndex + _realIndex;
    pageController = PageController(initialPage: _realIndex);

    print('xxx $initOffsetIndex');
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      allowImplicitScrolling: true,
      onPageChanged: (index) {
        // print(index % l.length);
      },
      itemBuilder: (context, index) {
        print('xx $index $_realIndex');
        return Container(
          height: 200,
          alignment: Alignment.center,
          color: Colors.red[index * 100],
          child: l[(index - initOffsetIndex) % l.length],
        );
      },
      controller: pageController,
      // itemCount: 10000,
    );
  }
}
