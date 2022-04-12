import 'package:flutter/material.dart';

class TouchController extends ChangeNotifier {
  List<Offset> _points = []; //点集合
  int _selectIndex = -1;

  int get selectIndex => _selectIndex;

  List<Offset> get points => _points;

  // 选择点
  set selectIndex(int value) {
    if (_selectIndex == value) return;
    _selectIndex = value;
    notifyListeners();
  }

  // 添加点
  void addPoint(Offset point) {
    points.add(point);
    notifyListeners();
  }

  void updatePoint(int index, Offset point) {
    points[index] = point;
    notifyListeners();
  }

  void removeLast() {
    points.removeLast();
    notifyListeners();
  }

  Offset? get selectPoint => _selectIndex == -1 ? null : _points[_selectIndex];
}
