import 'package:flutter/material.dart';

import 'state.dart';

class PNumProvider extends ChangeNotifier {
  final state = PNumState(0);

  add() {
    state.num++;
    notifyListeners();
  }
}
