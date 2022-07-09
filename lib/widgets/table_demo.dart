import 'dart:math';

import 'package:flutter/material.dart';

class TableDemo extends StatefulWidget {
  const TableDemo({Key? key}) : super(key: key);

  @override
  _TableDemoState createState() => _TableDemoState();
}

class _TableDemoState extends State<TableDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsetsDirectional.all(20),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:  Table(
                textBaseline: TextBaseline.alphabetic,
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: _getTabRows(),
                border: TableBorder.all(color: Colors.red, width: 1),
              ),)),
    );
  }
  List<TableRow> _getTabRows() {

    Wrap();
    List<TableRow> tabs = [];

    // 设置学科
    tabs.add(TableRow(
      decoration: BoxDecoration(color: Colors.grey),
      children: titles(),
    ));
    // 成绩 60人
    for (int i = 0; i < 3; i++) {
      tabs.add(TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: contents(i==0?"法外狂徒张三$i":'张三$i'),
      ));
    }
    return tabs;
  }

  List<Widget> titles() {
    List<Widget> titles = [];
    titles.add(xkTitle("姓名"));
    // 学科
    titles.add(xkTitle("语文"));
    titles.add(xkTitle("数学"));
    titles.add(xkTitle("英语"));
    // titles.add(xkTitle("物理"));
    // titles.add(xkTitle("化学"));
    // titles.add(xkTitle("生物"));
    // titles.add(xkTitle("地理"));
    // titles.add(xkTitle("历史"));
    // titles.add(xkTitle("政治"));
    return titles;
  }

  Widget xkTitle(String text) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsetsDirectional.all(10),
        child: Text(text),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    );
  }

  List<Widget> contents(String name) {
    List<Widget> titles = [];
    Random random = Random.secure();
    for (int i = 0; i < 4; i++) {
      titles.add(TableCell(
        child: Container(
          // height: 200,
          alignment: Alignment.center,
          padding: EdgeInsetsDirectional.all(10),
          child: Text(i == 0 ? name : random.nextInt(100).toString()),
        ),
        verticalAlignment: TableCellVerticalAlignment.middle,
      ));
    }
    return titles;
  }
}
