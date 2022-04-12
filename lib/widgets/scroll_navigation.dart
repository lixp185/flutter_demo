import 'package:flutter/material.dart';
import 'package:flutter_demo/models/name_bean.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'qi_pao.dart';

/// 滚动导航条
class ScrollNavigation extends StatefulWidget {
  const ScrollNavigation({Key? key}) : super(key: key);

  @override
  _ScrollNavigationState createState() => _ScrollNavigationState();
}

class _ScrollNavigationState extends State<ScrollNavigation> {
  List<String> _az = [
    "☆",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "G",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "#",
  ];

  List<String> _data = [
    "啊啊",
    "啊啊",
    "啊啊",
    "啊啊",
    "啊啊",
    "版本",
    "版本",
    "版本",
    "版本",
    "版本",
    "版本",
    "版本",
    "长城",
    "长城",
    "长城",
    "长城",
    "长城",
    "订单",
    "订单",
    "订单",
    "订单",
    "订单",
    "嗯嗯",
    "嗯嗯",
    "嗯嗯",
    "嗯嗯",
    "嗯嗯",
    "方法",
    "方法",
    "方法",
    "方法",
    "方法",
    "哈哈",
    "哈哈",
    "哈哈",
    "哈哈",
    "哈哈",
    "iuuuuu",
    "iuuuuu",
    "iuuuuu",
    "iuuuuu",
    "广告",
    "广告",
    "广告",
    "广告",
    "广告",
    "看看",
    "看看",
    "看看",
    "看看",
    "老李",
    "老李",
    "老李",
    "老李",
    "密码",
    "密码",
    "密码",
    "密码",
    "密码",
    "那你",
    "那你",
    "那你",
    "那你",
    "那你",
    "哦哦",
    "哦哦",
    "哦哦",
    "哦哦",
    "哦哦",
    "品牌",
    "品牌",
    "品牌",
    "品牌",
    "全球",
    "全球",
    "全球",
    "全球",
    "全球",
    "人人",
    "搜索",
    "天天",
    "uuu",
    "uuu",
    "uuu",
    "vvv11",
    "问问",
    "问问",
    "问问",
    "信息",
    "信息",
    "信息",
    "应用",
    "应用",
    "应用",
    "这周",
    "这周",
    "这周",
    "大当家",
    "大当家",
    "大当家",
    "大当家",
    "二当家",
    "二当家",
    "二当家",
    "二当家",
    "陈庚",
    "陈庚",
    "陈庚",
    "山本",
    "山本",
    "山本",
    "山本",
    "李云龙",
    "李云龙",
    "李云龙",
    "丁伟",
    "vvv"
    "vvv"
  ];

  int currentIndex = -1;

  var dataList = <NameBean>[];

  @override
  void initState() {
    super.initState();
    for (var h in _az) {
      var nameBean = NameBean();
      var listName = <Name>[];
      if (h == "☆") {
        nameBean.initial = "星标朋友";
        listName.add(Name(name: "李云龙"));
        listName.add(Name(name: "孔捷"));
      } else {
        nameBean.initial = h;
      }
      for (var i in _data) {
        // 李云龙 lyl
        var pinyin = PinyinHelper.getShortPinyin(i);
        var firstPy = pinyin.substring(0, 1).toUpperCase();
        if (h == firstPy) {
          listName.add(Name(name: i));
        }
      }
      nameBean.nameList = listName;
      dataList.add(nameBean);
    }
  }

  late ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: ScrollablePositionedList.builder(
          physics: BouncingScrollPhysics(),
          itemScrollController: _scrollController,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: Text(dataList[index].initial ?? ""),
                  color: Colors.grey.shade300,
                  height: 30,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(start: 15),
                  child: ListView.builder(
                    // 禁用滑动事件
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, cityIndex) {
                      return InkWell(
                        child: Container(
                          height: 40,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(dataList[index]
                                          .nameList?[cityIndex]
                                          .name ??
                                      ""),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              Divider(
                                height: 0.5,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      );
                    },
                    itemCount: dataList[index].nameList?.length,
                  ),
                )
              ],
            );
          },
          itemCount: dataList.length,
        )),
        Positioned(
            right: 0,
            top: currentIndex != -1 ? 20.0 * currentIndex - 10 : 0,
            child: Visibility(
              child: currentIndex != -1
                  ? QiPao(
                      text: _az[currentIndex],
                    )
                  : SizedBox(),
              visible: currentIndex != -1,
            )),
        Positioned(
          child: GestureDetector(
            child: Container(
                margin: EdgeInsetsDirectional.only(top: 40),// 这里
                width: 40,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color:
                                currentIndex == index ? Colors.redAccent : null,
                            shape: BoxShape.circle),
                        child: Text(
                          _az[index],
                          style: TextStyle(
                            color: currentIndex == index
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _az.length,
                )),
            onVerticalDragDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              int i = (e.localPosition.dy-40) ~/ 20;
              _scrollController.jumpTo(index: i);
              setState(() {
                currentIndex = i;
              });
            },
            //手指滑动时会触发此回调
            onVerticalDragUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移
              int i = (e.localPosition.dy-40) ~/ 20;
              _az.length;
              if (i >= 0 && i <= _az.length - 1) {
                if (i != currentIndex) {
                  setState(() {
                    currentIndex = i;
                  });
                  print("滑动 ${_az[i]}");
                  _scrollController.jumpTo(index: i);
                }
              }
            },
            onTapUp: (e) {
              // 手指抬起
              setState(() {
                currentIndex = -1;
              });
            },
            onVerticalDragEnd: (e) {
              // 移动取消
              setState(() {
                currentIndex = -1;
              });
            },
          ),
          right: 0,
        )
      ],
    );
  }
}
