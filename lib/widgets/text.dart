import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/widgets/summer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
class TextWidgetDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TextWidgetState();
  }
}

class _TextWidgetState extends State<TextWidgetDemo> {



 late  final ui.Image image;
 bool isOk = false;

 String infoText = "端午节吃粽子由来,相传,这些民俗活动是为纪念伟大的爱国诗人屈原的。屈原是楚国三闾大夫、诗人,由于奸臣诽谤,昏庸的楚王不但不采纳他联齐抗秦的主张,反而放逐了他。"
     "公元前278年,秦军攻破楚国的国都。相传,屈原投汨罗江后,当地百姓闻讯马上划船捞救,一直行至洞庭湖,始终不见屈原的尸体。"
     " 为了寄托哀思,楚国百姓哀痛异常,纷纷涌到汨罗江边去凭吊屈原。渔夫们划起船只,在江上来回打捞他的真身。"
     "有位渔夫拿出为屈原准备的饭团、鸡蛋等食物,“扑通、扑通”地丢进江里,说是让鱼龙虾蟹吃饱了,就不会去咬屈大夫的身体了。"
     "人们见后纷纷仿效。一位老医师则拿来一坛雄黄酒倒进江里,说是要药晕蛟龙水兽,以免伤害屈大夫。后来为怕饭团为蛟龙所食,人们想出用楝树叶包饭,外缠彩丝,发展成棕子。"
     "历史上关于粽子的记载,最早见于汉代许慎的《说文解字》。"
     "“粽”字本作“糵”,芦叶裹米也。从米,葼声。西汉把粽子做为最早出现的端午时食,应属“枭羹”。"
     "《史记》“孝武本纪”注引如淳言:“汉使东郡送枭,五月五日为枭羹以赐百官。以恶鸟,故食之”。"
     "大约因为枭不易捕捉,所以吃枭羹的习俗并没有持续下来。锉是端午的主角-粽子,在稍晚的东汉就已出现。"
     "一直要到晋朝,粽子才成为端午的应节食品。粽子应该算得上是中国历史上迄今为止文化积淀最深厚的传统食品了。";
 ScrollController _controller = ScrollController();

 
  @override
  void initState() {
    super.initState();
    loadImageInAssets("images/duanwu.webp")?.then((value) {
      setState(() {
        isOk = true;
        image = value;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.all(20),
    //   child: Column(
    //     children: [
    //       Text(
    //         "文本属性倾斜",
    //         textAlign: TextAlign.left,
    //         style: TextStyle(fontStyle: FontStyle.italic),
    //       ),
    //       Text(
    //         "文本属性加粗",
    //         style: TextStyle(
    //           fontWeight: FontWeight.w800,
    //         ),
    //       ),
    //       Text(
    //         "\n文本属性上划线",
    //         style: TextStyle(
    //           decoration: TextDecoration.overline,
    //         ),
    //       ),
    //       Text(
    //         "文本属性下划线",
    //         style: TextStyle(
    //           decoration: TextDecoration.underline,
    //         ),
    //       ),
    //       Text(
    //         "文本属性删除线",
    //         style: TextStyle(
    //           decoration: TextDecoration.lineThrough,
    //         ),
    //       ),
    //       Text(
    //         "文本属性超出一行文本属性超出一行文本属性超出一行省略",
    //         maxLines: 1,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //       Text.rich(TextSpan(children: [
    //         TextSpan(text: "文本属性"),
    //         TextSpan(
    //             text: "展示不同效果",
    //             style: TextStyle(
    //               color: Colors.blue,
    //               decoration: TextDecoration.lineThrough,
    //             ))
    //       ])),
    //       Text.rich(TextSpan(children: [
    //         TextSpan(text: "github:"),
    //         TextSpan(
    //             text: "https://github.com/lixp185/flutter_demo",
    //             recognizer: TapGestureRecognizer()..onTap = () {
    //               _launchURL("https://github.com/lixp185/flutter_demo");
    //             },
    //             style: TextStyle(
    //               color: Colors.blue,
    //               decoration: TextDecoration.underline,
    //             ))
    //       ])),
    //     ],
    //   ),
    // );

    return isOk?Container(
      child: Stack(
        children: [
          Summer(image: image),

          SingleChildScrollView(
            controller: _controller,
            child: Container(child: Text(infoText,style: TextStyle(fontSize: 16,color: Colors.black87),),width: 220,),
          ),
          ElevatedButton(onPressed: (){
            _controller.animateTo(5000, duration: Duration(milliseconds: 3000), curve: Curves.easeIn);

          }, child: Text("111"))
        ],
      ),
    ):SizedBox();
  }

  Future<ui.Image>? loadImageInAssets(String assetsName) async {
    return decodeImageFromList(
        (await rootBundle.load(assetsName)).buffer.asUint8List());
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}

/// 常用text属性
/// textAlign: TextAlign.center, //文本对齐方式  居中
/// textDirection: TextDirection.ltr, //文本方向
/// softWrap: false, //是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
/// overflow: TextOverflow.ellipsis, //文字超出屏幕之后的处理方式
///           TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
/// textScaleFactor: 2.0, //字体显示的赔率
/// maxLines: 10, //最大行数
/// style:TextStyle(
///   decorationColor: const Color(0xffffffff), //线的颜色
///   decoration: TextDecoration
///               .none, //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
///   decorationStyle: TextDecorationStyle
///       .solid, //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
///   wordSpacing: 0.0, //单词间隙(负值可以让单词更紧凑)
///   letterSpacing: 0.0, //字母间隙(负值可以让字母更紧凑)
///   fontStyle: FontStyle.italic, //文字样式，斜体和正常
///   fontSize: 20.0, //字体大小
///   fontWeight: FontWeight.w900, //字体粗细  粗体和正常
///   color: const Color(0xffffffff), //文字颜色
