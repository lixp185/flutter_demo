import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/toast_util.dart';
import 'package:flutter_demo/utils/xf_manage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

import 'summer.dart';

/// 粽子科普
class ZongZiKePu extends StatefulWidget {
  const ZongZiKePu({Key? key}) : super(key: key);

  @override
  _ZongZiKePuState createState() => _ZongZiKePuState();
}

class _ZongZiKePuState extends State<ZongZiKePu> with TickerProviderStateMixin {
  late Animation<double> animation; // 控制嘴巴
  late Animation<double> animation2; // 控制身体

  late AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1000)); //1s
  late AnimationController _controller2 = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1000)); //2s

  // 动画轨迹
  late CurvedAnimation cure = CurvedAnimation(
      parent: _controller, curve: Curves.bounceOut); // 动画运行的速度轨迹 速度的变化

  late CurvedAnimation cure2 = CurvedAnimation(
      parent: _controller2, curve: Curves.easeIn); // 动画运行的速度轨迹 速度的变化

  // 播放音频
  AudioPlayer audioPlayer = AudioPlayer();

  late final ui.Image image;
  bool isOk = false;
  ScrollController _sController = ScrollController();
  String infoText =
      "端午节吃粽子由来,相传,这些民俗活动是为纪念伟大的爱国诗人屈原的。屈原是楚国三闾大夫、诗人,由于奸臣诽谤,昏庸的楚王不但不采纳他联齐抗秦的主张,反而放逐了他。"
      "公元前278年,秦军攻破楚国的国都。相传,屈原投汨罗江后,当地百姓闻讯马上划船捞救,一直行至洞庭湖,始终不见屈原的尸体。"
      " 为了寄托哀思,楚国百姓哀痛异常,纷纷涌到汨罗江边去凭吊屈原。渔夫们划起船只,在江上来回打捞他的真身。"
      "有位渔夫拿出为屈原准备的饭团、鸡蛋等食物,“扑通、扑通”地丢进江里,说是让鱼龙虾蟹吃饱了,就不会去咬屈大夫的身体了。"
      "人们见后纷纷仿效。一位老医师则拿来一坛雄黄酒倒进江里,说是要药晕蛟龙水兽,以免伤害屈大夫。后来为怕饭团为蛟龙所食,人们想出用楝树叶包饭,外缠彩丝,发展成棕子。"
      "历史上关于粽子的记载,最早见于汉代许慎的《说文解字》。"
      "“粽”字本作“糵”,芦叶裹米也。从米,葼声。西汉把粽子做为最早出现的端午时食,应属“枭羹”。"
      "《史记》“孝武本纪”注引如淳言:“汉使东郡送枭,五月五日为枭羹以赐百官。以恶鸟,故食之”。"
      "大约因为枭不易捕捉,所以吃枭羹的习俗并没有持续下来。锉是端午的主角-粽子,在稍晚的东汉就已出现。"
      "一直要到晋朝,粽子才成为端午的应节食品。粽子应该算得上是中国历史上迄今为止文化积淀最深厚的传统食品了。";

  void _playAudio(File file) async {
    var i = await audioPlayer.play(DeviceFileSource(file.path,));

    // audioPlayer.getDuration().then((value) {
    //   print("时长：$value");
    //   _sController.animateTo(2000,
    //       duration: Duration(milliseconds: 1000 * 20), curve: Curves.easeIn);
    // });
  }

  @override
  void initState() {
    super.initState();
    XfManage.connect(infoText);

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    loadImageInAssets("images/duanwu.webp")?.then((value) {
      setState(() {
        isOk = true;
        image = value;
      });
    });

    // 动画
    animation = Tween(begin: 0.0, end: 1.0).animate(cure);
    animation2 = Tween(begin: 0.0, end: 1.0).animate(cure2);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    _controller2.dispose();
    audioPlayer..stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOk
        ? Container(
            child: Stack(
              children: [
                Summer(
                    image: image,
                    animation: animation,
                    animation2: animation2,
                    listenable: Listenable.merge([
                      animation,
                      animation2,
                    ])),
                SingleChildScrollView(
                  controller: _sController,
                  child: Container(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600),
                    ),
                    width: 300,
                  ),
                ),
                Positioned(
                  right: 40,
                  bottom: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        if (audioPlayer.state == PlayerState.playing) {
                          ToastUtil.show("正在播放中");
                          return;
                        }
                        _getLocalFile().then((file) {
                          // 启动动画 正向执行
                          _controller.repeat(reverse: true);
                          // 启动动画 0-1循环执行
                          _controller2.repeat(reverse: true);
                          _sController.animateTo(
                              MediaQuery.of(context).size.height + 1000,
                              duration: Duration(milliseconds: 1000 * 100),
                              curve: Curves.easeIn);
                          if (file.existsSync()) {
                            _playAudio(file);
                          } else {
                            ToastUtil.show("音频正在加载,请稍后");
                          }
                        });
                      },
                      child: Text("播放")),
                )
              ],
            ),
          )
        : SizedBox();
  }

  Future<ui.Image>? loadImageInAssets(String assetsName) async {
    return decodeImageFromList(
        (await rootBundle.load(assetsName)).buffer.asUint8List());
  }

  /// 获取文件路径
  Future<String> _getLocalFileDir() async {
    Directory? tempDir = await getExternalStorageDirectory();
    return tempDir!.path;
  }

  /// 获取文件
  Future<File> _getLocalFile() async {
    String dir = await _getLocalFileDir();
    return File("$dir/zongzikepu.mp3");
  }
}
