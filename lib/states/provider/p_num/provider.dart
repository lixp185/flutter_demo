import 'package:flutter/material.dart';

import 'state.dart';

/// 业务逻辑层
class PNumProvider extends ChangeNotifier {
 /// 初始化数据对象
  final state = PNumState(num: 0);

  /// 自增计数方法
  add() {
    state.num++;
    notifyListeners();
  }
}
