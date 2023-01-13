import 'package:flutter/material.dart';


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
          Row(
            // verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            // crossAxisAlignment: CrossAxisAlignment.stretch, // 交叉轴紧约束
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              SizedBox(
                width: 50,
                height: 50,
                child: ColoredBox(
                  color: Colors.red,
                  child: Text("1"),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: ColoredBox(
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(
                width: 50,
                height: 80,
                child: ColoredBox(
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: ColoredBox(
                  color: Colors.green,
                ),
              )
            ],
          ),






        ],
      )
    );
  }
}
