import 'package:flutter/material.dart';

import 'state.dart';

/// 业务逻辑层
class PNumProvider extends ChangeNotifier {
  final state = PNumState(0);

  add() {
    state.num++;
    notifyListeners();
  }
}
