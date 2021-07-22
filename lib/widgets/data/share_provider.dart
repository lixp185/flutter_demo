import 'package:flutter/material.dart';

class ShareProvider<T> extends InheritedWidget  {
  final T? data;

  ShareProvider(this.data, Widget child) : super(child: child) ;

  @override
  bool updateShouldNotify(covariant ShareProvider<T> oldWidget) {
    return true;
  }
}
