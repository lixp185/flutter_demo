import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GetJumpOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final logic = Get.put(GetJumpOneLogic());
    return Stack(
      children: [
        Center(
          child: GetBuilder<GetJumpOneLogic>(
            builder: (logic) {
              return Text('跨页面-Two点击了 ${logic.count} 次');
            },
          ),
        ),
        Positioned(
          child: ElevatedButton(
              onPressed: () => logic.toJumpTwo(), child: Text("跳转Two")),
          bottom: 20,
          right: 20,
        )
      ],
    );
  }
}
