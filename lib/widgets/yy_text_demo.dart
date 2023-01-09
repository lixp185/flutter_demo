import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

/// 作者： lixp
/// 创建时间： 2022/6/13 13:47
/// 类介绍：语音识别 (1分钟即时转换)
class YYTextDemo extends StatefulWidget {
  const YYTextDemo({Key? key}) : super(key: key);

  @override
  _YYTextDemoState createState() => _YYTextDemoState();
}

class _YYTextDemoState extends State<YYTextDemo> {
  // final FlutterSoundRecorder _mRecorder = FlutterSoundRecorder();
  //
  // late final StreamController<Food> recordingDataController =
  //     StreamController<Food>();

  @override
  void initState() {
    super.initState();
    // init();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // throw RecordingPermissionException('Microphone permission not granted');
    }
    // await _mRecorder.openRecorder();

    // recordingDataController.stream.listen((buffer) {
    //   if (buffer is FoodData) {
    //     print("data ${buffer.data}");
    //   }
    // });
    //用户允许使用麦克风之后开始录音
    Directory tempDir = await getTemporaryDirectory();
    // var time = DateTime.now().millisecondsSinceEpoch;
    // String path = '${tempDir.path}/$time${ext[Codec.aacADTS.index]}';
    // await _mRecorder.startRecorder(
    //   toFile: path,
    //   codec: Codec.aacADTS,
    //   bitRate: 8000,
    //   numChannels: 1,
    //   sampleRate: 8000,
    //   // toStream: recordingDataController.sink,
    // );
  }

  @override
  void dispose() {
    super.dispose();
    // recordingDataController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onLongPressStart: (d) {
        print("长按开始");
        openTheRecorder();
      },
      onLongPressEnd: (d) {
        print("长安结束");
        // _mRecorder.closeRecorder();
      },
      child: Container(
        color: Colors.blue,
        padding: EdgeInsetsDirectional.all(20),
        child: Text("按住讲话"),
      ),
    ));
  }

  Future<void> init() async {
    await openTheRecorder();
  }
}
