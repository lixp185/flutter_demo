import 'package:get/get.dart';

import 'state.dart';

/// 逻辑层
class NumLogic extends GetxController {
  final NumState state = NumState();

  add() {
    state.num++;
    update();
  }

  @override
  void onInit() {
    print("init");
    state.num = 0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }
}
