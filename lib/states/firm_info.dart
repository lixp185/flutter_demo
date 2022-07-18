import 'package:flutter/material.dart';

class FirmInfo extends InheritedWidget {
  final String data;

  const FirmInfo({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);

  static String of(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    return context.dependOnInheritedWidgetOfExactType<FirmInfo>()!.data;
  }

  @override
  bool updateShouldNotify(covariant FirmInfo oldWidget) {
    return data != oldWidget.data;
  }
}

