import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// UI层
class GetNumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NumLogic());

    return Stack(
      children: [
        Obx(() {
          return Center(
            child: Text("点击了${logic.data.value}次"),
          );
        }),
        Positioned(
          child: FloatingActionButton(
            onPressed: () {
              logic.add();
            },
            child: Icon(Icons.add),
          ),
          bottom: 20,
          right: 20,
        )
      ],
    );
  }
}


