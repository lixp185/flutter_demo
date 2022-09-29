import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/function/event/event_demo.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {


  int num = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page2"),),
      body: Center(
        child: Text("$num"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            num++;
          });
          Event.eventBus.fire(CountEvent(num));
        }, child: Icon(Icons.add),),
    );
  }
}
