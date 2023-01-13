import 'package:flutter/material.dart';
import 'package:flutter_demo/models/app_theme.dart';
import 'package:flutter_demo/utils/status.dart';

class ThemeWidgetDemo extends StatefulWidget {
  const ThemeWidgetDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ThemeWidgetState();
  }
}

class _ThemeWidgetState extends State<ThemeWidgetDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _themeList,
      ),
    );
  }

  get _themeList => getColorList();

  List<Widget> getColorList() {
    List<Widget> list = [];
    for (var i in AppTheme.materialColors) {
      list.add(InkWell(
        child: Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 30,
          color: i,
        ),
        onTap: () {
          Status.value<AppTheme>(context)
              .changeThemeColor(AppTheme.materialColors.indexOf(i));
        },
      ));
    }
    return list;
  }
}
