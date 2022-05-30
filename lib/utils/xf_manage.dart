import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_demo/models/xf_res.dart';
import 'package:flutter_demo/utils/xf_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';

/// 讯飞配置类
class XfManage {

  String _host = "tts-api.xfyun.cn";
  String _appId = "83836aa0";
  String _apiKey = "445f5702911ec04cfc9155e1350b2a53";
  String _apiSecret = "Y2M5OTI1MmZjY2NkNWYzZWY5OGJkMDRk";
  IOWebSocketChannel? _channel;

  // DateTime _start;
  // DateTime _end;

  ///关闭连接
  close() {
    log('关闭连接');
    _channel?.sink.close();
  }

  /// 创建连接
  /// data 需要转化的音频的字节数组
  /// listen 转化完成后的回调
  XfManage.connect(this._host, this._apiKey, this._apiSecret, this._appId,
      String data, void Function(String msg) listen) {
    String u = getAuthUrl(_host, _apiKey, _apiSecret);
    log('创建连接$u');
    _channel?.sink.close();
    _channel = IOWebSocketChannel.connect(u);
    //创建监听
    _channel?.stream.listen((message) {
      _onMessage(message, listen);
    }, onError: (e) {
      log(" init error $e");
    });
    //文字转语音
    send(data);
  }

  void _onMessage(dynamic data, void Function(String msg) listen) {
    ///

    log("result = $data");
    var xfRes = XfRes.fromJson(jsonDecode(data));
    var decode = base64.decode(xfRes.data!.audio!);
    log("result222 = $decode");

    _writeCounter(decode);
    listen(data);
  }

  /// 获取文件路径
  Future<String> _getLocalFileDir() async {
    Directory? tempDir = await getExternalStorageDirectory();
    return tempDir!.path;
  }

  /// 获取文件
  Future<File> _getLocalFile() async {
    String dir = await _getLocalFileDir();
    return File("$dir/test.mp3");
  }

  AudioPlayer audioPlayer = AudioPlayer();

  /// 写入内容
  void _writeCounter(Uint8List decode) async {
    File file = await _getLocalFile();
    file.writeAsBytes(decode, mode: FileMode.write).then((value) {
      print("rrr = $value");
      // audioPlayer.playBytes(decode);

      _playAudio(decode, value);
    });
  }

  ///语音转文字
  send(String text) {
    var codeUnits = utf8.encode("");
    String requestJson = "{\n" +
        "  \"common\": {\n" +
        "    \"app_id\": \"" +
        _appId +
        "\"\n" +
        "  },\n" +
        "  \"business\": {\n" +
        "    \"aue\": \"lame\",\n" +
        "    \"tte\": \"" +
        'UTF8' +
        "\",\n" +
        "    \"ent\": \"intp65\",\n" +
        "    \"vcn\": \"" +
        'xiaoyan' +
        "\",\n" +
        "    \"pitch\": 50,\n" +
        "    \"speed\": 50\n" +
        "  },\n" +
        "  \"data\": {\n" +
        "    \"status\": 2,\n" +
        "    \"text\": \"" +
        base64.encode(codeUnits) +
        "\"\n" +
        "  }\n" +
        "}";

    print("input == $requestJson");
    _channel?.sink.add(requestJson);
  }

  void _playAudio(Uint8List decode, File file) async {
    var i = await audioPlayer.play(file.path, isLocal: true);
    print("i == $i");
  }
}
bool isDebug = true;


///日志
log(dynamic msg) {
  if (isDebug) {
    print('$msg');
  }
}
