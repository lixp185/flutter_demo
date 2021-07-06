import 'package:flutter/material.dart';
import 'package:yht_meeting/models/app_theme.dart';
import 'package:yht_meeting/utils/status.dart';

class ThemeWidgetDemo extends StatefulWidget {
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
