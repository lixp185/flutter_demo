

import 'package:flutter/material.dart';

class OverflowDemo extends StatefulWidget {
  const OverflowDemo({Key? key}) : super(key: key);

  @override
  State<OverflowDemo> createState() => _OverflowDemoState();
}

class _OverflowDemoState extends State<OverflowDemo> {
  @override
  Widget build(BuildContext context) {
    return   SizedBox(

      width: 100,
      height: 100,
      child:GestureDetector(
          child:OverflowBox(
            minWidth: 50,
            maxWidth: 200,
            minHeight: 400,
            maxHeight: 400,
            alignment: Alignment.center,
            child:const SizedBox(
              width: 50,
              height: 299,
              child:  ColoredBox(color: Colors.red,),
            ),
          ) ,
          onTap: (){
    print('xx');
    },
    )
    );
  }
}
