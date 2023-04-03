import 'package:flutter/material.dart';

class FlexDemo extends StatefulWidget {
  const FlexDemo({Key? key}) : super(key: key);

  @override
  _FlexDemoState createState() => _FlexDemoState();
}

class _FlexDemoState extends State<FlexDemo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Other(index % 2 == 0);
      },
      itemCount: 20,
    );
  }
}

class Other extends StatelessWidget {
  final bool isMe;

  const Other(this.isMe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isMe ? 45 : 15, end: isMe ? 15 : 45, top: 10, bottom: 10),
      child: Row(
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        children: [
          _buildIcon(),
          Flexible(
            child: _buildContent(),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          color: Colors.green,
          image: DecorationImage(
              image: AssetImage(
                'images/duanwu.webp',
              ),
              fit: BoxFit.cover)),
      child: Text(
        '兄弟们，准备问老婆准备问老婆准备问老婆准备问老婆准备问老婆',
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}

Widget _buildIcon() {
  return Container(
    height: 40,
    width: 40,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: const DecorationImage(
          image: AssetImage(
            'images/logo_normal.png',
          ),
          fit: BoxFit.cover,
        )),
  );
}
