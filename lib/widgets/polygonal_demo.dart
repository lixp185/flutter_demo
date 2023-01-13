import 'package:flutter/material.dart';
import 'package:flutter_demo/widgets/polygonal.dart';

class PolygonalDemo extends StatelessWidget {
  const PolygonalDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Wrap(
            children: const [
              Polygonal(
                count: 3,
                size: 80,
                bigR: 20,
                smallR: 6,
                isFill: true,
              ),
              Polygonal(
                count: 4,
                size: 80,
                bigR: 20,
                smallR: 10,
              ),
              Polygonal(
                count: 5,
                size: 80,
                bigR: 20,
                smallR: 10,
                isFill: true,
              ),
              Polygonal(
                count: 7,
                size: 80,
                bigR: 20,
                smallR: 10,
              ),
              Polygonal(
                count: 8,
                size: 80,
                bigR: 20,
                smallR: 10,
                isFill: true,
              ),
              Polygonal(count: 10, size: 80, bigR: 20, smallR: 10),
              Polygonal(
                count: 11,
                size: 80,
                bigR: 20,
                smallR: 10,
                isFill: true,
              ),
              Polygonal(count: 12, size: 80, bigR: 20, smallR: 10),
            ],
          ),
          margin: const EdgeInsetsDirectional.only(top: 10),
        ),
        Wrap(
          children: const [
            Polygonal(
              count: 3,
              size: 80,
              bigR: 20,
              smallR: 6,
              type: Type.side,
              isFill: true,
            ),
            Polygonal(
              count: 4,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
            ),
            Polygonal(
              count: 5,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
              isFill: true,
            ),
            Polygonal(
              count: 7,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
            ),
            Polygonal(
              count: 8,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
              isFill: true,
            ),
            Polygonal(
              count: 10,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
            ),
            Polygonal(
              count: 11,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
              isFill: true,
            ),
            Polygonal(
              count: 12,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.side,
            ),
          ],
        ),
        Wrap(
          children: const [
            Polygonal(
              count: 3,
              size: 80,
              bigR: 20,
              smallR: 6,
              type: Type.all,
            ),
            Polygonal(
              count: 4,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 5,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 7,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 8,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 10,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 11,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
            Polygonal(
              count: 12,
              size: 80,
              bigR: 20,
              smallR: 10,
              type: Type.all,
            ),
          ],
        ),
      ],
    );
  }
}
