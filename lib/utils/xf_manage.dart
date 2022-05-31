import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_demo/models/xf_res.dart';
import 'package:flutter_demo/models/xf_text_req.dart';
import 'package:flutter_demo/utils/xf_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';

/// 讯飞配置类
class XfManage {
  String _host = "tts-api.xfyun.cn";
  String _appId = "83836aa0";
  String _apiKey = "445f5702911ec04cfc9155e1350b2a53";
  String _apiSecret = "Y2M5OTI1MmZjY2NkNWYzZWY5OGJkMDRk";


  // DateTime _start;
  // DateTime _end;

  ///关闭连接
  close() {
    log('关闭连接');
    _channel?.sink.close();
  }

  IOWebSocketChannel? _channel;

  /// 创建连接
  /// data 需要转化的音频的字节数组
  /// listen 转化完成后的回调
  XfManage.connect(String data) {
    String u = getAuthUrl(_host, _apiKey, _apiSecret);
    print('创建连接$u');
    _channel?.sink.close();
    _channel = IOWebSocketChannel.connect(u);
    //创建监听
    _channel?.stream.listen((message) {
      _onMessage(message);
    }, onError: (e) {
      print(" init error $e");
    });

    //文字转语音
    send(data);
  }

  void _onMessage(dynamic data) {
    print("result = $data");
    var xfRes = XfRes.fromJson(jsonDecode(data));
    var decode = base64.decode(xfRes.data!.audio!);
    print("result222 = $decode");

    _writeCounter(decode);
  }

  /// 获取文件路径
  Future<String>  _getLocalFileDir() async {
    Directory? tempDir = await getExternalStorageDirectory();
    return tempDir!.path;
  }

  /// 获取文件
  Future<File> _getLocalFile() async {
    String dir = await _getLocalFileDir();
    return File("$dir/zongzikepu.mp3");
  }


  /// 写入内容
  void _writeCounter(Uint8List decode) async {
    File file = await _getLocalFile();
    file.writeAsBytes(decode, mode: FileMode.write).then((value) {
      print("result :value");
    });
  }

  ///语音转文字
  send(String text) {
    XfTextReq xfTextReq = XfTextReq();

    ///设置appId
    Common common = Common();
    common.appId = _appId;
    xfTextReq.common = common;

    Business business = Business();
    business.aue = "lame"; // 音频编码
    business.tte = "UTF8";
    business.ent = "intp65";
    business.pitch = 50;
    business.speed = 40;
    business.vcn = "x3_doudou";
    business.volume = 50; //音量
    business.sfl = 0;
    business.auf = "audio/L16;rate=16000";
    business.bgs = 0;
    business.reg = "0";
    business.rdn = "0";
    xfTextReq.business = business;
    DataReq dataReq = DataReq();
    dataReq.status = 2; //固定
    dataReq.text = base64.encode(utf8.encode(text));
    xfTextReq.data = dataReq;

    // print("input == ${jsonEncode(xfTextReq)}");
    // print("input2 == ${requestJson}");
    _channel?.sink.add(jsonEncode(xfTextReq));
    // _channel?.sink.add(requestJson);
  }


}

bool isDebug = true;

///日志
log(dynamic msg) {
  if (isDebug) {
    print('$msg');
  }
}
