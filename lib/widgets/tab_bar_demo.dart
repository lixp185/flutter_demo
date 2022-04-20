import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/view/my_tab_indicator.dart';

/// TabBarDemo
class TabBarDemo extends StatefulWidget {
  const TabBarDemo({Key? key}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  List<String> tabs = ["TAB1", "TAB2","TAB3","TAB4","TAB5","TAB6"];
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
              width: 2,
              color: Colors.redAccent,
            ),
            // indicatorWidth: 4,
            indicatorBottom: 10,
            tabController: _tabController
          ),
          controller: _tabController,
          tabs: tabs
              .map((value) => Tab(
                    height: 44,
                    text: value,
                  ))
              .toList(),
          indicatorColor: Colors.redAccent,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,

          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.black87,
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: tabs
              .map((value) => Center(
                    child: Text(
                      value,
                    ),
                  ))
              .toList(),
        ))
      ],
    );
  }
}
