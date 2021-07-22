import 'package:flutter/material.dart';
import 'package:flutter_demo/models/app_theme.dart';
import 'package:flutter_demo/utils/status.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'util_widget.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //初始化底部导航
  var _bottomCurrentIndex = 0;
  int time = 0;
  late final PageController _pageController;
  late final List _pages;

  //底部导航数据
  final _bottomNavigationList = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "基础"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "工具"),
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeWidget(),
      UtilWidget(),
    ];
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: myAppBar(),
          //保持页面状态
          body: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _bottomCurrentIndex = index;
              });
            },
            // 禁止滑动
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavigationList,
            onTap: (index) {
              if (index != _bottomCurrentIndex) {
                _pageController.jumpToPage(index);
              }
            },
            currentIndex: _bottomCurrentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 14,
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    if (time == 0) {
      time = DateTime.now().microsecondsSinceEpoch;
      Fluttertoast.showToast(msg: "再次按返回退出应用");
      return false;
    } else {
      if (DateTime.now().microsecondsSinceEpoch - time < 2000 * 1000) {
        return true;
      } else {
        time = DateTime.now().microsecondsSinceEpoch;
        Fluttertoast.showToast(msg: "再次按返回退出应用");
        return false;
      }
    }
  }

  void _chaneTheme() {
    if (Status.value<AppTheme>(context).isDark) {
      Fluttertoast.showToast(msg: "深色模式不支持修改主题", gravity: ToastGravity.CENTER);
      return null;
    }
    // 弹窗更改UI
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "更改主题",
              textAlign: TextAlign.center,
            ),
            children: _themeList,
          );
        });
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
          Navigator.of(context).pop();
          Status.value<AppTheme>(context)
              .changeThemeColor(AppTheme.materialColors.indexOf(i));
        },
      ));
    }
    return list;
  }
  AppBar myAppBar() {
    return AppBar(
      title: Text("Flutter Demo"),
      centerTitle: true,
      elevation: 1,
      leading: Icon(Icons.arrow_back),
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
            icon: Icon(Icons.wb_sunny),
            tooltip: "search", //辅助显示
            onPressed: () {
              // 设置主题
              if (Status.value<AppTheme>(context).isDark) {
                Status.value<AppTheme>(context).changeDark(false);
              } else {
                Status.value<AppTheme>(context).changeDark(true);
              }
            }),
        Container(
            margin: EdgeInsets.only(left: 0),
            child: IconButton(icon: Icon(Icons.style), onPressed: _chaneTheme))
      ],
    );
  }
}
