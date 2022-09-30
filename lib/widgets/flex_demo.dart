import 'package:flutter/material.dart';

import 'polygonal.dart';

class FlexDemo extends StatefulWidget {
  const FlexDemo({Key? key}) : super(key: key);

  @override
  _FlexDemoState createState() => _FlexDemoState();
}

class _FlexDemoState extends State<FlexDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      child: Column(
        children: [
          // Row(
          //   // verticalDirection: VerticalDirection.up,
          //   crossAxisAlignment: CrossAxisAlignment.baseline,
          //   textBaseline: TextBaseline.ideographic,
          //   // crossAxisAlignment: CrossAxisAlignment.stretch, // 交叉轴紧约束
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: ColoredBox(
          //         color: Colors.red,
          //         child: Text("1"),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: ColoredBox(
          //         color: Colors.lightBlue,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 50,
          //       height: 80,
          //       child: ColoredBox(
          //         color: Colors.blue,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 50,
          //       height: 50,
          //       child: ColoredBox(
          //         color: Colors.green,
          //       ),
          //     )
          //   ],
          // ),

       Container(
         child:    Wrap(
           children: [
             Polygonal(count: 3,size: 80,bigR: 20,smallR: 6,),
             Polygonal(count: 4,size: 80,bigR: 20,smallR: 10,),
             Polygonal(count: 5,size: 80,bigR: 20,smallR: 10, ),
             Polygonal(count: 7,size: 80,bigR: 20,smallR: 10,),
             Polygonal(count: 8,size: 80,bigR: 20,smallR: 10,),
             Polygonal(count: 10,size: 80,bigR: 20,smallR: 10,),
             Polygonal(count: 11,size: 80,bigR: 20,smallR: 10,),
             Polygonal(count: 12,size: 80,bigR: 20,smallR: 10,),
           ],
         ),

         margin: EdgeInsetsDirectional.only(top: 10),
       ),  Container(
            child:    Wrap(
              children: [
                Polygonal(count: 3,size: 80,bigR: 20,smallR: 6,isFill: true,),
                Polygonal(count: 4,size: 80,bigR: 20,smallR: 10,),
                Polygonal(count: 5,size: 80,bigR: 20,smallR: 10,isFill: true, ),
                Polygonal(count: 7,size: 80,bigR: 20,smallR: 10,),
                Polygonal(count: 8,size: 80,bigR: 20,smallR: 10,isFill: true,),
                Polygonal(count: 10,size: 80,bigR: 20,smallR: 10),
                Polygonal(count: 11,size: 80,bigR: 20,smallR: 10,isFill: true,),
                Polygonal(count: 12,size: 80,bigR: 20,smallR: 10),
              ],
            ),

            margin: EdgeInsetsDirectional.only(top: 10),
          ),
          Container(
            child:    Wrap(
              children: [
                Polygonal(count: 3,size: 80,bigR: 20,smallR: 6,type:Type.side,),
                Polygonal(count: 4,size: 80,bigR: 20,smallR: 10,type:Type.side,),
                Polygonal(count: 5,size: 80,bigR: 20,smallR: 10,type:Type.side, ),
                Polygonal(count: 7,size: 80,bigR: 20,smallR: 10,type:Type.side,),
                Polygonal(count: 8,size: 80,bigR: 20,smallR: 10,type:Type.side,),
                Polygonal(count: 10,size: 80,bigR: 20,smallR: 10,type:Type.side,),
                Polygonal(count: 11,size: 80,bigR: 20,smallR: 10,type:Type.side,),
                Polygonal(count: 12,size: 80,bigR: 20,smallR: 10,type:Type.side,),
              ],
            ),

            margin: EdgeInsetsDirectional.only(top: 10),
          ),

          Container(
            child:    Wrap(
              children: [
                Polygonal(count: 3,size: 80,bigR: 20,smallR: 6,type:Type.all,),
                Polygonal(count: 4,size: 80,bigR: 20,smallR: 10,type:Type.all,),
                Polygonal(count: 5,size: 80,bigR: 20,smallR: 10,type:Type.all, ),
                Polygonal(count: 7,size: 80,bigR: 20,smallR: 10,type:Type.all,),
                Polygonal(count: 8,size: 80,bigR: 20,smallR: 10,type:Type.all,),
                Polygonal(count: 10,size: 80,bigR: 20,smallR: 10,type:Type.all,),
                Polygonal(count: 11,size: 80,bigR: 20,smallR: 10,type:Type.all,),
                Polygonal(count: 12,size: 80,bigR: 20,smallR: 10,type:Type.all,),
              ],
            ),

            margin: EdgeInsetsDirectional.only(top: 10),
          ),

        ],
      )
    );
  }
}
