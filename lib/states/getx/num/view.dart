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
        GetBuilder<NumLogic>(builder: (logic) {
          return Center(
            child: Text("点击了${logic.state.num}次"),
          );
        },),
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


