import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/theme_common.dart';

import 'car_item.dart';

class CarModel extends ChangeNotifier {
  //购物车商品
  final List<Item> _items = [];

  ThemeData themeData = ThemeCommon.lightTheme;

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totaPrice {
    return _items.fold(
        0, (value, item) => value + item.count * item.price);
  }

  ThemeData get getTheme => themeData;


  void setTheme(ThemeData themeData) {
    this.themeData = themeData;
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建ShareProvider， 更新状态。
    notifyListeners();
  }
}
