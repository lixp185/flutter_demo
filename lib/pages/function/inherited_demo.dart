import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/function/test_data.dart';
import 'package:flutter_demo/utils/view/my_tab_indicator.dart';


/// 作者： lixp
/// 创建时间： 2022/9/27 13:48
/// 类介绍：数据传递demo
class InheritedWidgetDemo extends StatefulWidget {
  const InheritedWidgetDemo({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetDemo> createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo>
    with SingleTickerProviderStateMixin {
  int data = 0;

  List<String> tabs = ["TAB1", "TAB2", "TAB3", "TAB4", "TAB5", "TAB6"];
  late final TabController _tabController =
      TabController(length: tabs.length, vsync: this); //tab 控制器
  @override
  Widget build(BuildContext context) {
    return CountData(
        c: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicator: const MyTabIndicator(
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
              child: TabBarView(
                controller: _tabController,
                children: tabs.map((value) => const TextWidget()).toList(),
              ),
            ),
            FloatingActionButton(
                onPressed: () {
                  setState(() {
                    data++;
                  });
                },
                child: const Icon(Icons.add))
          ],
        ),
        data: data);
  }
}


class TextWidget extends StatefulWidget {
  const TextWidget({Key? key}) : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // print("test${CountData.of(context)?.data}");
    //
    // print("子节点 build 方法触发");
    return Container(
      color: Colors.yellow,
      alignment: Alignment.center,
      child: Text("共享数据：${CountData.of(context)?.data}"),
      // child: Text("data"),
    );
  }

  @override
  void didChangeDependencies() {
    // print("子节点 didChangeDependencies 方法触发");
    super.didChangeDependencies();
  }
}
