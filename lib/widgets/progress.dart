import 'package:flutter/material.dart';

class ProgressWidgetDemo extends StatefulWidget {
  const ProgressWidgetDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProgressState();
  }
}

class ProgressState extends State<ProgressWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Text("LinearProgressIndicator"),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.blue[200],
            ),
          ),
          Container(
            height: 2,
            margin: EdgeInsets.all(20),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.blue[200],
              value: 0.4,
            ),
          ),
          Text("CircularProgressIndicator"),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.blue[200],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  backgroundColor: Colors.red[200],
                  value: 0.4,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

///LinearProgressIndicator 属性
/// value	当前进度，0 ~ 1
/// backgroundColor	进度条背景色
/// valueColor	Animation<Color> 进度条当前进度颜色，
/// 使用不变的颜色可以使用 AlwaysStoppedAnimation<Color>(Colors.red)
/// minHeight	最小宽度，默认为 4.0
/// semanticsLabel	语义标签
/// semanticsValue	语义Value

/// CircularProgressIndicator 属性
/// value	当前进度，0 ~ 1
/// backgroundColor	进度条背景色
/// valueColor	Animation<Color> 进度条当前进度颜色，
/// 使用不变的颜色可以使用 AlwaysStoppedAnimation<Color>(Colors.red)
/// strokeWidth	最小宽度，默认为 4.0
/// semanticsLabel	语义标签
/// semanticsValue	语义Value
