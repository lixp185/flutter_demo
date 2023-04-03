import 'package:flutter/material.dart';

class NestedScrollViewDemo extends StatefulWidget {
  const NestedScrollViewDemo({Key? key}) : super(key: key);

  @override
  State<NestedScrollViewDemo> createState() => _NestedScrollViewDemoState();
}

class _NestedScrollViewDemoState extends State<NestedScrollViewDemo>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  final _tabs = <String>['Tab1', 'Tab2'];


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: _buildHeader,
        body: TabBarView(
          children: [
            _buildTab(1),
            _buildTab(2),
          ],
          controller: tabController,
        ));
  }

  List<Widget> _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    print('innerBoxIsScrolled$innerBoxIsScrolled');
    return [
    SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver:  _buildAppBar(),
    )
    ];
  }

  _buildAppBar() {
    return   SliverAppBar(
      expandedHeight: 240,
      title: const Text("测试"),
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Image.asset('images/ht.png', fit: BoxFit.cover)),
      pinned: true,
      bottom: TabBar(
        indicatorColor: Colors.green,
        controller: tabController,
        tabs: _tabs.map((String name) => Tab(text: name)).toList(),
      ),
    );
  }

  _buildTab(int i) {
    return Builder(
      builder: (context) {
        return CustomScrollView(
          key: PageStorageKey(i),
          slivers: [
            SliverOverlapInjector( // tag1
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                color: Colors.red,
              ),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                        color: Colors.blue.withOpacity(index / 10),
                      ),
                  childCount: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: 20,
                margin: EdgeInsetsDirectional.all(10),
                color: Colors.red,
              ),
            ))
          ],
        );
      }
    );
  }
}
