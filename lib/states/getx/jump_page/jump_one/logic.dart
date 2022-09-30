import 'package:flutter_demo/states/getx/jump_page/jump_two/view.dart';
import 'package:get/get.dart';

class GetJumpOneLogic extends GetxController {
  var count = 0;

  ///跳转到跨页面
  void toJumpTwo() {
    Get.to(GetJumpTwoPage(), arguments: {'msg': 'one页面传递数据'});
  }

  ///跳转到跨页面
  void increase() {
    count++;
    update();
  }
}
