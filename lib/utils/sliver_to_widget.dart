import 'package:flutter/material.dart';

class SliverToWidget extends StatelessWidget {
  final Key? key;
  final Widget widget;

  const SliverToWidget(this.widget, {this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      key: key,
      child: widget,
    );
  }
}
