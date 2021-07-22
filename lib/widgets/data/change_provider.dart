import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/data/share_provider.dart';

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T? data;
  final Widget child;

  const ChangeNotifierProvider({Key? key, this.data, required this.child})
      : super(key: key);

  static T? of<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ShareProvider<T>>();
    return provider?.data;
  }

  @override
  State<StatefulWidget> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {

  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(
      covariant ChangeNotifierProvider<T> oldWidget) {
    if (oldWidget.data != widget.data) {
      oldWidget.data?.removeListener(update);
      widget.data?.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data?.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data?.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShareProvider<T>(widget.data, widget.child);
  }
}
