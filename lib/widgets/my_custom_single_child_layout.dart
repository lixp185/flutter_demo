import 'package:flutter/material.dart';

///
class MyCustomSingleChildLayout extends StatelessWidget {
  const MyCustomSingleChildLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Placeholder(
    //   child: CustomSingleChildLayout(
    //     delegate: _MySingleChildLayoutDelegate(),
    //     child: Container(
    //       height: 20,
    //       width: 20,
    //       child: ColoredBox(
    //         color: Colors.blue,
    //       ),
    //     )
    //   ),
    // );

    return Flow(
      delegate: SimpleFlowDelegate(spacer: 5),
      children: const [
        SizedBox(
          width: 50,
          height: 50,
          child: ColoredBox(
            color: Colors.red,
          ),
        ),
        Text('1121'),
        Text('1121'),
        Text('1121'),
      ],
    );
  }
}

class SimpleFlowDelegate extends FlowDelegate   {
  final int spacer;

  SimpleFlowDelegate({this.spacer = 0});

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    double totalX = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      totalX += context.getChildSize(i)!.width;
      totalX += (spacer * i);
      context.paintChild(i,
          transform: Matrix4.translationValues(
            totalX + spacer * i -context.getChildSize(i)!.width,
            i==0?0:20,
            0,
          ));
    }
  }

  @override
  bool shouldRepaint(covariant SimpleFlowDelegate oldDelegate) {
    return spacer != oldDelegate.spacer;
  }
}

class _MySingleChildLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    final radius = constraints.biggest.shortestSide;
    return Size(radius, radius);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(10, 10);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return false;
  }
}
