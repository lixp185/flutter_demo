import 'package:get/get.dart';



/// 逻辑层
class NumLogic extends GetxController {
  RxInt data = 0.obs;
  add() {
    data++;
    // update();
  }
}
