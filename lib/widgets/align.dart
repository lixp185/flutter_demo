import 'package:flutter/material.dart';

class AlignDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      color: Colors.blue[200],
      child: Align(
        alignment: FractionalOffset(1.2, 0.5),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.router,size: 40,),
            Icon(Icons.router,size: 40,)
          ],
        )
      ),
    );
  }
}
/// 位置的设定 0-1 为父控件比例
///
///