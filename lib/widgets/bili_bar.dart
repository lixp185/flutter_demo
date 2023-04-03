import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_demo/widgets/app_bar_search.dart';

class BiLiBar extends StatefulWidget {
  const BiLiBar({Key? key}) : super(key: key);

  @override
  State<BiLiBar> createState() => _BiLiBarState();
}

class _BiLiBarState extends State<BiLiBar> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, h) {
          return _buildSliverHeader();
        },
        body: TabBarView(
          children: const [TabV(color: Colors.yellow), TabV(color: Colors.red)],
          controller: tabController,
        ));
  }

  List<Widget> _buildSliverHeader() {
    return [
      SliverSnapHeader(child: AppBarSearch(

      )),
      SliverPinnedHeader(
          color: Colors.blue,
          child: TabBar(
              tabs: ['Tab1', 'Tab2']
                  .map((e) => Tab(
                        text: e,

                      ))
                  .toList(),
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              labelColor: Colors.blue,

              unselectedLabelColor: Colors.grey)),
    ];
  }
}

/// 搜索头
class SliverSnapHeader extends StatefulWidget {
  final PreferredSizeWidget child;

  const SliverSnapHeader({Key? key, required this.child}) : super(key: key);

  @override
  State<SliverSnapHeader> createState() => _SliverSnapHeaderState();
}

class _SliverSnapHeaderState extends State<SliverSnapHeader>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration? _snapConfiguration;
  PersistentHeaderShowOnScreenConfiguration? _showOnScreenConfiguration;

  void _initSnapConfiguration() {
    // tag1 初始化配置对象
    // 动画
    _snapConfiguration = FloatingHeaderSnapConfiguration(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 200),
    );

    // [1]. 在任意处上滑时，如果[头部搜索栏] 已显示，优先滑出视口。
    // [2]. 在任意处下滑时，如果[头部搜索栏] 未显示，优先滑入视口。
    _showOnScreenConfiguration =
        const PersistentHeaderShowOnScreenConfiguration(
            minShowOnScreenExtent: double.infinity);
  }

  @override
  void initState() {
    super.initState();
    _initSnapConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        floating: true,
        pinned: false, // 不置顶

        delegate: _SliverSnapHeaderDelegate(
          showOnScreenConfiguration: _showOnScreenConfiguration,
          snapConfiguration: _snapConfiguration,
          vsync: this,
          child: widget.child,
        ));
  }
}

class _SliverSnapHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;

  final TickerProvider? vsync;

  final FloatingHeaderSnapConfiguration? snapConfiguration;

  final PersistentHeaderShowOnScreenConfiguration? showOnScreenConfiguration;

  _SliverSnapHeaderDelegate(
      {this.snapConfiguration,
      this.showOnScreenConfiguration,
      required this.child,
      this.vsync});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverSnapHeaderDelegate oldDelegate) {
    return oldDelegate.child != child ||
        vsync != oldDelegate.vsync ||
        snapConfiguration != oldDelegate.snapConfiguration ||
        showOnScreenConfiguration != oldDelegate.showOnScreenConfiguration;
  }
}

class SliverPinnedHeader extends StatelessWidget {
  final PreferredSizeWidget child;
  final Color color;

  const SliverPinnedHeader(
      {super.key, required this.child, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverPinnedHeaderDelegate(child: child, color: color));
  }
}

class _SliverPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color color;

  _SliverPinnedHeaderDelegate({required this.child, required this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SliverPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.color != color;
  }
}



class TabV extends StatefulWidget {

  final Color color;
  const TabV({Key? key, required this.color}) : super(key: key);

  @override
  State<TabV> createState() => _TabVState();
}

class _TabVState extends State<TabV> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        // Viewport(offset: offsetoffset,cacheExtentStyle: ,)
        SliverList(delegate: SliverChildBuilderDelegate((context, index) => ItemBox(index: index,),childCount: 60
    ))
      ],
    );
  }
}

class ItemBox extends StatelessWidget {
  final int index;
  const ItemBox({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: 56,
          color: Colors.blue.withOpacity((index %10)*0.1),

        );
  }
}

