import 'package:flutter/material.dart';

class UnlockController extends ChangeNotifier {
  // 存储按压的点集合
  List<PassWord> _points = [];

  List<PassWord> get points => _points;

  // 当前手指的位置
  Offset? _currentOffset;

  Offset? get currentOffset => _currentOffset;

  set currentOffset(Offset? value) {
    _currentOffset = value;
    notifyListeners();
  }

  // 颜色控制
  Color _color = Colors.blue;

  Color get color => _color;

  set color(Color value) {
    _color = value;
    notifyListeners();
  }

  resetColor() {
    _color = Colors.blue;
    notifyListeners();
  }

  addPoint(PassWord offset) {
    _points.add(offset);
    notifyListeners();
  }

  // 清除所有点
  clearAllPoint() {
    _points.clear();
    notifyListeners();
  }
}

class PassWord {
  int num; // 密码数字
  Offset offset; // 密码数字对应的点
  PassWord(this.num, this.offset);
}
