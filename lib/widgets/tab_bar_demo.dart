import 'package:flutter/material.dart';
import 'package:flutter_demo/states/firm_info.dart';
import 'package:flutter_demo/utils/view/my_tab_indicator.dart';

/// TabBarDemo
class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ["TAB1", "TAB2", "TAB3", "TAB4", "TAB5", "TAB6"];
  late TabController _tabController =
      TabController(length: tabs.length, vsync: this); //tab 控制器

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          indicator: MyTabIndicator(
              borderSide: BorderSide(
                width: 4,
                color: Colors.redAccent,
              ),
              // indicatorWidth: 4,
              indicatorBottom: 20,
              indicatorWidth: 30
              // tabController: _tabController
              ),
          controller: _tabController,
          tabs: tabs
              .map((value) => Tab(
                    height: 44,
                    text: value,
                  ))
              .toList(),
          labelColor: Colors.black87,
          unselectedLabelColor: Colors.black87,
        ),
        Expanded(
            child: FirmInfo(
                child: TabBarView(
                  controller: _tabController,
                  children: tabs.map((value) => Test()).toList(),
                ),
                data: "FLUTTER DEMO"))
      ],
    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {

      print("xx${FirmInfo.of(context)}");

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("xxx"),
    );
  }
}
